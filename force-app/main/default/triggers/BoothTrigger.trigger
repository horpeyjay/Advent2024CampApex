trigger BoothTrigger on Booth__c (before insert, before update, after insert, after update) {
    /*if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            BoothHelperClass.creationInspectionTask(trigger.new);
        }
    }*/
    
    // if(trigger.isBefore){
    //     if(trigger.isInsert || trigger.isUpdate){
    //         BoothHelperClass.locationValidation(trigger.new);
    //     }
    // }
}