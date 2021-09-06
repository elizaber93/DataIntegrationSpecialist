public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    
    @InvocableMethod
    public static void postOpportunityToPMS(List<Id> opportunityIds){
        
        HttpRequest req = new HttpRequest();
        
  		req.setMethod('POST');
        
  		req.setHeader('Content-Type', 'application/json');
        
        ServiceTokens__c serviceToken = ServiceTokens__c.getValues('ProjectServiceToken');
        
        String sToken = serviceToken.Token__c;
        
  		req.setEndpoint('https://sb-integration-pms-2.herokuapp.com/projects');
        
        req.setHeader('token',sToken);
		
		List<Opportunity> opportunities = [SELECT 	Id, 
                                           			Name, 
                                           			Account.Name, 
                                           			CloseDate, 
                                           			Amount
                                          FROM Opportunity
                                          WHERE Id IN :opportunityIds];
        
        
        req.setBody(opportunityListToJson(opportunities));
		
		Http http = new Http();
        
		HTTPResponse res = http.send(req);
        
		
    }
    
    public static String opportunityListToJson(List<Opportunity> opportunities) {
        String json = '[';
        for (Opportunity opportunity : opportunities) {
            json += '{\\n\"opportunityId\": \"' + opportunity.Id + '\",\\n' +
                		'\\n\"opportunityName\": \"' + opportunity.Name + '\",\\n' +
                		'\\n\"AccountName\": \"' + opportunity.Account.Name + '\",\\n' + 
                		'\\n\"closeDate\": \"' + opportunity.closeDate + '\",\\n' +
                		'\\n\"amount\": ' + opportunity.Amount + ',\\n}';
                	
                }
        json += ']';
        return json;
    }
    
    class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{
        public void execute(QueueableContext context) {
            
        }
        
    }
}