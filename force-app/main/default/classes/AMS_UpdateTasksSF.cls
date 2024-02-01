/*************************************************************** 
Name: AMS_UpdateTasksSF
Copyright © 2022 Salesforce
======================================================
Purpose:
Batch class to execute AMS_SFClickupIntegration.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   09/06/2022    INITIAL    Batch class to execute AMS_SFClickupIntegration.
***************************************************************/
public class AMS_UpdateTasksSF implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful{
    public List<sObject> listTasks;
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, Name, AMS_IdListaClickup__c FROM ServiceContract WHERE AMS_IdListaClickup__c !=null');
        
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        this.listTasks=scope;
        AMS_TriggerControl.byPassTrigger = true;
        List<Case> casoContratoServicios = new List<Case>();
        for(sobject s : scope){
            String idLista =(String) s.get('AMS_IdListaClickup__c');             
            casoContratoServicios =  AMS_SFClickupIntegration.getTasks(idLista);
            
        }
        update casoContratoServicios;
        
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
}