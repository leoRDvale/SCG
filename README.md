# SGC — Sistema de Gerenciamento de Construção

Projeto acadêmico demonstrando um processo de construção integrado a Git (SCV), Maven, JUnit e Javadoc.

## Requisitos atendidos

- Geração de script de construção
- Integração com SCV/Git
- Re-compilação mínima pelo Maven
- Criação de sistema executável
- Automação de testes unitários
- Relatório visual dos testes
- Relatório dos steps do workflow
- Geração de documentação Javadoc dos métodos públicos

## Execução no macOS/Linux

```bash
chmod +x build.sh
./build.sh
```

Ao final, abra:

```bash
open reports/test-report.html
open reports/build-report.html
open docs/api/index.html
```

No Windows, execute o projeto pelo Git Bash ou adapte o script.

## Artefatos gerados

```text
target/sgc-construcao.jar
reports/test-report.html
reports/build-report.html
docs/api/index.html
```

## Testes

Os testes unitários estão em:

```text
src/test/java/br/edu/sgc/CalculadoraObraTest.java
```

O Maven Surefire executa os testes e o Surefire Report gera uma página HTML com:

- quantidade de testes executados;
- testes aprovados;
- falhas;
- erros;
- testes ignorados;
- detalhes de cada classe de teste.

## Documentação

O Javadoc é gerado em `docs/api`. A documentação dos métodos públicos contém descrição, parâmetros (`@param`) e retorno (`@return`) quando aplicável.
