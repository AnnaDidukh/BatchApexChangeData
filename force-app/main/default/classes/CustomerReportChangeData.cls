global class CustomerReportChangeData implements Database.Batchable<SObject>, Database.Stateful{
    List<Customer_Report__c> listRecords = new List<Customer_Report__c>();
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id, Name, DataChange__c From Customer_Report__c limit 1000';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<SObject> scope){
        for(Customer_Report__c obj : (Customer_Report__c[]) scope){        
            if(obj.DataChange__c!= date.today()){
            	obj.DataChange__c= date.today();
		listRecords.add(obj);
            }
         }
    }
    global void finish(Database.BatchableContext BC){
        system.debug('list to be deleted size  :: '+listRecords.size());
        if(!listRecords.isEmpty()){
              update listRecords;
        }
    }
}
