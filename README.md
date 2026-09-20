# SGC — Sistema de Gerenciamento de Construção

Projeto acadêmico que demonstra um processo de **Sistema de Gerenciamento de Construção (SGC)** integrado a um **Sistema de Controle de Versões (SCV)** usando Git.


1. **Geração de script de construção** — `build.sh`
2. **Integração com o SCV** — Git, identificação da branch, commit e linha de base
3. **Re-compilação mínima** — Maven verifica timestamps e recompila apenas o necessário
4. **Criação do sistema executável** — gera `target/sgc-construcao.jar`
5. **Automação de testes** — JUnit 5 + Maven Surefire
6. **Relatórios** — relatório HTML simples + relatório de testes Surefire
7. **Geração de documentação** — Javadoc em `docs/api`
