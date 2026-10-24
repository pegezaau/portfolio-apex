# 03 — Batch de Oportunidades Vencidas

`OportunidadesVencidasBatch` encontra oportunidades abertas com `CloseDate` vencida, marca como `Closed Lost` e pode ser agendado com `OportunidadesVencidasScheduler`.

```apex
// Executar manualmente
Database.executeBatch(new OportunidadesVencidasBatch(), 200);
// Agendar diariamente às 2h
System.schedule('Oportunidades Vencidas - Diário', '0 0 2 * * ?', new OportunidadesVencidasScheduler());
```
