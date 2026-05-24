public with sharing class LeadAutomation{
    public LeadAutomation( String leadId) {
        
        lead lead =[select id, IsConverted,ConvertedContactId,ConvertedOpportunityId from Lead where 
        Id= :leadId];
        lead.lead_Conversion__c=true;
        Database.LeadConvert lc=new database.LeadConvert();
        lc.setLeadId(lead.Id);
        lc.setDoNotCreateOpportunity(true);
        lc.setConvertedStatus('Qualified');
        Database.LeadConvertResult lcr=Database.convertLead(lc);
        if(lcr.isSuccess()){
            System.debug('Lead converted successfully');
        }
        else {
            {
                for(Database.Error err: lcr.getErrors())
                {
                    System.debug('Error converting lead:'+err.getMessage());
                }
            }
        }
    }
}