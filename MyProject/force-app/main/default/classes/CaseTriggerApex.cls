public class CaseTriggerApex {
public static void CaseMethod(List<Case> CaseList)
{
    List<Account> accList=new List<Account>();
    for(Case Cas: CaseList)
    {
     Account acc=new Account();
        acc.id=Cas.AccountId;
        acc.Latest_Case_Number__c=Cas.CaseNumber;
        accList.add(acc);
    }
    if(!accList.isEmpty())
    {
        Update accList;
    }
}
}