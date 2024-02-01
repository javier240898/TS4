trigger TS4_SURV_AppEncuesta_Trigger on TS4_appSurvey__c (after update) {
    
    List<TS4_surveyApplicationContact__c> contactosAplicacion = [SELECT Id, TS4_appEncuesta__r.TS4_setDurveyData__c  FROM TS4_surveyApplicationContact__c WHERE TS4_appEncuesta__c IN :Trigger.new ];
    for (TS4_surveyApplicationContact__c contacto : contactosAplicacion) {
        if(contacto.TS4_appEncuesta__r.TS4_setDurveyData__c  == true){
            contacto.TS4_blockContact__c  = true;
        }
    }
    update contactosAplicacion; 
}