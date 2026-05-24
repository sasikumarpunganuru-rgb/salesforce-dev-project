public class leadduplicatecheck {
    @AuraEnabled(cacheable=true)
    public static void leaddupremov(List<Lead>leadTeamList){
        try{
            
            set<string> EmailSet=new set<string>();
            for(Lead leadobj:leadTeamList){
                EmailSet.add(leadobj.Email);
            }
            List<Lead> teamList=[select email from lead where email In:EmailSet];
                if(teamList.size()>0)
            {
                leadTeamList[0].addError('Email already Exists');
            }
        }
        catch(exception ex){
            throw ex;
        }
        
        
    }

}