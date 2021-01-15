global with sharing class ApexBatchSchedular implements Schedulable {
        
    global void execute(SchedulableContext sc) {
        CustomerReportChangeData d = new CustomerReportChangeData(); 
        database.executebatch(d, 1);
    }
    
    //  public static void SchedulerMethod(){
    //      ApexBatchSchedular s = new ApexBatchSchedular();
    //      string con_exp= '0 0 * * * ?';
    //      System.schedule('CustomerReportChangeData', con_exp, s);
    //  }        
}