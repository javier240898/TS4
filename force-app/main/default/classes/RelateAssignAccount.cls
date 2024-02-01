/*************************************************************** 
Name: RelateAssignAccount_Test
Copyright © 2023 Salesforce
======================================================
Purpose:
Managing and updating cases.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      								INITIAL
2.0		 vruiz@ts4.mx	  26/09/2023	FIX		   Mapped the new names of key events (CaseMilestone) and modified the logic.
***************************************************************/
public with sharing class RelateAssignAccount {
    public static void defaultRelatedAcc(List <Case> pCase){
		Set<Id> acctIds = new Set<Id>();
		for (Case c : pCase) {
			acctIds.add(c.AccountId);
		}
		List <Entitlement> entls = [Select e.StartDate, e.Id, e.EndDate, 
				e.AccountId
				From Entitlement e
				Where e.AccountId in :acctIds And e.StartDate <= Today];
		//if(entls.isEmpty()==false){
			for(Case c : pCase){
				if(c.EntitlementId == null 
                   && c.AccountId != null){
					for(Entitlement e:entls){
						if(e.AccountId==c.AccountId){
							c.EntitlementId = e.Id;
						}
					} 
				}
			} 
		//}
    }
    
    public static void completeMilestone(List <Case> parmCase){
        DateTime completionDate = System.now(); 
        List<Id> inProgressCases = new list<Id>();
        List<Id> inValidationCases = new list<Id>();
        List<Id> closedCases = new list<Id>();
        List<Id> canceledCases = new list<Id>();
        List<Id> resolvedCases = new list<Id>();
        List<Case> escaledCases = new list<Case>();
        List<Case> bloqueadoCases = new list<Case>();
        List<Id> updateCases = new List<Id>();
            for (Case c : parmCase){
                if (c.Status == 'Escalado' ){
                    escaledCases.add(c);
                    
                }
                else if(c.Status == 'Bloqueado'){
                    bloqueadoCases.add(c);
                }
                else if (c.Status == 'En proceso' &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null))){
                    //c.IsStopped=false;
                    inProgressCases.add(c.Id);
        			//milestoneUtils(updateCases, 'En Proceso', completionDate);
                }
                else if((c.Status == 'Paquete a Producción' || c.Status == 'En validación') &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null))){ 
                    //c.IsStopped=false;
                    inValidationCases.add(c.Id);
        
                }
                else if( ( c.Status == 'Cerrado') &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)) ) { 
                    //c.IsStopped=false;
                    closedCases.add(c.Id);
                   }
                else if((c.Status == 'Resuelto') &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)) ){
                    resolvedCases.add(c.Id);
                }
                else if (c.Status == 'Cancelado' &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null))){ 
                    //c.IsStopped=false;
                    canceledCases.add(c.Id);
                   }                                                                                                                       
           	}
        if(inProgressCases.size() >0){
            milestoneUtils(inProgressCases, 'En Proceso', completionDate);
        }
        if(inValidationCases.size() >0){
            milestoneUtils(inValidationCases, 'En Proceso', completionDate);
            milestoneUtils(inValidationCases, 'Ejecución', completionDate);
        }
        If(canceledCases.size()>0){
            milestoneUtils(canceledCases, 'Alto', completionDate);
            milestoneUtils(canceledCases, 'Medio', completionDate);
            milestoneUtils(canceledCases, 'Bajo', completionDate);
            milestoneUtils(canceledCases, 'Crítico', completionDate);
        }
        If(closedCases.size()>0){
            milestoneUtils(closedCases, 'Alto', completionDate);
            milestoneUtils(closedCases, 'Medio', completionDate);
            milestoneUtils(closedCases, 'Bajo', completionDate);
            milestoneUtils(closedCases, 'Crítico', completionDate);
        }
        If(resolvedCases.size()>0){
            milestoneUtils(resolvedCases, 'Alto', completionDate);
            milestoneUtils(resolvedCases, 'Medio', completionDate);
            milestoneUtils(resolvedCases, 'Bajo', completionDate);
            milestoneUtils(resolvedCases, 'Crítico', completionDate);
        }
        If(escaledCases.size()>0){
        	milestoneUtilsPause(escaledCases);
        }
        If(bloqueadoCases.size()>0){
        	milestoneUtilsPause(bloqueadoCases);
        }
    }
    
    public static void milestoneUtils(List<Id> caseIds, String milestoneName, DateTime complDate) {  
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate
                                           from CaseMilestone
                                           where caseId in :caseIds 
                                           and MilestoneType.Name =:milestoneName 
                                           and completionDate = null
                                          ];
        for (CaseMilestone cm : cmsToUpdate){
            cm.completionDate = complDate;
        }
        update cmsToUpdate;
    }
    
    public static void milestoneUtilsPause(List<Case> caseIds) {  
        
        for (case cm : caseIds){
            //cm.IsStopped = true;
            cm.FechaBloqueoEscalacion__c = DateTime.now();
        }
        //update caseIds;
    }
}