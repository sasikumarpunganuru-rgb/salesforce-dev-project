public class AccountClass {
public static void BeforeDelete(List<Account> accList , Map<id,Account> MapList)
{
    Profile p=[select id from Profile where name ='System Administrator'];
    for(Account acc:accList)
    {
      if(UserInfo.getProfileID()==p.id)
      {
        Acc.addError('You dont have Sysadm Access please get the acccess or contact System Admin');  
      }
    }
}
}