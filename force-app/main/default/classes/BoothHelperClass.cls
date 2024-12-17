public with sharing class BoothHelperClass {
    public static void creationInspectionTask(List<Booth__c> boothList){
        List<Task> taskToCreate = new List<Task>();
        if(!boothList.isEmpty()){
            for(Booth__c booth : boothList){
                Task newTask = new Task();
                if(booth.Safety_Rating__c == '1 = Critical issues (needs immediate attention)'){
                    newTask.OwnerId = booth.OwnerId;
                    newTask.Subject = 'URGENT: Critical Safety Inspection Required';
                    newTask.WhatId = booth.Id;
                    newTask.ActivityDate = Date.today() + 1;
                    newTask.Priority = 'High';
                }else if(booth.Safety_Rating__c == '2 = Major concerns'){
                    newTask.OwnerId = booth.OwnerId;
                    newTask.Subject = 'Safety Concerns Need Review';
                    newTask.WhatId = booth.Id;
                    newTask.ActivityDate = Date.today() + 2;
                    newTask.Priority = 'High';
                }else if(booth.Safety_Rating__c == '3 = Minor issues'){
                    newTask.OwnerId = booth.OwnerId;
                    newTask.Subject = 'Safety Review Required';
                    newTask.WhatId = booth.Id;
                    newTask.ActivityDate = Date.today() + 3;
                    newTask.Priority = 'Normal';
                }

                taskToCreate.add(newTask);
            }
        }

        if(!taskToCreate.isEmpty()){
            insert taskToCreate;
        }
    }

    public static void locationValidation(List<Booth__c> boothList) {
        Map<Id, Booth__c> vendorIdToBoothMap = new Map<Id, Booth__c>();
        
        // Populate the map to associate Vendor Ids with Booths
        for (Booth__c booth : boothList) {
            if (booth.Vendor__c != null) {
                Vendor__c vendor = [Select Id, Type__c From Vendor__c WHERE Id = : booth.Vendor__c Limit 1];
                // Validation logic for location
                String vendorType = vendor.Type__c;
                String boothLocation = booth.Location__c;
                String errorMessage = 'The Booth may not be placed in this location.';
                if (vendorType == 'Baker' && (boothLocation != 'Main Square' && boothLocation != 'Treat Lane')) {
                    booth.addError(errorMessage);
                } else if (vendorType == 'Candy Maker' && boothLocation != 'Sweet Corner') {
                    booth.addError(errorMessage);
                } else if (vendorType == 'Game Master' && (boothLocation != 'Treat Lane' && boothLocation != 'Main Square')) {
                    booth.addError(errorMessage);
                }
            }
        }
        /*
        String errorMessage = 'The Booth may not be placed in this location.';
        
        // Query Vendors associated with Booths
        if (!vendorIdToBoothMap.isEmpty()) {
            List<Vendor__c> vendorList = [SELECT Id, Type__c FROM Vendor__c WHERE Id IN :vendorIdToBoothMap.keySet()];
            
            // Build a map for quick access to vendor types
            Map<Id, String> vendorIdToTypeMap = new Map<Id, String>();
            for (Vendor__c vendor : vendorList) {
                vendorIdToTypeMap.put(vendor.Id, vendor.Type__c);
            }
            
            // Validate each booth's location
            for (Booth__c booth : vendorIdToBoothMap.values()) {
                if (vendorIdToTypeMap.containsKey(booth.Vendor__c)) {
                    String vendorType = vendorIdToTypeMap.get(booth.Vendor__c);
                    String boothLocation = String.valueOf(booth.Location__c); // Ensure string comparison
                    
                    
                }
            }
        }*/
    }  
}