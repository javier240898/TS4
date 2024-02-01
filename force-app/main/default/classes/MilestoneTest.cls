@isTest
private class MilestoneTest {

@isTest(SeeAllData=true)
public static void TestCompleteMilestoneCase(){
    Account acc = new Account(Name = 'Cuenta de prueba');
    insert acc;
    
    Contact  contacto = new Contact( LastName = 'Test', AMS_TipoContacto__c= 'Agente AMS');
    insert contacto;
    

    Id sla = [select id from SlaProcess where IsActive =: true and IsVersionDefault =: true and Name = 'IncidenciaCasos' limit 1].Id;
    
    Entitlement entl = new Entitlement(Name = 'Test Entitlement', AccountId = acc.Id, SlaProcessId = sla);
    insert entl;
    
    Id recType = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Incidencia').getRecordTypeId();
   
    List<Case> cases = new List<Case>();
    Case cs = new Case(Subject = 'Test Case', RecordTypeId = recType, AccountId = acc.Id, EntitlementId = entl.id, Status = 'Nuevo', AMS_TipoIncidencia__c = 'Incidencia', Operador__c = contacto.id, Origin= 'Correo Electrónico');
    cases.add(cs);
    insert cases;
    
    List<Id> lstId = new List<Id>();
    for(Case c: cases){
        lstId.add(c.Id);        
    }
   
    
    Test.startTest();
    Datetime dt = System.now();
    for(Case c: cases){
        c.Status = 'En proceso';
    }
    update cases;
    //RelateAssignAccount.completeMilestone(cases);
    RelateAssignAccount.milestoneUtils(lstId, 'En Proceso', dt);
    
    for(Case c: cases){
        c.Status = 'Paquete a Producción';
    }
    update cases;

    RelateAssignAccount.milestoneUtils(lstId, 'Paquete a Producción', dt);
    for(Case c: cases){
        c.Status = 'Escalado';
    }
    update cases;
   
    RelateAssignAccount.milestoneUtils(lstId, 'Escalado', dt);
    for(Case c: cases){
        c.Status = 'Resuelto';
    }
    update cases;
    
    RelateAssignAccount.milestoneUtils(lstId, 'Resuelto', dt);
    for(Case c: cases){
        c.Status = 'Cancelado';
    }
    update cases;
    
    RelateAssignAccount.milestoneUtils(lstId, 'Cancelado', dt);
    
    Test.stopTest();
}
}