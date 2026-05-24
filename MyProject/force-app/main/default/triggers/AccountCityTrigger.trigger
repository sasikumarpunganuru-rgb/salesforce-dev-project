trigger AccountCityTrigger on Account (after insert, after update) {
    List<Weather_Request__e> events = new List<Weather_Request__e>();
    for (Account acc : Trigger.new) {
        Account oldAcc = Trigger.isInsert ? null : Trigger.oldMap.get(acc.Id);

        if (acc.BillingCity != null &&
            (Trigger.isInsert || acc.BillingCity != oldAcc.BillingCity)) {
            events.add(new Weather_Request__e(
                AccountId__c = acc.Id,
                City__c = acc.BillingCity
            ));
        }
    }
    if (!events.isEmpty()) EventBus.publish(events);
}