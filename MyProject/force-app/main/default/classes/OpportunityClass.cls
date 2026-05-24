public class OpportunityClass {
public Static void OppMethod(List<Opportunity> Opplist, map<id,Opportunity> OldMap)
{
   for(Opportunity Opp: Opplist)
{
if(opp.StageName == 'Closed Lost' && Opp.StageName!=OldMap.get(Opp.id).StageName)
{
Opportunity opp1=new Opportunity();
opp1.name =opp.name+'Renew';

    
}

}
}
}