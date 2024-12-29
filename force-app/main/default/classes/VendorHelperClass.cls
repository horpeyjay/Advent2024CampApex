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

    public Boolean canBalanceForest(List<Integer> treeHeights) {
      // Constraint check
      if (treeHeights.size() < 2 || treeHeights.size() > 1000) {
        return false;
      }
      List<Integer> violation = new List<Integer>();
      for(Integer i = 0; i < treeHeights.size() - 1; i++){
        if(treeHeights[i] < 1 || treeHeights[i] > 1000){
          return false;
        }
        if(treeHeights[i] > treeHeights[i+1]){
          violation.add(i);
        }
      }

      if(violation.isEmpty()){
        return true;
      }
      if(violation.size() > 2){
        return false;
      }
      return true;
    }

      public List<String> getTopFlavors(List<String> flavors, Integer k) {
          // Step 1: Count the frequency of each flavor
          Map<String, Integer> flavorCount = new Map<String, Integer>();
          for (String s : flavors) {
              if (!flavorCount.containsKey(s)) {
                  flavorCount.put(s, 1);
              } else {
                  flavorCount.put(s, flavorCount.get(s) + 1);
              }
          }
  
          // Step 2: Convert map keys to a list
          List<String> sortedFlavors = new List<String>(flavorCount.keySet());
  
          // Step 3: Sort using custom sorting logic
          sortedFlavors.sort(new CustomComparator(flavorCount));
  
          // Step 4: Extract the top K flavors
          List<String> topFlavors = new List<String>();
          for (Integer i = 0; i < k && i < sortedFlavors.size(); i++) {
              topFlavors.add(sortedFlavors[i]);
          }
  
          return topFlavors;
      }
  
      // Custom comparator class
      public class CustomComparator implements Comparator<String> {
          private Map<String, Integer> flavorCount;
  
          // Constructor to initialize the frequency map
          public CustomComparator(Map<String, Integer> flavorCount) {
              this.flavorCount = flavorCount;
          }
  
          public Integer compare(String a, String b) {
              Integer freqA = flavorCount.get(a);
              Integer freqB = flavorCount.get(b);
  
              if (freqA == freqB) {
                  // Sort alphabetically if frequencies are equal
                  return a.compareTo(b);
              }
              // Sort by frequency in descending order
              return freqB - freqA;
          }
      }

    public Integer findPairs(List<Integer> preferences, Integer target) {
      Integer count = 0;
      Map<Integer, Integer> frequencyMap = new Map<Integer, Integer>();
  
      // Build a frequency map of the numbers
      for (Integer num : preferences) {
          if (!frequencyMap.containsKey(num)) {
              frequencyMap.put(num, 0);
          }
          frequencyMap.put(num, frequencyMap.get(num) + 1);
      }
  
      // Iterate through the map to count pairs
      for (Integer key : frequencyMap.keySet()) {
          Integer complement = target - key;
  
          if (frequencyMap.get(key) > 0) {
              if (key == complement) {
                  // Handle pairs within the same number
                  Integer pairs = frequencyMap.get(key) / 2;
                  count += pairs;
                  frequencyMap.put(key, 0); // Mark as processed
              } else if (frequencyMap.containsKey(complement) && frequencyMap.get(complement) > 0) {
                  // Count pairs formed by key and complement
                  Integer pairs = Math.min(frequencyMap.get(key), frequencyMap.get(complement));
                  count += pairs;
  
                  // Decrement frequencies for the counted pairs
                  frequencyMap.put(key, frequencyMap.get(key) - pairs);
                  frequencyMap.put(complement, frequencyMap.get(complement) - pairs);
              }
          }
      }
  
      return count;
  }
  
  
}
