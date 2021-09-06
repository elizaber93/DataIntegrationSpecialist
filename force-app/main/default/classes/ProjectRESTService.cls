@RestResource(urlMapping='/project/')
global class ProjectRESTService {
    //Implement service logic here

    @HttpPost
    global static String postProjectData( String projectRef, 
                                        String projectName,
                                        String opportunityId,
                                        Date startDate,
                                        Date endDate,
                                        Double amount,
                                        String status) {

        Savepoint savePoint = Database.setSavepoint();

        try{
            List<Opportunity> relatedOpportunities = [SELECT Id,DeliveryInstallationStatus__c
                                                    FROM Opportunity
                                                    WHERE Id = :opportunityId];
            if (relatedOpportunities.size() > 0) {
                relatedOpportunities.get(0).DeliveryInstallationStatus__c = 'In progress';
            } else {
                return 'There\'s no related opportinity';
            }
            update relatedOpportunities;

            Project__c projectToAdd = new Project__c ( ProjectRef__c = projectRef,
                                                Name = projectName,
                                                Opportunity__c  = opportunityId,
                                                Start_Date__c = startDate,
                                                End_Date__c = endDate,
                                                Billable_Amount__c = amount,
                                                Status__c = status
                                                );
            upsert projectToAdd;
        } catch (Exception e) {
            Database.rollback(savePoint);
            return (e.getMessage());
        }

        return 'OK';

    }
}