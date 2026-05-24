public with sharing class leadCreationController {
    public leadCreationController() {

    }

@AuraEnabled
public static Lead  createLead(Lead LeadRecObj){
    try {
        insert LeadRecObj;
        return LeadRecObj;
    } catch (Exception ex) {
        throw new AuraHandledException(ex.getMessage());
    }
}
}