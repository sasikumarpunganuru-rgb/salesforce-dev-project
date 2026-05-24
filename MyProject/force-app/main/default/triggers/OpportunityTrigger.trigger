trigger OpportunityTrigger on Opportunity (After Insert, After update,after delete,after undelete) {
    
          OpportunityClass.OppMethod(Trigger.new,trigger.oldMap);  
      
      
  }