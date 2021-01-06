import { LightningElement, wire } from 'lwc'
import { refreshApex } from '@salesforce/apex'

import getOOEMessages from '@salesforce/apex/DemoController.getMessages'

export default class OoeDemoResults extends LightningElement {
    error
    data
    displayData = []
    wiredThings

    count = 0
    atExecutions = 0
    asfExecutions = 0
    bsfExecutions = 0
    btExecutions = 0
    pExecutions = 0
    wfrExecutions = 0
    mrOrderOfExecutions = 0

    @wire(getOOEMessages)
    getMessages(value) {
        this.wiredThings = value
        const {data, error} = value
        if(data) {
            this.data = data
            this.error = undefined
            this.setCounts()
        } else if(error) {
            this.data = undefined
            this.error = error
        }
    }

    refreshData() {
        refreshApex(this.wiredThings)
    }

    setCounts() {
        let [tempCount, tempATExecutions, tempASFExecutions, tempBSFExecutions] = [0, 0, 0, 0]
        let [tempBTExecutions, tempPExecutions, tempWFRExecutions, tempMROrderOfExecutions] = [0, 0, 0, 0]
        let newCount = 0
        
        this.displayData = []

        for(let step of this.data) {
            switch(step.Tool__c) {
                case 'AFTER_INSERT TRIGGER':
                case 'AFTER_UPDATE TRIGGER':
                    tempATExecutions += 1
                    break
                case 'AFTER-SAVE FLOW':
                    tempASFExecutions += 1
                    break
                case 'BEFORE-SAVE FLOW':
                    tempBSFExecutions += 1
                    break
                case 'BEFORE_INSERT TRIGGER':
                case 'BEFORE_UPDATE TRIGGER':
                    tempBTExecutions += 1
                    break
                case 'PROCESS':
                    tempPExecutions += 1
                    break
                case 'WORKFLOW RULE':
                    tempWFRExecutions += 1
                    break
                case 'BEFORE_UPDATE TRIGGER ON OOE_Demo_Parent__c':
                    if(step.Message__c != "The sum of the children counts is 0") {
                        tempMROrderOfExecutions += 1
                    }
                    break   
            }
            newCount = 1 * step.Message__c.substring(step.Message__c.lastIndexOf(' '))
            if(newCount > tempCount) {
                tempCount = newCount
            }

            if(step.Message__c != "The sum of the children counts is 0") {
                this.displayData.push(step)
            }
        }

        this.count = tempCount
        this.atExecutions = tempATExecutions
        this.asfExecutions = tempASFExecutions
        this.bsfExecutions = tempBSFExecutions
        this.btExecutions = tempBTExecutions
        this.pExecutions = tempPExecutions
        this.wfrExecutions = tempWFRExecutions
        this.mrOrderOfExecutions = tempMROrderOfExecutions
    }
}