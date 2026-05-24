public class convertLeadController {
    @AuraEnabled
   public static Map<String,String> doConvert(Id leadId){

    System.debug('doConvert LeadId: ' + leadId);
    Map<String,Id> mapResult = new Map<String,Id>();
    Database.LeadConvert lc = new database.LeadConvert();
    lc.setLeadId(leadId);
    lc.setDoNotCreateOpportunity(True);
    LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
    System.debug('doConvert ConvertStatus: ' + convertStatus);
    lc.setConvertedStatus(convertStatus.MasterLabel);
    Database.LeadConvertResult lcr = Database.convertLead(lc);
    System.debug('doConvert LeadConvertResult: ' + lcr);

    id accountId = lcr.getAccountId();
    id contactId = lcr.getcontactId();

    mapResult.put('accountId', accountId);

    mapResult.put('contactId', contactId);

    System.debug('doConvert AccountId Result: ' + accountId);
    System.debug('doConvert ContactId Result: ' + contactId);

    return mapResult;
}

}