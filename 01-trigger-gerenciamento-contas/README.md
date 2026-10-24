# 01 — Trigger de Gerenciamento de Contas

Trigger enxuta em `Account` que delega para `AccountTriggerHandler`: preenche segmento por receita anual, impede exclusão de contas com oportunidades abertas e normaliza o nome.

**Conceitos:** bulkificação, Handler pattern, `Trigger.newMap/oldMap`, testes.
