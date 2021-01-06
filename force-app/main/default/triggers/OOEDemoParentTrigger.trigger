trigger OOEDemoParentTrigger on OOE_Demo_Parent__c (before update) {
	OOEDemoParentTrigger_Helper.beforeUpdate(Trigger.new[0]);	
}