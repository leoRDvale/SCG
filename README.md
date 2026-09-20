# SGC — Sistema de Gerenciamento de Construção

Projeto acadêmico que demonstra um processo de **Sistema de Gerenciamento de Construção (SGC)** integrado a um **Sistema de Controle de Versões (SCV)** usando Git e Maven.

## Tarefas atendidas

1. **Geração de script de construção** — `build.sh`
2. **Integração com o SCV** — Git, identificação da branch, commit e linha de base
3. **Re-compilação mínima** — Maven verifica timestamps e recompila apenas o necessário
4. **Criação do sistema executável** — gera `target/sgc-construcao.jar`
5. **Automação de testes** — JUnit 5 + Maven Surefire
6. **Relatórios** — relatório HTML simples + relatório de testes Surefire
7. **Geração de documentação** — Javadoc em `docs/api`

## Pré-requisitos

- Java 17+
- Maven 3.9+
- Git

## Execução

```bash
chmod +x build.sh
./build.sh
```

O script:

- verifica o repositório Git;
- registra branch, commit e tag/linha de base quando disponível;
- executa testes;
- compila de forma incremental;
- cria o JAR executável;
- gera Javadoc;
- cria um relatório em `reports/build-report.html`.

Para executar:

```bash
java -jar target/sgc-construcao.jar
```

## Re-compilação mínima

O Maven gerencia o ciclo de compilação e evita recompilar classes que não precisam ser atualizadas, comparando arquivos-fonte e artefatos gerados.

Para demonstrar:

```bash
./build.sh
./build.sh
```

Na segunda execução, o Maven normalmente informa que nada precisa ser recompilado.

## Linha de base

Uma linha de base pode ser representada por uma tag Git:

```bash
git tag baseline-1.0
git checkout baseline-1.0
./build.sh
```

O script registra essa identificação no relatório.

## Estrutura

```text
sgc/
├── pom.xml
├── build.sh
├── README.md
├── .gitignore
└── src/
    ├── main/java/br/edu/sgc/
    │   ├── App.java
    │   └── CalculadoraObra.java
    └── test/java/br/edu/sgc/
        └── CalculadoraObraTest.java
```
