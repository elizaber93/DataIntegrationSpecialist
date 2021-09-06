@isTest
private class BillingCalloutServiceTest {
  //Implement mock callout tests here
  @isTest(seeAllData=true)
  public static void billingMockTest() {
    String projectRef = 'Test';
    Opportunity opportunity  =new Opportunity(Name='Test',
                                              StageName = 'Test',
                                              CloseDate = Date.today());
    insert opportunity;
    Project__c project = new Project__c(Name = 'Test',
                                        Opportunity__c = opportunity.Id,
                                        ProjectRef__c = projectRef,
                                        Billable_Amount__c = 10);
    insert project;
    
    Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());


    
    Test.startTest();
    BillingCalloutService.callBillingService(project.ProjectRef__c,project.Billable_Amount__c);
    Test.stopTest();

    List<Project__c> billedProject = [SELECT Status__c FROM Project__c WHERE ProjectRef__c = :projectRef];
    
    
    System.assertEquals(1,billedProject.size());
  }
}