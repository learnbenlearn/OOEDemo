public class OOEDemoParentTrigger_Helper {
    public static void beforeUpdate(OOE_Demo_Parent__c newOOEDemoParent) {
        OOE_Event__e ooee = new OOE_Event__e(Tool__c='BEFORE_UPDATE TRIGGER ON OOE_Demo_Parent__c',
                                             Message__c=Constants.PARENT_MESSAGE_BASE +
                                             Integer.valueOf(newOOEDemoParent.Total_Count__c));
        EventBus.publish(ooee);
    }
}