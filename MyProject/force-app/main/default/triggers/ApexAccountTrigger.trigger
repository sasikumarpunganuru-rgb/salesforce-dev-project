trigger ApexAccountTrigger on Account (before update, after insert ) {
if(Trigger.isBefore)
{
    if(Trigger.isUpdate)
    {
        AccountTriggerClass.AccountMethod(Trigger.new, Trigger.OldMap);
    }
}
  if(Trigger.isAfter)
  {
      if(Trigger.isInsert)
      {
         AccountTriggerClass.AccountMethod1(Trigger.new); 
      }
  }
}