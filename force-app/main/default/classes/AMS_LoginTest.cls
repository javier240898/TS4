@isTest
public without sharing class AMS_LoginTest {
    public static testMethod void busquedaLogin(){
        Account cuentas = new Account ();
        cuentas.Name = 'Empresas JLT';
        insert cuentas;

        Contact contacto = new Contact();
        contacto.Firstname = 'Javier';
        contacto.LastName  = 'Tenorio Lopez';
        contacto.Email = 'jlopez@ts4.mx';
        contacto.Password__c = '123456';
		insert contacto;
        
        AMS_LoginPortal.infoLogin('jlopez@ts4.mx','123456',1);
        AMS_LoginPortal.infoLogin('jlopez@ts4.mx','12345',3);
        Contact contactoV2 = new Contact();
        contactoV2.Id = contacto.Id;
        contactoV2.AMS_UsuarioBloqueado__c = true;
		update contactoV2;
        AMS_LoginPortal.infoLogin('jlopez@ts4.mx','123456',1);


//            id, AMS_UsuarioBloqueado__c, AMS_FechaBloqueoUsuario__c ,AMS_FormulaDiferenciaFechas__c FROM Contact WHERE Email=:user

    }
}