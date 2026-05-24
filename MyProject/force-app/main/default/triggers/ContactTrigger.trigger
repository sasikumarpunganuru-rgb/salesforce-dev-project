trigger ContactTrigger on Contact (before insert) {
   if(Trigger.isBefore)
   {
       ContactHandler.ContactMethod(Trigger.new);
   }

}