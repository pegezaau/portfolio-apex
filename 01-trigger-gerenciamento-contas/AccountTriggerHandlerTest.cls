@isTest
private class AccountTriggerHandlerTest {
    @isTest static void deveClassificarContaEnterprise() {
        Account acc = new Account(Name = '  Empresa Grande  ', AnnualRevenue = 2000000);
        insert acc;
        acc = [SELECT Name, Industry FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Empresa Grande', acc.Name);
        System.assertEquals('Enterprise', acc.Industry);
    }

    @isTest static void deveImpedirExclusaoComOportunidadeAberta() {
        Account acc = new Account(Name = 'Cliente Teste');
        insert acc;
        insert new Opportunity(Name = 'Opp Teste', AccountId = acc.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30));
        Test.startTest();
        Database.DeleteResult result = Database.delete(acc, false);
        Test.stopTest();
        System.assertEquals(false, result.isSuccess());
    }
}
