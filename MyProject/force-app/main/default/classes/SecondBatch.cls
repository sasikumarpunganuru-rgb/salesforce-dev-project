global class SecondBatch  implements Database.batchable<sObject>{
    global database.querylocator start(database.batchableContext bc)
    {
        return database.getQuerylocator('Select id,Birthdate from contact');
    }
    global void execute(database.batchableContext bc, List<Contact> Scope)
    {
        integer count=0;
        List<Contact> ConList=new List<Contact>();
        for(Contact Con: Scope)
        {
            if(Con.Birthdate==Null)
           {
               count=count+1;
                Con.Birthdate=System.Today();
                ConList.add(Con);
            }
        }
        System.debug(count);
        try{
            if(!ConList.IsEmpty())
            {
                update ConList;
            }
        }
        catch(DmlException e)
        {
            System.debug('execution failed'+e.getMessage());
        }
    }
    global void finish(Database.batchableContext bc)
    {
        System.debug('Batch is processed');
    }

}