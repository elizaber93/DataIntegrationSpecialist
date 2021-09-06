@isTest
private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
  
    @isTest(seeAllData=true)
    public static void CalloutTest() {
        
        
        Account account = new Account(Name = 'TestAcc');
        insert account;
        Opportunity opportunity = new Opportunity(Name = 'Test', 
                                                  AccountId = account.Id, 
                                                  closeDate = Date.today(), 
                                                  Amount = 500, StageName = 'Closed Won');
        insert opportunity;
        List<Id> idList = new List<Id>();
        idList.add(opportunity.Id);
        
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        //Call method to test
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(idList);
        Test.stopTest();

        
        
        
        
        
    }
  
}