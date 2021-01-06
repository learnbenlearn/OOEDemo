trigger OOEEventTrigger on OOE_Event__e (after insert) {
	OOEEvent.afterInsert(Trigger.new);
}