/*************************************************************** 
Name: AMS_CaseTrigger
Copyright © 2022 Salesforce
======================================================
Purpose:
Trigger to calculate service contract time of a case.
======================================================
History:
Creation
VERSION  AUTHOR           DATE         LINES    DETAIL     Description
1.0      eortega@ts4.mx   25/04/2022            INITIAL    Trigger to calculate service contract time of a case.
2.0      dmarcos@ts4.mx   09/04/2022   16-21    INITIAL    Trigger to execute service AMS_ClickupIntegration.createTasks().
3.0      dmarcos@ts4.mx   09/04/2022   82-88    INITIAL    Trigger to execute service AMS_ClickupIntegration.updateTask().
4.0		 jtenorio@ts4.mx  02/10/2023   28       FIX        ClickUp Integration validation future methods
5.0		 jtenorio@ts4.mx  02/10/2023   132-134  FIX        Map new fields ClickUp integration
6.0      vruiz@ts4.mx     03/10/2023   63-126	FIX		   Fix total hours service contract sum
***************************************************************/
trigger AMS_CaseTrigger on Case (before insert, after update,after insert, before update) {

    ServiceContract getRelatedContract(Case caseRecord) {
        List<ServiceContract> contracts = [SELECT Id, StartDate FROM ServiceContract WHERE Id = :caseRecord.ServiceContractId];
        return contracts.isEmpty() ? null : contracts[0];
    }
    
    if(AMS_TriggerControl.byPassTrigger == false){
        if(Trigger.isAfter && Trigger.isInsert){
            for(Case caso : Trigger.new) {
                if(System.IsBatch() == false && System.isFuture() == false){ 
                    AMS_ClickupIntegration.createTasks(caso.Id);
                }
            }
        }    
    
    if (trigger.isBefore && trigger.isInsert){
        Set<String> setIds = new Set<String>();
        
        for(Case item : Trigger.New){
            setIds.add(item.AccountId);
        }
       
        List<ServiceContract> listServiceContract = [Select Id, AccountId, EndDate From ServiceContract Where AccountId IN: setIds AND AMS_Estatus__c = 'Activo'];
        
        Date fecha = System.today();
       
        for(Case item : Trigger.New){
            boolean accountWithContract = false;
            
            for(ServiceContract contract : listServiceContract){
                if (contract.AccountId == item.AccountId){
                    accountWithContract = true;
                    if(contract.EndDate < fecha){
                        item.addError('La fecha del contrato asignado a la cuenta esta vencida'); 
                    }else{
                        item.ServiceContractId = contract.Id;
                    }
                }
            }
            if (accountWithContract == false){
                item.addError('No se encontro contrato de servicio activo para esta cuenta.'); 
            }
        }
    }
    if (trigger.isAfter && trigger.isUpdate){

        Map<Id, Case> oldMap = trigger.oldMap;
        Set<Id> setIdsContractToUpdate = new Set<Id>();
        Map<Id, Date> contractStartDates = new Map<Id, Date>();
        
          for (Case item : Trigger.New) {
                // Verifica si el campo "Tiempo_Real__c" ha cambiado.
                if (item.Tiempo_Real__c != oldMap.get(item.Id).Tiempo_Real__c) {
                    // Obtén el contrato correspondiente al caso.
                    ServiceContract relatedContract = getRelatedContract(item);
                    if (relatedContract != null) {
                        // Verifica si la fecha del caso es posterior o igual a la fecha de inicio del contrato.
                        if (item.FechaApertura__c >= relatedContract.StartDate) {
                            // Agrega el contrato al conjunto si cumple con las condiciones.
                            setIdsContractToUpdate.add(relatedContract.Id);
                            // Almacena la fecha de inicio del contrato en el mapa.
                            contractStartDates.put(relatedContract.Id, relatedContract.StartDate);
                        }
                    }
                }
            }
        
            if (!setIdsContractToUpdate.isEmpty()) {
                  List<ServiceContract> listContractsToUpdate = new List<ServiceContract>();
                  
                  List<ServiceContract> relatedContracts = [SELECT Id, StartDate
                                                            FROM ServiceContract
                                                            WHERE Id IN :setIdsContractToUpdate];
                  

                  for (ServiceContract contract : relatedContracts) {
                      contractStartDates.put(contract.Id, contract.StartDate);
                  }
                  
                  
                  for (Case item : Trigger.New) {
                      if (setIdsContractToUpdate.contains(item.ServiceContractId)) {
                          Date contractStartDate = contractStartDates.get(item.ServiceContractId);
                          Decimal totalTiempoReal = 0;
                          
                          if (item.FechaApertura__c >= contractStartDate) {
                              List<Case> relatedCases = [SELECT Id, Tiempo_Real__c
                                                         FROM Case
                                                         WHERE AccountId IN (SELECT AccountId
                                                                             FROM ServiceContract
                                                                             WHERE Id = :item.ServiceContractId)
                                                         AND FechaApertura__c >= :contractStartDate];
                              
                              for (Case relatedCase : relatedCases) {
                                  if (relatedCase.Tiempo_Real__c != null) {
                                      totalTiempoReal += relatedCase.Tiempo_Real__c;
                                  }
                              }
                          }
                          
                          ServiceContract contractUpdate = new ServiceContract();
                          contractUpdate.Id = item.ServiceContractId;
                          contractUpdate.AMS_HorasConsumidas__c = totalTiempoReal;
                          listContractsToUpdate.add(contractUpdate);
                      }
                  }
                  update listContractsToUpdate;
              }
        
                Map<Id,Case> mapOldValues= new Map<Id,Case>(Trigger.old);
                    for(Case caso : Trigger.new) {
                        if(caso.AMS_IdTareaClickup__c !=null){
                            if(caso.Subject != mapOldValues.get(caso.Id).Subject || caso.Status != mapOldValues.get(caso.Id).Status || caso.Priority != mapOldValues.get(caso.Id).Priority || caso.Tiempo_Real__c != mapOldValues.get(caso.Id).Tiempo_Real__c || caso.AMS_EspecialistaAsignado__c != mapOldValues.get(caso.Id).AMS_EspecialistaAsignado__c || caso.FechaApertura__c != mapOldValues.get(caso.Id).FechaApertura__c || caso.Fecha_Hora_de_cierre__c != mapOldValues.get(caso.Id).Fecha_Hora_de_cierre__c || caso.AMS_TiempoEstimado__c  != mapOldValues.get(caso.Id).AMS_TiempoEstimado__c){
                                if(System.IsBatch() == false && System.isFuture() == false){ 
                                    AMS_ClickupIntegration.updateTask(caso.Id,caso.AMS_EspecialistaAsignado__c,mapOldValues.get(caso.Id).AMS_EspecialistaAsignado__c);
                                }
                                
                            }
                        }            
                    }
      }
    }
    
}