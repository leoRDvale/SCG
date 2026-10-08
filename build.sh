#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="SGC - Sistema de Gerenciamento de Construção"
REPORT_DIR="reports"
DOC_DIR="docs/api"
JAR="target/sgc-construcao.jar"
STEP_LOG="$REPORT_DIR/steps.log"

mkdir -p "$REPORT_DIR"
: > "$STEP_LOG"

step() {
    local number="$1"
    local description="$2"
    echo "[$number] $description"
    echo "[$number] $description" >> "$STEP_LOG"
}

echo "=============================================="
echo "$PROJECT_NAME"
echo "=============================================="

# STEP 1 - SCV
step "1/7" "Verificação da integração com Git/SCV"
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current)
    COMMIT=$(git rev-parse --short HEAD)
    BASELINE=$(git describe --tags --exact-match HEAD 2>/dev/null || echo "Não definida")
else
    BRANCH="SCV não disponível"
    COMMIT="N/A"
    BASELINE="N/A"
fi

# STEP 2 - testes + compilação + pacote
step "2/7" "Execução dos testes unitários, compilação e criação do JAR"
mvn -q clean test package

# STEP 3 - relatório dos testes
step "3/7" "Geração do relatório HTML dos testes unitários"
mvn -q surefire-report:report

if [ -f "target/site/surefire-report.html" ]; then
    cp "target/site/surefire-report.html" "$REPORT_DIR/test-report.html"
else
    echo "ERRO: relatório de testes não foi encontrado." >&2
    exit 1
fi

# STEP 4 - documentação
step "4/7" "Geração da documentação Javadoc dos métodos públicos"
rm -rf "$DOC_DIR"
mvn -q javadoc:javadoc

if [ ! -f "$DOC_DIR/index.html" ]; then
    if [ -f "target/site/apidocs/index.html" ]; then
        mkdir -p "$DOC_DIR"
        cp -R target/site/apidocs/. "$DOC_DIR/"
    else
        echo "ERRO: documentação Javadoc não foi encontrada."
        echo "Verifique o resultado de: mvn javadoc:javadoc"
        exit 1
    fi
fi

# STEP 5 - validação do executável
step "5/7" "Validação do sistema executável"
if [ ! -f "$JAR" ]; then
    echo "ERRO: JAR não foi criado." >&2
    exit 1
fi

# STEP 6 - relatório dos steps
step "6/7" "Geração do relatório do workflow"

cat > "$REPORT_DIR/build-report.html" <<EOF
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<title>Relatório do Workflow - SGC</title>
<style>
body { font-family: Arial, sans-serif; margin: 40px; line-height: 1.5; }
table { border-collapse: collapse; width: 100%; margin-top: 20px; }
th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
th { background: #eee; }
.ok { font-weight: bold; }
code { background: #f3f3f3; padding: 2px 5px; }
</style>
</head>
<body>
<h1>Relatório do Workflow de Construção — SGC</h1>

<h2>Identificação do SCV</h2>
<table>
<tr><th>Item</th><th>Resultado</th></tr>
<tr><td>Branch</td><td>$BRANCH</td></tr>
<tr><td>Commit</td><td>$COMMIT</td></tr>
<tr><td>Linha de base</td><td>$BASELINE</td></tr>
</table>

<h2>Steps executados</h2>
<table>
<tr><th>Step</th><th>Status</th></tr>
<tr><td>1. Integração com Git/SCV</td><td class="ok">OK</td></tr>
<tr><td>2. Testes unitários + compilação + JAR</td><td class="ok">OK</td></tr>
<tr><td>3. Relatório HTML dos testes</td><td class="ok">OK</td></tr>
<tr><td>4. Documentação Javadoc</td><td class="ok">OK</td></tr>
<tr><td>5. Validação do executável</td><td class="ok">OK</td></tr>
<tr><td>6. Relatório do workflow</td><td class="ok">OK</td></tr>
</table>

<h2>Artefatos</h2>
<ul>
<li><code>target/sgc-construcao.jar</code></li>
<li><code>reports/test-report.html</code></li>
<li><code>docs/api/index.html</code></li>
</ul>

<p><strong>Resultado final: construção concluída com sucesso.</strong></p>
</body>
</html>
EOF

# STEP 7 - conclusão
step "7/7" "Workflow concluído com sucesso"

echo
echo "=============================================="
echo "BUILD CONCLUÍDO COM SUCESSO"
echo "=============================================="
echo "Executável : $JAR"
echo "Testes     : $REPORT_DIR/test-report.html"
echo "Workflow   : $REPORT_DIR/build-report.html"
echo "Javadoc    : $DOC_DIR/index.html"
