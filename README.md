# Portfólio de Programação — Salesforce Apex ☁️

Olá! Eu sou o **Pedro** ([@pegezaau](https://github.com/pegezaau)) e este é meu portfólio de projetos em **Apex (Salesforce)**.

São 5 projetos que demonstram boas práticas da plataforma: código *bulkified*, separação Trigger → Handler → Service, testes com cobertura, integrações REST com mock, Batch Apex e um Lightning Web Component (LWC) completo, de ponta a ponta.

## 📂 Projetos

| # | Projeto | O que demonstra |
|---|---------|-----------------|
| 01 | [Trigger de Gerenciamento de Contas](01-trigger-gerenciamento-contas/) | Trigger + Handler, bulkificação, validações |
| 02 | [Integração REST — Consulta de Clima](02-integracao-rest-clima/) | HttpCallout, JSON, HttpCalloutMock em testes |
| 03 | [Batch de Oportunidades Vencidas](03-batch-oportunidades-vencidas/) | Database.Batchable, Schedulable, processamento em lote |
| 04 | [Serviço de Pedidos para LWC](04-servico-pedidos-lwc/) | Controller `@AuraEnabled`, SOQL seguro, DTOs |
| 05 | [LWC real: Lista de Pedidos](05-lwc-lista-pedidos/) | Componente LWC completo: tabela, busca, total vendido, estados de erro/vazio e teste Jest |

## 🛠️ Boas práticas aplicadas
- Nenhuma SOQL/DML dentro de loops
- Triggers enxutas: lógica no Handler/Service
- Classes de teste com `Test.startTest()` / `Test.stopTest()` e dados isolados
- Tratamento de exceções e mensagens claras ao usuário
- Estrutura compatível com Salesforce DX (`sfdx-project.json`)

## 📄 Licença
MIT — veja [LICENSE](LICENSE).
