trigger PermitTrigger on Permit__c (before insert, after insert, after update) {
    /*
    if(trigger.isBefore){
        if(trigger.isInsert){
            PermitHelperClass.applicationPending(trigger.new);
        }
    }*/

    if(trigger.isAfter){
        if(trigger.isInsert){
            PermitHelperClass.boothCreationOnApproval(trigger.new, null);
        }

        if(trigger.isUpdate){
            PermitHelperClass.boothCreationOnApproval(trigger.new, trigger.oldMap);
        }
    }
}