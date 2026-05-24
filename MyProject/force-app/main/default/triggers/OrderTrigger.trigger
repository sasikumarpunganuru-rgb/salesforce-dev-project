trigger OrderTrigger on Order (after update) {
    /*for (Order ord : Trigger.new) {
        Order oldOrd = Trigger.oldMap.get(ord.Id);
        if (ord.Status == 'Activated' && oldOrd.Status != 'Activated') {
            OrderEventPublisher.publishOrderEvent(ord);
        }
    }*/
    if(trigger.isUpdate && Trigger.isAfter)
    {
        OrderEventPublisher.publishOrderEvent(Trigger.new,Trigger.oldMap);
    }
}