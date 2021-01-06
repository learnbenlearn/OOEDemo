import { LightningElement } from 'lwc'

import COUNT_FIELD from '@salesforce/schema/OOE_Demo__c.Count__c'
import PARENT_FIELD from '@salesforce/schema/OOE_Demo__c.Parent__c'
import RUN_PROCESS_VALIDATION_FIELD from '@salesforce/schema/OOE_Demo__c.Run_Process_Validation__c'

const OOE_DEMO_FIELDS = [COUNT_FIELD, PARENT_FIELD, RUN_PROCESS_VALIDATION_FIELD]

export default class OoeDemoCreateForm extends LightningElement {
    fields = OOE_DEMO_FIELDS
}