#!/usr/bin/env bash
set -e

PROJECT_NAME="SGC - Sistema de Gerenciamento de Construção"
REPORT_DIR="reports"
DOC_DIR="docs/api"
JAR="target/sgc-construcao.jar"

mkdir -p "$REPORT_DIR"

echo "=============================================="
echo "$PROJECT_NAME"
echo "=============================================="

# 1. Integração com o SCV (Git)
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current)
    COMMIT=$(git rev-parse --short HEAD)
    BASELINE=$(git describe --tags --exact-match HEAD 2>/dev/null || echo "Não definida")
else
    BRANCH="SCV não disponível"
    COMMIT="N/A"
    BASELINE="N/A"
fi

echo "Branch: $BRANCH"
echo "Commit: $COMMIT"
echo "Linha de base: $BASELINE"

# 2. Testes + 3. Re-compilação mínima + 4. Executável
echo
echo "[1/4] Executando testes e construção..."
mvn -q clean test package

# 5. Documentação
echo
echo "[2/4] Gerando documentação Javadoc..."
mvn -q javadoc:javadoc

# 6. Relatório do SGC
echo
echo "[3/4] Gerando relatório..."

TEST_RESULT="SUCESSO"
if [ ! -f "$JAR" ]; then
    TEST_RESULT="FALHA"
fi

cat > "$REPORT_DIR/build-report.html" <<EOF
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<title>Relatório SGC</title>
<style>
body { font-family: Arial, sans-serif; margin: 40px; }
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
th { background: #eee; }
</style>
</head>
<body>
<h1>Relatório de Construção — SGC</h1>
<table>
<tr><th>Item</th><th>Resultado</th></tr>
<tr><td>Projeto</td><td>$PROJECT_NAME</td></tr>
<tr><td>Branch Git</td><td>$BRANCH</td></tr>
<tr><td>Commit</td><td>$COMMIT</td></tr>
<tr><td>Linha de base</td><td>$BASELINE</td></tr>
<tr><td>Testes / Build</td><td>$TEST_RESULT</td></tr>
<tr><td>Executável</td><td>$JAR</td></tr>
<tr><td>Documentação</td><td>$DOC_DIR/index.html</td></tr>
</table>
<p>Relatório gerado automaticamente pelo script build.sh.</p>
</body>
</html>
EOF

echo
echo "[4/4] Construção concluída."
echo "JAR: $JAR"
echo "Relatório: $REPORT_DIR/build-report.html"
echo "Javadoc: $DOC_DIR/index.html"
