public with sharing class CalculateNumbers {
    public CalculateNumbers() {

    }
    @AuraEnabled
    public static integer getsumresult(integer firstnumber ,integer secondnumber)
    {
        return (firstnumber+secondnumber);
    }
}