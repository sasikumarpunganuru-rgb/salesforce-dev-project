public class OrderEventPublisher {
    public static void publishOrderEvent(List<order> ord, map<id,order> oldMap) {
        //List<Order> od=new List<Order>();
        for(order orde : ord)
        {
		if(orde.Status=='Activated' && oldMap.get(orde.id).status!='activated')
        {
           Order_Confirmed_Event__e evt = new Order_Confirmed_Event__e();
            evt.Order_Id__c = orde.Id;
            evt.Account_Name__c = orde.Account.Name;
            evt.Status__c = orde.Status;
            EventBus.publish(evt);
        }            
        }
        
       /* Order_Confirmed_Event__e evt = new Order_Confirmed_Event__e(
            Order_Id__c = ord.Id,
            Account_Name__c = ord.Account.Name,
            Status__c = ord.Status
        );*/
        //EventBus.publish(evt);
    }
}