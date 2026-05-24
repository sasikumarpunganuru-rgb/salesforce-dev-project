public with sharing class accountCreationController {
    public accountCreationController() {

    }
    @AuraEnabled
    public static Account  createAccount(Account accountRecObj){
        try {
            insert accountRecObj;
            return accountRecObj;
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}