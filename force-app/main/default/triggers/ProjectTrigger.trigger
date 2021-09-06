trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    for (Id id : trigger.newMap.keySet()) {
        if (trigger.newMap.get(id).Status__c == 'Billable' && trigger.oldMap.get(id).Status__c != 'Billable') {
            BillingCalloutService.callBillingService(trigger.newMap.get(id).ProjectRef__c, trigger.newMap.get(id).Billable_Amount__c);
        }

    }
    
}