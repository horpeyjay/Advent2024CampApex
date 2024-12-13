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

    /*
    public static void locationValidation(List<Booth__c> boothList) {
        Map<Id, Booth__c> vendorIdBoothMap = new Map<Id, Booth__c>();
    
        // Populate the map to associate Vendor Ids with Booths
        for (Booth__c booth : boothList) {
            if (booth.Vendor__c != null) {
                vendorIdBoothMap.put(booth.Vendor__c, booth);
            }
        }
    
        String errorMessage = 'The Booth may not be placed in this location.';
        
        // Query Vendors associated with Booths
        if (!vendorIdBoothMap.isEmpty()) {
            List<Vendor__c> vendorList = [SELECT Id, Type__c FROM Vendor__c WHERE Id IN :vendorIdBoothMap.keySet()];
            
            // Iterate over Vendors and validate Booth locations
            for (Vendor__c vendor : vendorList) {
                Booth__c booth = vendorIdBoothMap.get(vendor.Id); // Get the booth for this vendor
                
                if (booth != null) {
                    if (vendor.Type__c == 'Baker' && (booth.Location__c != 'Main Square' && booth.Location__c != 'Treat Lane')) {
                        booth.addError(errorMessage);
                    } else if (vendor.Type__c == 'Candy Maker' && booth.Location__c != 'Sweet Corner') {
                        booth.addError(errorMessage);
                    } else if (vendor.Type__c == 'Game Master' && (booth.Location__c != 'Treat Lane' && booth.Location__c != 'Main Square')) {
                        booth.addError(errorMessage);
                    }
                }
            }
        }
    }    
    */
}