public with sharing class AccountTriggerHandler {
    public void run() {
        if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
            beforeSave((List<Account>) Trigger.new);
        }
        if (Trigger.isBefore && Trigger.isDelete) {
            beforeDelete((Map<Id, Account>) Trigger.oldMap);
        }
    }

    private void beforeSave(List<Account> accounts) {
        for (Account acc : accounts) {
            if (String.isNotBlank(acc.Name)) acc.Name = acc.Name.trim();
            if (acc.AnnualRevenue != null && acc.AnnualRevenue >= 1000000) {
                acc.Industry = 'Enterprise';
            } else if (acc.AnnualRevenue != null && acc.AnnualRevenue >= 100000) {
                acc.Industry = 'Mid-Market';
            }
            if (String.isBlank(acc.Name)) {
                acc.addError('Toda conta precisa de um nome.');
            }
        }
    }

    private void beforeDelete(Map<Id, Account> oldMap) {
        Set<Id> accountIds = oldMap.keySet();
        // Uma única SOQL fora do loop (bulkificado)
        Set<Id> blocked = new Set<Id>();
        for (Opportunity opp : [SELECT AccountId FROM Opportunity WHERE AccountId IN :accountIds AND IsClosed = false]) {
            blocked.add(opp.AccountId);
        }
        for (Id accId : accountIds) {
            if (blocked.contains(accId)) {
                oldMap.get(accId).addError('Não é possível excluir conta com oportunidades abertas.');
            }
        }
    }
}
