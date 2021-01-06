trigger OOEDemoTrigger on OOE_Demo__c (before insert, before update, after insert, after update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            OOEDemoTrigger_Helper.beforeInsert(Trigger.new[0]);
        } when BEFORE_UPDATE {
            OOEDemoTrigger_Helper.beforeUpdate(Trigger.old[0], Trigger.new[0]);
        } when AFTER_INSERT {
            OOEDemoTrigger_Helper.afterInsert(Trigger.new[0]);
        } when else {
            OOEDemoTrigger_Helper.afterUpdate(Trigger.old[0], Trigger.new[0]);
        }
    }
}