public class AccountConHandler {
public Static void AccountMethod(List<Account> acc, Map<id,Account> OldMap)
{
    Set<Id> accids=new Set<Id>();
    For(Account acc1: acc)
    {
        if(acc1.OppAmount__c!=null && acc1.OppAmount__c!=OldMap.get(Acc1.id).OppAmount__c)
        {
            accids.add(acc1.id);
        }
    }
}
}