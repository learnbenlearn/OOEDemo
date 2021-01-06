import { LightningElement, api } from 'lwc';

export default class OoeDemoCounts extends LightningElement {
    @api count = 0
    @api atExecutions = 0
    @api asfExecutions = 0
    @api bsfExecutions = 0
    @api btExecutions = 0
    @api pExecutions = 0
    @api wfrExecutions = 0
    @api mrOrderOfExecutions = 0
}