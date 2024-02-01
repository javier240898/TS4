@IsTest
public class TS4_StatusHoldOnTest {
    @IsTest
    static void testHoldOnDatesUpdate() {
        // Crear registros de prueba
        SFDC_Job__c job = new SFDC_Job__c(Estatus__c = 'Solicitud', Nombre_proyecto_asignado__c = 'Test');
        insert job;
        
        // Verificar que el trigger establece correctamente la fecha de inicio del Hold On al cambiar el estatus a "On Hold"
        job.Estatus__c = 'On Hold';
        update job;
        
        job = [SELECT Fecha_Inicio_Hold_On__c FROM SFDC_Job__c WHERE Id = :job.Id];
        System.assertEquals(Date.today(), job.Fecha_Inicio_Hold_On__c);
        
        // Verificar que el trigger establece correctamente la fecha de fin del Hold On al cambiar el estatus desde "On Hold"
        job.Estatus__c = 'Oferta';
        update job;
        
        job = [SELECT Fecha_Fin_Hold_On__c,Fecha_Inicio_Hold_On__c,DiferenciInicioFinHoldOn__c FROM SFDC_Job__c WHERE Id = :job.Id];
        System.assertEquals(Date.today(), job.Fecha_Fin_Hold_On__c);
        
        // Verificar que el trigger calcula correctamente la diferencia de días entre la fecha de inicio y fin del Hold On
        Integer daysDifference = job.Fecha_Fin_Hold_On__c.daysBetween(job.Fecha_Inicio_Hold_On__c);
        System.assertEquals(daysDifference, job.DiferenciInicioFinHoldOn__c);
        
        // Verificar que el trigger acumula correctamente la diferencia de días si se cambia varias veces a "On Hold"
        // Crear un segundo registro de prueba
        SFDC_Job__c job2 = new SFDC_Job__c(Estatus__c = 'Solicitud', Nombre_proyecto_asignado__c ='Test');
        insert job2;
        
        // Cambiar el estatus del segundo registro a "On Hold" y verificar la fecha de inicio del Hold On
        job2.Estatus__c = 'On Hold';
        update job2;
        
        job2 = [SELECT Fecha_Inicio_Hold_On__c FROM SFDC_Job__c WHERE Id = :job2.Id];
        System.assertEquals(Date.today(), job2.Fecha_Inicio_Hold_On__c);
        
        // Cambiar el estatus del primer registro a "On Hold" nuevamente y verificar que se acumule la diferencia de días
        job.Estatus__c = 'On Hold';
        update job;
        
        Integer totalDaysDifference = job.Fecha_Fin_Hold_On__c.daysBetween(job.Fecha_Inicio_Hold_On__c);
        System.assertEquals(totalDaysDifference, job.DiferenciInicioFinHoldOn__c);
        
        // Cambiar el estatus del segundo registro desde "On Hold" y verificar la fecha de fin del Hold On y la diferencia de días acumulada
        job2.Estatus__c = 'Cubierta';
        update job2;
        
        job2 = [SELECT Fecha_Fin_Hold_On__c, DiferenciInicioFinHoldOn__c,Fecha_Inicio_Hold_On__c FROM SFDC_Job__c WHERE Id = :job2.Id];
        System.assertEquals(Date.today(), job2.Fecha_Fin_Hold_On__c);
        
        totalDaysDifference += job2.Fecha_Fin_Hold_On__c.daysBetween(job2.Fecha_Inicio_Hold_On__c);
        System.assertEquals(totalDaysDifference, job2.DiferenciInicioFinHoldOn__c);
    }
}