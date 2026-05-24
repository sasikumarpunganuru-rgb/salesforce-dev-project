trigger CaseTrigger on Case (After insert) {
    List<Case> CaseList=Trigger.new;
    if(Trigger.isAfter)
    {
        CaseTriggerApex.CaseMethod(CaseList);
    }

}