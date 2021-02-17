@isTest static void CustomerReportBatchAndScheduleTest () {
    String cronExpr = '0 0 0 15 3 ? 2022';
    List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
    System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');

    Test.startTest();
    String jobId = 
        System.schedule('myJobTestJobName', cronExpr, new ApexBatchSchedular());
    Test.stopTest();


    List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
    System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
    System.assertEquals('ApexBatchSchedular', jobsScheduled[0].ApexClass.Name, 'expecting specific scheduled job');

    // check apex batch is in the job list
    List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'BatchApex'];
    System.assertEquals(1, jobsApexBatch.size(), 'expecting one apex batch job');
    System.assertEquals('CustomerReportChangeData', jobsApexBatch[0].ApexClass.Name, 'expecting specific batch job');


}