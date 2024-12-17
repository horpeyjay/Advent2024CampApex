trigger VendorTrigger on Vendor__c (before insert) {
    /*if(trigger.isBefore){
        if(trigger.isInsert){
            VendorHelperClass.vendorInitialReview(trigger.new);
        }
    }*/
}