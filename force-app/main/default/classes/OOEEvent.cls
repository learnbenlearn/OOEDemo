public class OOEEvent {
    @InvocableMethod(label='Send OOE Event')
    public static void send(List<SenderDataType> sdt) {
        OOE_Event__e ooee = new OOE_Event__e(Tool__c=sdt[0].tool, Message__c=Constants.MESSAGE_BASE +
                                            sdt[0].count);
        EventBus.publish(ooee);
    }
    
    public static void afterInsert(List<OOE_Event__e> ooees){
        List<OOE_Message__c> ooems = new List<OOE_Message__c>();
        
        for(OOE_Event__e ooee : ooees) {
            ooems.add(new OOE_Message__c(Tool__c=ooee.Tool__c, Message__c=ooee.Message__c));
        }
        
        insert ooems;
    }
}