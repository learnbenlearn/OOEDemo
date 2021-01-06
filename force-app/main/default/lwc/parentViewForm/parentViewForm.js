import { LightningElement, wire } from 'lwc'
import { getRecord } from 'lightning/uiRecordApi'

import { subscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService'
import DEMOMC from '@salesforce/messageChannel/DemoMessageChannel__c'

import { refreshApex } from '@salesforce/apex'
import getParentId from '@salesforce/apex/DemoController.getParentId'

import NAME_FIELD from '@salesforce/schema/OOE_Demo_Parent__c.Name'
import TOTAL_COUNT_FIELD from '@salesforce/schema/OOE_Demo_Parent__c.Total_Count__c'

const PARENT_FIELDS = [NAME_FIELD, TOTAL_COUNT_FIELD]

export default class ParentViewForm extends LightningElement {
    parentId = ""
    error
    subscription = null

    @wire(getRecord, {recordId: '$parentId', fields: PARENT_FIELDS})
    parent

    @wire(MessageContext)
    messageContext

    @wire(getParentId)
    setParentId({error, data}) {
        if(data) {
            this.parentId = data;
            this.error = undefined;
        } else if(error) {
            this.parentId = "";
            this.error = error;
        }
    }

    connectedCallback() {
        if(this.subscription) {
            return
        }
        this.subscribeMC()
    }

    subscribeMC() {
        if(!this.subscription) {
            this.subscription = subscribe(this.messageContext, DEMOMC,
                (message) => this.handleMessage(message), { scope: APPLICATION_SCOPE})
        }
    }

    handleMessage(message) {
        console.log(message)
        refreshApex(this.parent)
    }
}