public class myClass {
    @AuraEnabled(cacheable=true)
    public static void updateCon(Id conId,String Email)
    {
        Contact con=[SELECT Id,Email FROM Contact WHERE Id=:conId];
        con.Email=Email;
        Update con;
    }

    }