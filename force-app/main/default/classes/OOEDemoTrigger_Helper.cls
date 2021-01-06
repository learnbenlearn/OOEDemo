// this is a very specific implementation - fair warning
public class OOEDemoTrigger_Helper {
    public static void beforeInsert(OOE_Demo__c newOOE) {
       // if the count is equal to the number of before-save flow runs, send a platform event
        if(newOOE.Count__c == newOOE.Before_Save_Flow_Runs__c) {
            OOE_Event__e ooee = new OOE_Event__e(Tool__c='BEFORE-SAVE FLOW',
                                                 Message__c= Constants.UPDATE_MESSAGE_BASE + 
                                                 Integer.valueOf(newOOE.Count__c));
            EventBus.publish(ooee);
        }
        newOOE.Count__c += 1;
        newOOE.Before_Trigger_Runs__c += 1;
        OOE_Event__e ooee = new OOE_Event__e(Tool__c='BEFORE_INSERT TRIGGER',
                                             Message__c=Constants.UPDATE_MESSAGE_BASE +
                                             Integer.valueOf(newOOE.Count__c));
        EventBus.publish(ooee);
    }

    public static void beforeUpdate(OOE_Demo__c oldOOE, OOE_Demo__c newOOE) {
        Integer newSumToolRuns = Integer.valueOf(newOOE.After_Save_Flow_Runs__c + 
                                                 newOOE.Before_Save_Flow_Runs__c +
                                                 newOOE.Before_Trigger_Runs__c +
                                                 newOOE.Process_Builder_Runs__c +
                                                 newOOE.Workflow_Rule_Runs__c);
        Integer oldSumToolRuns = Integer.valueOf(oldOOE.After_Save_Flow_Runs__c +
                                                 oldOOE.Before_Save_Flow_Runs__c +
                                                 oldOOE.Before_Trigger_Runs__c +
                                                 oldOOE.Process_Builder_Runs__c +
                                                 oldOOE.Workflow_Rule_Runs__c);
        
        // if the glove doesn't fit, you must acquit
        // WHOA WHOA WHOA.... whoops... meant to write that if newSumTools and oldSumTools are the same
        // AND the old and new counts are different, then a workflow rule ran and we have to update that
        // count and send a platform event (can't do it from the workflow rule because workflow rules are 
        // dumb)
        if(newSumToolRuns == oldSumToolRuns && oldOOE.Count__c != newOOE.Count__c) {
            newOOE.Workflow_Rule_Runs__c += 1;
            OOE_Event__e ooee = new OOE_Event__e(Tool__c='WORKFLOW RULE', Message__c=
                                                 Constants.UPDATE_MESSAGE_BASE + 
                                                 Integer.valueOf(newOOE.Count__c));
            EventBus.publish(ooee);
        }
        
        newOOE.Count__c += 1;
        newOOE.Before_Trigger_Runs__c += 1;
        
        OOE_Event__e ooee = new OOE_Event__e(Tool__c='BEFORE_UPDATE TRIGGER', Message__c=
                                             Constants.UPDATE_MESSAGE_BASE +
                                             Integer.valueOf(newOOE.Count__c));
        EventBus.publish(ooee);
    }
    
    public static void afterInsert(OOE_Demo__c newOOE) {
        OOE_Event__e ooee = new OOE_Event__e(Tool__c='AFTER_INSERT TRIGGER', Message__c=
                                             Constants.MESSAGE_BASE +
                                             Integer.valueOf(newOOE.Count__c));
        EventBus.publish(ooee);
    }
    
    public static void afterUpdate(OOE_Demo__c oldOOE, OOE_Demo__c newOOE) {
        OOE_Event__e ooee = new OOE_Event__e(Tool__c='AFTER_UPDATE TRIGGER', Message__c=
                                             Constants.MESSAGE_BASE +
                                             Integer.valueOf(newOOE.Count__c));
        EventBus.publish(ooee);
    }
}