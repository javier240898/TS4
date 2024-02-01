/*************************************************************** 
Name: AMS_ClickupIntegration_Test
Copyright © 2022 Salesforce
======================================================
Purpose:
Test class to execute the methods of the class AMS_ClickupIntegration.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   10/06/2022    INITIAL    Test class to execute the methods of the class AMS_ClickupIntegration.
***************************************************************/
@isTest
public class AMS_ClickupIntegration_Test {

    @isTest
    public static void createList(){
        Account cuenta = new Account();
        cuenta.Name ='Prueba cuenta';
        insert cuenta;
        
        ServiceContract contrato = new ServiceContract();
        contrato.AccountId = cuenta.Id;
        contrato.Name ='Contrato Prueba';
        contrato.AMS_Estatus__c ='Activo';
        insert contrato;
        
        ServiceContract contratoV2 = new ServiceContract();
        contratoV2.AccountId = cuenta.Id;
        contratoV2.Name ='ContratoV2';
        //contrato.AMS_Estatus__c ='Activo';
        insert contratoV2;
        
        ServiceContract contract = [SELECT Id,Name FROM ServiceContract LIMIT 1];
        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.Name = contract.Name;
        String body = JSON.serialize(datos);
        
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',body,null));
        Test.startTest();
        AMS_ClickupIntegration.createLists(contract.Id);
        Test.stopTest();

    }
    
    @isTest
    public static void createTask(){
        Account cuenta = new Account();
        cuenta.Name ='TS4 Strategy';
        insert cuenta;
        
        Contact contacto = new Contact();
        contacto.FirstName = 'Contacto';
        contacto.LastName = 'Prueba';
        contacto.AccountId = cuenta.Id;
        contacto.AMS_TipoContacto__c = 'Agente AMS';
        contacto.AMS_IdUserClickup__c ='6335393';
        insert contacto;
        
        ServiceContract contrato = new ServiceContract();
        contrato.AccountId = cuenta.Id;
        contrato.Name ='Contrato Prueba';
        contrato.AMS_Estatus__c = 'Activo';
        insert contrato;
        
        Case caso = new Case();
        caso.AccountId = cuenta.Id;
        caso.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso.AMS_EspecialistaAsignado__c = contacto.Id;
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
        
        Case caso2 = new Case();
        caso2.AccountId = cuenta.Id;
        caso2.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso2.AMS_EspecialistaAsignado__c = contacto.Id;
        caso2.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso2.Subject = 'Caso prueba';
        caso2.Origin ='Correo Electrónico';
        caso2.AMS_TipoIncidencia__c ='Solicitud';
        caso2.Type ='Type';
        caso2.Status ='En proceso';
        caso2.Nivel__c ='N1';
        caso2.Priority = 'Critica';
        caso2.Tiempo_de_resoluci_n__c ='2';
        insert caso2;
        
        Case caso3 = new Case();
        caso3.AccountId = cuenta.Id;
        caso3.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso3.AMS_EspecialistaAsignado__c = contacto.Id;
        caso3.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso3.Subject = 'Caso prueba';
        caso3.Origin ='Correo Electrónico';
        caso3.AMS_TipoIncidencia__c ='Solicitud';
        caso3.Type ='Type';
        caso3.Status ='En validación';
        caso3.Nivel__c ='N1';
        caso3.Priority = 'Media';
        caso3.Tiempo_de_resoluci_n__c ='3';
        insert caso3;
        
        Case caso4 = new Case();
        caso4.AccountId = cuenta.Id;
        caso4.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso4.AMS_EspecialistaAsignado__c = contacto.Id;
        caso4.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso4.Subject = 'Caso prueba';
        caso4.Origin ='Correo Electrónico';
        caso4.AMS_TipoIncidencia__c ='Solicitud';
        caso4.Type ='Type';
        caso4.Status ='Resuelto';
        caso4.Nivel__c ='N1';
        caso4.Priority = 'Baja';
        caso4.Tiempo_de_resoluci_n__c ='3';
        insert caso4;
        
        Case caso5 = new Case();
        caso5.AccountId = cuenta.Id;
        caso5.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso5.AMS_EspecialistaAsignado__c = contacto.Id;
        caso5.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso5.Subject = 'Caso prueba';
        caso5.Origin ='Correo Electrónico';
        caso5.AMS_TipoIncidencia__c ='Solicitud';
        caso5.Type ='Type';
        caso5.Status ='Cancelado';
        caso5.Nivel__c ='N1';
        caso5.Priority = 'Baja';
        caso5.Tiempo_de_resoluci_n__c ='3';
        insert caso5;
        
        Case caso6 = new Case();
        caso6.AccountId = cuenta.Id;
        caso6.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso6.AMS_EspecialistaAsignado__c = contacto.Id;
        caso6.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso6.Subject = 'Caso prueba';
        caso6.Origin ='Correo Electrónico';
        caso6.AMS_TipoIncidencia__c ='Solicitud';
        caso6.Type ='Type';
        caso6.Status ='Bloqueado';
        caso6.Nivel__c ='N1';
        caso6.Priority = 'Baja';
        caso6.Tiempo_de_resoluci_n__c ='3';
        insert caso6;
        
        Case caso7 = new Case();
        caso7.AccountId = cuenta.Id;
        caso7.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso7.AMS_EspecialistaAsignado__c = contacto.Id;
        caso7.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso7.Subject = 'Caso prueba';
        caso7.Origin ='Correo Electrónico';
        caso7.AMS_TipoIncidencia__c ='Solicitud';
        caso7.Type ='Type';
        caso7.Status ='Escalado';
        caso7.Nivel__c ='N1';
        caso7.Priority = 'Baja';
        caso7.Tiempo_de_resoluci_n__c ='3';
        insert caso7;
        
        Case caso8 = new Case();
        caso8.AccountId = cuenta.Id;
        caso8.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso8.AMS_EspecialistaAsignado__c = contacto.Id;
        caso8.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso8.Subject = 'Caso prueba update';
        caso8.Origin ='Correo Electrónico';
        caso8.AMS_TipoIncidencia__c ='Solicitud';
        caso8.Type ='Type';
        caso8.Status ='Escalado';
        caso8.Nivel__c ='N1';
        caso8.Priority = 'Baja';
        caso8.Tiempo_de_resoluci_n__c ='3';
        insert caso8;
        
        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.Name = caso.Subject;
        datos.Name = caso2.Subject;
        datos.Name = caso3.Subject;
        datos.name = caso4.Subject;
        datos.name = caso5.Subject;
        datos.name = caso6.Subject;
        datos.name = caso7.Subject;

        String body = JSON.serialize(datos);
        
        String json=		'{'+
		'    "data": ['+
		'        {'+
		'            "user": {'+
		'                "id": 6335393,'+
		'                "username": "Daniela Guadalupe Marcos Pizar",'+
		'                "email": "dmarcos@ts4.mx",'+
		'                "color": "#0ab4ff",'+
		'                "initials": "DP",'+
		'                "profilePicture": null'+
		'            },'+
		'            "time": null,'+
		'            "intervals": ['+
		'                {'+
		'                    "id": "3045195976790180707",'+
		'                    "start": null,'+
		'                    "end": null,'+
		'                    "time": null,'+
		'                    "source": "api",'+
		'                    "date_added": "1657303964082",'+
		'                    "billable": null,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                },'+
		'                {'+
		'                    "id": "3045193365768831767",'+
		'                    "start": null,'+
		'                    "end": null,'+
		'                    "time": null,'+
		'                    "source": "api",'+
		'                    "date_added": "1657303808454",'+
		'                    "billable": null,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                },'+
		'                {'+
		'                    "id": "3045192950432072464",'+
		'                    "start": null,'+
		'                    "end": null,'+
		'                    "time": null,'+
		'                    "source": "api",'+
		'                    "date_added": "1657303783705",'+
		'                    "billable": null,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                },'+
		'                {'+
		'                    "id": "3045192466744935171",'+
		'                    "start": null,'+
		'                    "end": null,'+
		'                    "time": null,'+
		'                    "source": "api",'+
		'                    "date_added": "1657303754885",'+
		'                    "billable": null,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                },'+
		'                {'+
		'                    "id": "3045189009682169574",'+
		'                    "start": "1657292747756",'+
		'                    "end": "1657303547756",'+
		'                    "time": "10800000",'+
		'                    "source": "clickup",'+
		'                    "date_added": "1657303548820",'+
		'                    "billable": false,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                },'+
		'                {'+
		'                    "id": "3045188823673175777",'+
		'                    "start": "1657299936398",'+
		'                    "end": "1657303536398",'+
		'                    "time": "3600000",'+
		'                    "source": "clickup",'+
		'                    "date_added": "1657303537739",'+
		'                    "billable": false,'+
		'                    "description": null,'+
		'                    "tags": null'+
		'                }'+
		'            ]'+
		'        }'+
		'    ]'+
		'}';
        
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',body,null));
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',json,null));
        Test.startTest();
        AMS_ClickupIntegration.createTasks(caso.Id);
        AMS_ClickupIntegration.updateTask(caso8.Id,contacto.Id,contacto.Id);
        Test.stopTest();

    }
}