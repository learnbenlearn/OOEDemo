import { LightningElement, wire } from 'lwc'

import { publish, MessageContext } from 'lightning/messageService'
import DEMOMC from '@salesforce/messageChannel/DemoMessageChannel__c'

import cleanSlate from '@salesforce/apex/DemoController.theCleanSlate'

export default class OoeDemoContainer extends LightningElement {
    showResults = false
    error

    @wire(MessageContext)
    messageContext

    handleShowResults() {
        this.showResults = true
    }

    handleReset() {
        cleanSlate()
            .then(result => {
                console.log(result)
                this.showResults = false
                publish(this.messageContext, DEMOMC, {})
            })
            .catch(error => {
                this.error = error
            })
    }
}