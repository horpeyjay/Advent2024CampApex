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

    public List<Permit__c> getPermitsNeedingReview() {
        // Your SOQL query here
        /**
         * Your query should:

Find permits that match either of these conditions:
Permits that have been approved but don't have a review date recorded
Permits with a review date in the past that are either new, under review, or missing a status
Order the results by when they were created, with the newest first
Return all fields
         */
        List<Permit__c> newPermitReview = [Select Id, Name, Booth_Type__c, Equipment_Requirements__c, Festival_Booth__c, 
            Review_Date__c, Risk_Level__c, Space_Required__c, Special_Requirements__c, Status__c, Vendor__c 
            From Permit__c 
            Where (Status__c = 'Approved' And Review_Date__c = null) or (Status__c In ('New', 'Under Review') and Review_Date__c < :Date.Today()) Order by CreatedDate DESC];

            return newPermitReview;
    }
}