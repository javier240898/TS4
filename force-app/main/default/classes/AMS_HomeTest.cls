@isTest
public without sharing class AMS_HomeTest {
	public static testMethod void busquedaHome(){
        AMS_ClickupIntegration_Test.createList();
        
        Account cuentas = [SELECT id FROM Account WHERE Name='Prueba cuenta'];
        
        Contact contacto = new Contact();
        contacto.Firstname = 'Javier';
        contacto.LastName  = 'Tenorio Lopez';
        contacto.Email = 'jlopez@ts4.mx';
        contacto.Password__c = '123456';
        contacto.AccountId = cuentas.Id;
        contacto.AMS_FechaHrInicioSesion__c = DateTime.now();

        insert contacto;
        
        AMS_HomeController.InfoHomeGet(contacto.Id);
        AMS_HomeController.userTokenActive(contacto.Id);

    }
}