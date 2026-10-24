@isTest
private class PedidoControllerTest {
    @TestSetup static void setup() {
        Account acc = new Account(Name = 'Conta Pedidos'); insert acc;
        insert new Order(AccountId = acc.Id, EffectiveDate = Date.today(), Status = 'Draft', Pricebook2Id = Test.getStandardPricebookId());
    }

    @isTest static void deveListarPedidosDaConta() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<PedidoController.PedidoDTO> pedidos = PedidoController.listarPedidos(acc.Id);
        Decimal total = PedidoController.totalVendido(acc.Id);
        Test.stopTest();
        System.assertEquals(1, pedidos.size());
        System.assertNotEquals(null, total);
    }
}
