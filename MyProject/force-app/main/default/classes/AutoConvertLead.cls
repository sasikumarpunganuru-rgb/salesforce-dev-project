public class AutoConvertLead {
    @InvocableMethod
    public static void LeadAssign(List<Id>LeadIds)
    {
        Database.LeadConvert Leadconvert=new Database.LeadConvert();
        Leadconvert.setLeadId(LeadIds[0]);
        LeadStatus Leads=[select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
        Leadconvert.setConvertedStatus(Leads.MasterLabel);
        Database.LeadConvertResult Leadconverts=Database.convertLead(Leadconvert);
        System.assert(Leadconverts.isSuccess());
    }
    
}