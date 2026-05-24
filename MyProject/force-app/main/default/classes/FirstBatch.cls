global class FirstBatch implements database.batchable <sObject>{
    
global database.querylocator start(database.batchableContext bc)
{
    return database.getquerylocator('select id,name from Account');
}
    global void execute(database.batchableContext bc, List<Account> Scope){
        
        System.debug('Hi entered Execute');
    }
    global void finish(database.batchableContext bc){
        System.debug('Hi entered finish');
    }
}