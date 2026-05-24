public class ContactEmail {
    public static void conMethod(List<Contact> con , Map<id,Contact> OldMap)
    {
        Set<String> Emaillist =new Set<String>();
        for(Contact con1: con)
        {
          if(con1.email!=null)
          {
              Emaillist.add(Con1.email.tolowercase());
          }
        }
        Map<String,Contact> ExistingContact=new Map<String,Contact>();
        List<Contact> OldEmail=[select id,Email from Contact where email in: emaillist];
        for(Contact con2:OldEmail )
        {
            ExistingContact.put(con2.Email.toLowerCase(),con2);
        }
        for(Contact con3:con)
        {
            if(Con3.Email!=null && ExistingContact.containskey(Con3.Email.toLowerCase()))
            {
              Con3.Email.addError('Duplicate Email found');  
            }
        }
    }

}