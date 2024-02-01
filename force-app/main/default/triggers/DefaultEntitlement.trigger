trigger DefaultEntitlement on Case ( after insert, after update, before insert, before update) {
    if(Trigger.isBefore){
        RelateAssignAccount.defaultRelatedAcc(Trigger.new);
        RelateAssignAccount.completeMilestone(Trigger.new);
    }else if(Trigger.isAfter){
        //RelateAssignAccount.completeMilestone(Trigger.new);
    }
}