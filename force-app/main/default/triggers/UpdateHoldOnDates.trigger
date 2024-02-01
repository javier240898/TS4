trigger UpdateHoldOnDates on SFDC_Job__c (before update) {
    Map<Id, SFDC_Job__c> oldRecordsMap = new Map<Id, SFDC_Job__c>(Trigger.oldMap);
    
    for (SFDC_Job__c record : Trigger.new) {
        SFDC_Job__c oldRecord = oldRecordsMap.get(record.Id);
        
        // Verificar si el estatus cambió a "On Hold"
        if (record.Estatus__c == 'On Hold' && (oldRecord == null || oldRecord.Estatus__c != 'On Hold')) {
            // Marcar la fecha de inicio del Hold On si no había estado previamente en Hold On
            if (record.Fecha_Inicio_Hold_On__c == null) {
                record.Fecha_Inicio_Hold_On__c = Date.today();
            }
        }
        
        // Verificar si el estatus cambió desde "On Hold"
        if (record.Estatus__c != 'On Hold' && oldRecord != null && oldRecord.Estatus__c == 'On Hold') {
            // Marcar la fecha de fin del Hold On
            record.Fecha_Fin_Hold_On__c = Date.today();
            
            // Calcular la diferencia entre las fechas de inicio y fin del Hold On
            Double daysDifference = record.Fecha_Fin_Hold_On__c.daysBetween(record.Fecha_Inicio_Hold_On__c);
            
            // Acumular la diferencia en días si ya había un valor anterior en el campo DiferenciInicioFinHoldOn__c
            if (record.DiferenciInicioFinHoldOn__c != null) {
                daysDifference += record.DiferenciInicioFinHoldOn__c;
            }
            
            record.DiferenciInicioFinHoldOn__c = daysDifference;
        }
    }
}