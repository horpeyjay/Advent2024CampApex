public with sharing class VendorHelperClass {
    public static void vendorInitialReview(List<Vendor__c> vendorList){
        /**
         * When Ranger Bubblegum receives new vendor applications, they come in the form of a Vendor__c sObject record. All new vendors must undergo an initial review before they can apply for a permit. Ranger Bubblegum wants you to implement the automation for this. To do so, when a Vendor__c is created:


            Mark Status__c as Pending (even if they try to sprinkle in a different status)
            Set Review_By_Date__c to 7 days from the creation date
         */
        List<Vendor__c> vendorListToInsert = new List<Vendor__c>();
        if(!vendorList.isEmpty()){
            for(Vendor__c ven: vendorList){
                ven.Status__c = 'Pending';
                ven.Review_By_Date__c = System.today() + 7;
                vendorListToInsert.add(ven);
            }
        }
    }
}