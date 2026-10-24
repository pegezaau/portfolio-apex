@isTest
private class OportunidadesVencidasBatchTest {
    @isTest static void deveFecharOportunidadesVencidas() {
        Account acc = new Account(Name = 'Conta Batch'); insert acc;
        insert new Opportunity(Name = 'Vencida', AccountId = acc.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(-5));
        insert new Opportunity(Name = 'Futura', AccountId = acc.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(10));
        Test.startTest();
        Database.executeBatch(new OportunidadesVencidasBatch(), 200);
        Test.stopTest();
        Opportunity vencida = [SELECT StageName FROM Opportunity WHERE Name = 'Vencida'];
        Opportunity futura = [SELECT StageName FROM Opportunity WHERE Name = 'Futura'];
        System.assertEquals('Closed Lost', vencida.StageName);
        System.assertEquals('Prospecting', futura.StageName);
    }
}
