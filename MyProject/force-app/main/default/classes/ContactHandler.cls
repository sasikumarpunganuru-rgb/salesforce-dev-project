public class ContactHandler {
public static void ContactMethod(List<Contact> ConList)
{
    for(Contact Con : ConList)
    {
        if(Con.Email==null)
        {
            Con.Email.addError('Email is Mandatory');
        }
        if(con.Phone==null)
        {
            Con.Phone='0000000000';
        }
        if(Con.LastName.contains('Test'))
        {
            Con.Description='Test Contact';
        }
    }
}
}