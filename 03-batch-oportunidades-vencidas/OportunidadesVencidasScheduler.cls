public with sharing class OportunidadesVencidasScheduler implements Schedulable {
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new OportunidadesVencidasBatch(), 200);
    }
}
