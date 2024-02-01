@isTest
public class AMS_GraficasHomeCerradoTest {
	public static testMethod void busquedaCasosGraficaCerrado(){
        AMS_ClickupIntegration_Test.createList();
        ServiceContract contrato = [SELECT id from ServiceContract where Name ='Contrato Prueba'];
        Account cuenta = [SELECT id from Account where Name ='Prueba cuenta'];
     
        Contact contacto = new Contact();
        contacto.FirstName = 'Contacto';
        contacto.LastName = 'Prueba';
        contacto.AccountId = cuenta.Id;
        contacto.AMS_TipoContacto__c = 'Agente AMS';
        contacto.AMS_IdUserClickup__c ='6335393';
        insert contacto;
        
        Case caso = new Case();
        caso.AccountId = cuenta.Id;
        caso.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso.Operador__c = contacto.Id;
        caso.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso.Subject = 'Caso prueba';
        caso.Origin ='Correo Electrónico';
        caso.AMS_TipoIncidencia__c ='Solicitud';
        caso.Type ='Type';
        caso.Status ='Nuevo';
        caso.Nivel__c ='N1';
        caso.Priority = 'Alta';
        caso.Tiempo_de_resoluci_n__c ='1';
        insert caso;
        
        AMS_GraficasHomeCerrado.getCase(contrato.id);
    }
}