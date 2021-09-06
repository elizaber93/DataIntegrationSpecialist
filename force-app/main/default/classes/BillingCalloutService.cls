public class BillingCalloutService {
    //Implement business and callout logic methods here

    @future(callout=true)
    public static void callBillingService(String projectRef, Decimal amount) {
        
        ServiceCredentials__c serviceCredentials = ServiceCredentials__c.getValues('BillingServiceCredential');
    
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.username = serviceCredentials.Username__c;
        project.password = serviceCredentials.Password__c;
        project.projectid = projectRef;
        project.billAmount = amount;
                               
        BillingServiceProxy.InvoicesPortSoap11 invoiceCall = new BillingServiceProxy.InvoicesPortSoap11();
        
        String response = invoiceCall.billProject(project);
                                
        List<Project__c> projects;
        if (response != null && response.equalsIgnoreCase('OK')){
            projects = [SELECT Status__c FROM Project__c WHERE ProjectRef__c =: projectRef];
            if(projects.size() > 0){
                projects[0].Status__c = 'Billed';
            }
            update projects;
        }

    }

}