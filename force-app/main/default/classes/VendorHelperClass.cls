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

    /*Do not change the name of the class or the method signature.*/
    public String fixAddressList(String input) {
        if(String.isBlank(input)){
          return '';
        }
        List<Vendor__c> vendorList = [Select Name, Mailing_Street__c From Vendor__c];
        Map<String, String> nameToAddressMap = new Map<String, String>();
        For(Vendor__c vend: vendorList){
          nameToAddressMap.put(vend.Name, vend.Mailing_Street__c);
        }
    
        List<String> inputParameter = input.split('\n');
        List<String> names = new List<String>();
        List<String> addresses = new List<String>();
        for(integer i = 0; i < inputParameter.size(); i++){
          if(Math.mod(i, 2) == 0){
            names.add(inputParameter[i]);
          }else{
            addresses.add(inputParameter[i]);
          }
        }
        Map<String, String> errorMap = new Map<String, String>();
        if(names.size() == addresses.size()){
          for(integer j = 0; j < names.size(); j++){
            errorMap.put(names[j], addresses[j]);
          }
        }
        String outputString;
        for(String s : errorMap.keySet()){
          for(String name : nameToAddressMap.keySet()){
            if(name.contains(s)){
              outputString += name + ('\n');
              outputString += nameToAddressMap.get(name) + ('\n');
            }
          }
        }
        return outputString;
      }
}
