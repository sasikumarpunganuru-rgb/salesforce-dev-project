public class AccountTriggerClass {
    public static void AccountMethod(List<Account> accList, Map<id,Account> OldMap){
       Decimal Percentage=0; 
      for(Account acc: accList)
      {
         Decimal OldValue=OldMap.get(acc.id).AnnualRevenue;

          if(acc.AnnualRevenue!=null && acc.AnnualRevenue!=(OldMap.get(acc.id).AnnualRevenue) && OldValue!=null )
             {
                Percentage =((acc.AnnualRevenue-OldValue)/OldValue)*100;
                 if(Percentage>=50)
                 {
                     acc.Description='High Revenue Growth';
                 }
             }
          if(acc.Phone==null)
          {
              acc.phone.addError('Phone number cannot be removed once set');
          }
      }
        
    }
    
 Public Static void AccountMethod1(List<Account> accList)
 {
     List<Contact> ConList =new List<Contact>();
     
     for(Account acc: accList)
     {
         
        Contact Con =new Contact();
         Con.AccountId=acc.id;
         Con.LastName=acc.name+'Primary Contact';
         Con.Email=acc.name+'primary@demo.com';
         
         if(acc.Industry=='Technology' && acc.Industry!=null)
         {
             Con.Title='Tech Lead';
             ConList.add(Con);
         }
         else if(acc.Industry!='Technology')
         {
         ConList.add(Con);
         }
     }
     if(!ConList.isEmpty())
     {
         Insert ConList;
     }
 }
        

}