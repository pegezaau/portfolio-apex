public with sharing class OportunidadesVencidasBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, StageName, CloseDate FROM Opportunity
            WHERE IsClosed = false AND CloseDate < TODAY
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        for (Opportunity opp : scope) {
            opp.StageName = 'Closed Lost';
            opp.Description = 'Fechada automaticamente: data de fechamento vencida em ' + String.valueOf(opp.CloseDate);
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch de oportunidades vencidas finalizado.');
    }
}
