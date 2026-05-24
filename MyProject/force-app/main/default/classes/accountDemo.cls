public with sharing class accountDemo {
    public accountDemo() {


    }
    @AuraEnabled(cacheable=true)
    public static List<Account>AccountList(){
       return[select id,name,type,industry from Account limit 10];
    }
}