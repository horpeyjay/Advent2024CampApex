trigger ContactTrigger on Contact (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        ContactHandlerClass.updateAccountOnContact(trigger.new);
    }
}