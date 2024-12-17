public with sharing class ContactHandlerClass {
    public static void updateAccountOnContact(List<Contact> contactList){
        List<Account> accList = [Select Id, Name From Account];
        Map<Id, Account> contactIdToAccountMap = new Map<Id, Account>();
        List<Account> accountToInsert = new List<Account>();
        if(!contactList.isEmpty()){
            for(Contact con : contactList){
                if(con.AccountId == null){
                    for(Account acc : accList){
                        if(acc.Name.equalsIgnoreCase(con.FirstName + ' ' + con.LastName)){
                            con.AccountId = acc.Id;
                            break;
                        }else{
                            Account accNew = new Account(Name = con.FirstName + ' ' + con.LastName);
                            contactIdToAccountMap.put(con.Id, accNew);
                            accountToInsert.add(accNew);
                        }
                    }
                }
            }

            if(!accountToInsert.isEmpty()){
                insert accountToInsert;
            }
        }

        if(!contactIdToAccountMap.isEmpty()){
            for(Contact con : contactList){
                if(contactIdToAccountMap.containsKey(con.Id)){
                    con.AccountId = contactIdToAccountMap.get(con.Id).Id;
                }
            }
        }
    }
}