public class DemoController {
	@AuraEnabled(cacheable=true)
    public static String getParentId() {
        return [SELECT Id FROM OOE_Demo_Parent__c LIMIT 1]?.Id;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<OOE_Message__c> getMessages() {
        List<OOE_Message__c> ooems = [SELECT Id, Tool__c, Message__c FROM OOE_Message__c ORDER BY CreatedDate];
        System.debug(ooems);
        return ooems;
    }
    
    @AuraEnabled
    public static void theCleanSlate() {
        delete [SELECT Id FROM OOE_Demo__c];
        delete [SELECT Id FROM OOE_Message__c];
    }
}