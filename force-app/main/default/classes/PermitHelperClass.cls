public with sharing class PermitHelperClass {

    /*public static void applicationPending(List<Permit__c> permList){

        Set<Id> vendorIds = new Set<Id>();
        Map<Id, Integer> permitCountMap = new Map<Id, Integer>();
        Map<Id, List<Permit__c>> multiplePermitMap = new Map<Id, List<Permit__c>>();
        if(!permList.isEmpty()){
            for(Permit__c perm: permList){
                //vendorIds.add(perm.Vendor__c);
                if(!permitCountMap.containsKey(perm.Vendor__c)){
                    permitCountMap.put(perm.Vendor__c, 1);
                }else{
                    Integer count = permitCountMap.get(perm.Vendor__c);
                    permitCountMap.put(perm.Vendor__c, count + 1);
                }
            }

            for(Id vendorId : permitCountMap.keySet()){
                if(permitCountMap.get(vendorId) > 1){
                    List<Permit__c> multiplePerm = new List<Permit__c>();
                    for(Permit__c perm : permList){
                        if(perm.Vendor__c == vendorId){
                            multiplePerm.add(perm);
                        }
                    }
                    multiplePermitMap.put(vendorId, multiplePerm);
                }else{
                    vendorIds.add(vendorId);
                }
            }
        }
        if(!multiplePermitMap.isEmpty()){
            for(Id venId : multiplePermitMap.keySet()){
                for(Permit__c perms : multiplePermitMap.get(venId)){
                    perms.addError('Vendor has an existing permit application in process');
                }
            }
        }
        Map<Id, List<Permit__c>> vendorPermMap = new Map<Id, List<Permit__c>>();
        if(!vendorIds.isEmpty()){
            List<Permit__c> existingPermList = [Select Id, Vendor__c, Status__c From Permit__c where Vendor__c in : vendorIds and Status__c != 'Rejected'];
            
            for(Permit__c perm : existingPermList){
                if(!vendorPermMap.containsKey(perm.Vendor__c)){
                    List<Permit__c> existPerm = new List<Permit__c>();
                    existPerm.add(perm);
                    vendorPermMap.put(perm.Vendor__c, existPerm);
                }else{
                    vendorPermMap.get(perm.Vendor__c).add(perm);
                }
            }
        }
        List<Permit__c> permListToInsert = new List<Permit__c>();
        if(!vendorPermMap.isEmpty()){
            for(Permit__c perm : permList){
                if(vendorPermMap.containsKey(perm.Vendor__c)){
                    perm.Vendor__c.addError('Vendor has an existing permit application in process');
                }else{
                    permListToInsert.add(perm);
                }
            }
        }
    }
    */

    public static void boothCreationOnApproval(List<Permit__c> newPermList, Map<Id, Permit__c> oldPermMap) {
        List<Booth__c> boothToInsert = new List<Booth__c>();
        List<Permit__c> approvedPermits = new List<Permit__c>();
    
        for (Permit__c newPerm : newPermList) {
           
            if (newPerm.Status__c == 'Approved') {
                Permit__c oldPermit = new Permit__c();
                if(oldPermMap != null){
                    oldPermit = oldPermMap.get(newPerm.Id);
                    if(oldPermit.Status__c != 'Approved'){
                        approvedPermits.add(newPerm);
                    }
                }
                approvedPermits.add(newPerm);
            }
        }
        
        if(!approvedPermits.isEmpty()){
            for(Permit__c perm : approvedPermits){
                Booth__c newBooth = new Booth__c();
                newBooth.Status__c = 'Setup';
                newBooth.Setup_Date__c = Date.today();
                newBooth.Vendor__c = perm.Vendor__c;
                if(perm.Risk_Level__c == 'High'){
                    newBooth.Safety_Rating__c = '1 = Critical issues (needs immediate attention)';
                    newBooth.Inspection_Frequency__c = 'Every 2 hours';
                }else if(perm.Equipment_Requirements__c == 'Specialty (Custom Requirements)' && perm.Space_Required__c == 'Extra-Large'){
                    newBooth.Safety_Rating__c = '2 = Major concerns';
                    newBooth.Inspection_Frequency__c = 'Every 4 hours';
                }else if((perm.Booth_Type__c == 'Food' || perm.Booth_Type__c == 'Sweets') && perm.Equipment_Requirements__c == 'Premium (Enhanced Power/Water)'){
                    newBooth.Safety_Rating__c = '3 = Minor issues';
                    newBooth.Inspection_Frequency__c = 'Every 6 hours';
                }else{
                    newBooth.Safety_Rating__c = '4 = Good Standing';
                    newBooth.Inspection_Frequency__c = 'Daily';
                }
                boothToInsert.add(newBooth); 
            }
        }
        List<Permit__c> permitsToUpdatewithBooth = new List<Permit__c>();
        if (!boothToInsert.isEmpty()) {
            insert boothToInsert;
        }
    }
}