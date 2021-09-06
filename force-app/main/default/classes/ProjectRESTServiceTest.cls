@isTest
private class ProjectRESTServiceTest {
  //Implement Apex REST service tests here
  @isTest
  public static void restTest() {
    Opportunity opportinity = new Opportunity(Name = 'Test',
                                              StageName = 'TEST',
                                              CloseDate = Date.today().addDays(10));
    insert opportinity;

    String projectRef = 'TEST'; 
    String projectName = 'TEST';
    Date startDate = Date.today();
    Date endDate = startDate.addDays(2);
    Double amount = 2.5;
    String status = 'TEST';


    Test.startTest();
    ProjectRESTService.postProjectData(projectRef,
                                        projectName,
                                        opportinity.Id,
                                        startDate,
                                        endDate,
                                        amount,
                                        status);
    Test.stopTest();

    List<Opportunity> opportunities = [SELECT Id FROM Opportunity WHERE DeliveryInstallationStatus__c = 'In progress'];
    List<Project__c> projects = [SELECT Id FROM Project__c];

    System.assertEquals(1,opportunities.size());
    System.assertEquals(1,projects.size());

  }
}