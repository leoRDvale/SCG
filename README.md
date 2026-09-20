# SGC — Sistema de Gerenciamento de Construção

Projeto acadêmico que demonstra um processo de **Sistema de Gerenciamento de Construção (SGC)** integrado a um **Sistema de Controle de Versões (SCV)** usando Git.


1. **Geração de script de construção** — `build.sh`
2. **Integração com o SCV** — Git, identificação da branch, commit e linha de base
3. **Re-compilação mínima** — Maven verifica timestamps e recompila apenas o necessário
4. **Criação do sistema executável** — gera `target/sgc-construcao.jar`
5. **Automação de testes** — JUnit 5 + Maven Surefire
6. **Relatórios** — relatório HTML simples + relatório de testes Surefire
7. **Geração de documentação** — Javadoc em `open target/site/apidocs/index.html`


<img width="1523" height="462" alt="Captura de Tela 2026-09-20 às 11 33 27" src="https://github.com/user-attachments/assets/9056669d-b9a2-4825-9ebe-807a34bcaaa4" />
