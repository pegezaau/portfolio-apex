public with sharing class PedidoController {
    public class PedidoDTO {
        @AuraEnabled public Id id;
        @AuraEnabled public String numero;
        @AuraEnabled public String status;
        @AuraEnabled public Decimal total;
        @AuraEnabled public Date dataPedido;
        public PedidoDTO(Order o) {
            this.id = o.Id; this.numero = o.OrderNumber; this.status = o.Status;
            this.total = o.TotalAmount; this.dataPedido = o.EffectiveDate;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<PedidoDTO> listarPedidos(Id accountId) {
        if (accountId == null) throw new AuraHandledException('Informe a conta.');
        List<PedidoDTO> resultado = new List<PedidoDTO>();
        for (Order o : [SELECT Id, OrderNumber, Status, TotalAmount, EffectiveDate
                         FROM Order WHERE AccountId = :accountId
                         ORDER BY EffectiveDate DESC LIMIT 50]) {
            resultado.add(new PedidoDTO(o));
        }
        return resultado;
    }

    @AuraEnabled(cacheable=true)
    public static Decimal totalVendido(Id accountId) {
        AggregateResult[] soma = [SELECT SUM(TotalAmount) total FROM Order WHERE AccountId = :accountId AND Status = 'Activated'];
        Decimal total = (Decimal) soma[0].get('total');
        return total != null ? total : 0;
    }
}
