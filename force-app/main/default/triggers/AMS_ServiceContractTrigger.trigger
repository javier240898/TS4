/*************************************************************** 
Name: AMS_ServiceContractTrigger
Copyright © 2022 Salesforce
======================================================
Purpose:
Trigger to execute service AMS_ClickupIntegration.createLists().
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   09/04/2022    INITIAL    Trigger to execute service AMS_ClickupIntegration.createLists().
***************************************************************/
trigger AMS_ServiceContractTrigger on ServiceContract (after insert, before update) {
    if(Trigger.isAfter && Trigger.isInsert){
        for(ServiceContract contrato : Trigger.new) {
            AMS_ClickupIntegration.createLists(contrato.Id);
        }
    }

}