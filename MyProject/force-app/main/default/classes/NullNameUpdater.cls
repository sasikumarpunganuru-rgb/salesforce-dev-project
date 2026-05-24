global class NullNameUpdater implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
      return Database.getQueryLocator([
        SELECT Id, Name, AccountNumber
        FROM Account
        WHERE Name = null
      ]);
    }
  
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
      List<Account> accounts = new List<Account>();
      for (sObject record : scope) {
        Account acc = (Account) record;
        acc.Name = acc.AccountNumber;
        accounts.add(acc);
      }
      update accounts;
    }
  
    global void finish(Database.BatchableContext bc) {
    }
  }