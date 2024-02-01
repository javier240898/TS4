/*************************************************************** 
Name: AMS_SFClickupIntegration_Test
Copyright © 2022 Salesforce
======================================================
Purpose:
Test class to execute the methods of the class AMS_SFClickupIntegration.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   04/07/2022    INITIAL    Test class to execute the methods of the class AMS_SFClickupIntegration.
***************************************************************/
@isTest
public class AMS_SFClickupIntegration_Test {
    
    @isTest
    public static void getTasks(){
        Account cuenta = new Account();
        cuenta.Name ='Prueba cuenta';
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
        contrato.AMS_IdListaClickup__c ='158301043';
        contrato.AMS_Estatus__c = 'Activo';
        insert contrato;

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
        caso.AMS_IdTareaClickup__c ='2k6ypf1';
        insert caso;  
        
        Case caso2 = new Case();
        caso2.AccountId = cuenta.Id;
        caso2.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso2.Operador__c = contacto.Id;
        caso2.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso2.Subject = 'Caso prueba';
        caso2.Origin ='Correo Electrónico';
        caso2.AMS_TipoIncidencia__c ='Solicitud';
        caso2.Type ='Type';
        caso2.Status ='En proceso';
        caso2.Nivel__c ='N1';
        caso2.Priority = 'Critica';
        caso2.Tiempo_de_resoluci_n__c ='2';
        caso2.AMS_IdTareaClickup__c ='2k6yjbq';
        insert caso2;
        
        Case caso3 = new Case();
        caso3.AccountId = cuenta.Id;
        caso3.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso3.Operador__c = contacto.Id;
        caso3.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso3.Subject = 'Caso prueba';
        caso3.Origin ='Correo Electrónico';
        caso3.AMS_TipoIncidencia__c ='Solicitud';
        caso3.Type ='Type';
        caso3.Status ='En validación';
        caso3.Nivel__c ='N1';
        caso3.Priority = 'Media';
        caso3.Tiempo_de_resoluci_n__c ='3';
        caso2.AMS_IdTareaClickup__c ='2k6x9kp';
        insert caso3;
        
        String json=		'{'+
		'    "tasks": ['+
		'        {'+
		'            "id": "2k6ypf1",'+
		'            "custom_id": null,'+
		'            "name": "Error desarrollo Apex SF",'+
		'            "text_content": "",'+
		'            "description": "",'+
		'            "status": {'+
		'                "status": "Open",'+
		'                "color": "#667684",'+
		'                "type": "custom",'+
		'                "orderindex": 1'+
		'            },'+
		'            "orderindex": "4411971.00024700000000000000000000000000",'+
		'            "date_created": "1656472219763",'+
		'            "date_updated": "1656552569827",'+
		'            "date_closed": null,'+
		'            "archived": false,'+
		'            "creator": {'+
		'                "id": 6335393,'+
		'                "username": "Daniela Guadalupe Marcos Pizar",'+
		'                "color": "#0ab4ff",'+
		'                "email": "dmarcos@ts4.mx",'+
		'                "profilePicture": null'+
		'            },'+
		'            "assignees": ['+
		'                {'+
		'                    "id": 6335393,'+
		'                    "username": "Daniela Guadalupe Marcos Pizar",'+
		'                    "color": "#0ab4ff",'+
		'                    "initials": "DP",'+
		'                    "email": "dmarcos@ts4.mx",'+
		'                    "profilePicture": null'+
		'                }'+
		'            ],'+
		'            "watchers": [],'+
		'            "checklists": [],'+
		'            "tags": [],'+
		'            "parent": null,'+
		'            "priority": {'+
		'                "id": "1",'+
		'                "priority": "urgent",'+
		'                "color": "#f50000",'+
		'                "orderindex": "1"'+
		'            },'+
		'            "due_date": "1656925200000",'+
		'            "start_date": "1656406800000",'+
		'            "points": null,'+
		'            "time_estimate": 32400000,'+
		'            "time_spent": 19800000,'+
		'            "custom_fields": ['+
		'                {'+
		'                    "id": "baee9ebb-fa32-4187-b968-4ec42757c68d",'+
		'                    "name": "Progreso",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true,'+
		'                            "assigned_comments": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1634318700301",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "51f5f18a-876b-4373-bb6c-1045521ddee8",'+
		'                    "name": "Progress",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1632800957705",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "cc3e9676-4e18-48a8-a2ea-24b8debaea33",'+
		'                    "name": "t-shirt size",'+
		'                    "type": "drop_down",'+
		'                    "type_config": {'+
		'                        "default": 0,'+
		'                        "placeholder": null,'+
		'                        "options": ['+
		'                            {'+
		'                                "id": "173a0e0c-3909-485c-aab6-3c1272f1d050",'+
		'                                "name": "XS",'+
		'                                "color": "#2ecd6f",'+
		'                                "orderindex": 0'+
		'                            },'+
		'                            {'+
		'                                "id": "b8f0ff3a-f3a0-46d2-bff9-a3a2661fe828",'+
		'                                "name": "Small",'+
		'                                "color": "#1bbc9c",'+
		'                                "orderindex": 1'+
		'                            },'+
		'                            {'+
		'                                "id": "3aabdb91-da38-4f87-96b7-ef647c81a965",'+
		'                                "name": "Medium",'+
		'                                "color": "#02BCD4",'+
		'                                "orderindex": 2'+
		'                            },'+
		'                            {'+
		'                                "id": "0a47bb97-569e-4c05-8190-ad951f76f923",'+
		'                                "name": "Large",'+
		'                                "color": "#f900ea",'+
		'                                "orderindex": 3'+
		'                            },'+
		'                            {'+
		'                                "id": "a0e68618-0798-4183-8e71-d8d1bd0ddd64",'+
		'                                "name": "XL",'+
		'                                "color": "#e50000",'+
		'                                "orderindex": 4'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    "date_created": "1633106035163",'+
		'                    "hide_from_guests": false,'+
		'                    "required": false'+
		'                }'+
		'            ],'+
		'            "dependencies": [],'+
		'            "linked_tasks": [],'+
		'            "team_id": "14131367",'+
		'            "url": "https://app.clickup.com/t/2k6ypf1",'+
		'            "permission_level": "create",'+
		'            "list": {'+
		'                "id": "158301043",'+
		'                "name": "Contrato280622",'+
		'                "access": true'+
		'            },'+
		'            "project": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "folder": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "space": {'+
		'                "id": "20169593"'+
		'            }'+
		'        },'+
		'        {'+
		'            "id": "2k6yjbq",'+
		'            "custom_id": null,'+
		'            "name": "Reglas de validación SF",'+
		'            "text_content": "",'+
		'            "description": "",'+
		'            "status": {'+
		'                "status": "in progress",'+
		'                "color": "#667684",'+
		'                "type": "custom",'+
		'                "orderindex": 1'+
		'            },'+
		'            "orderindex": "4411972.00029370000000000000000000000000",'+
		'            "date_created": "1656470038099",'+
		'            "date_updated": "1656552615700",'+
		'            "date_closed": null,'+
		'            "archived": false,'+
		'            "creator": {'+
		'                "id": 6335393,'+
		'                "username": "Daniela Guadalupe Marcos Pizar",'+
		'                "color": "#0ab4ff",'+
		'                "email": "dmarcos@ts4.mx",'+
		'                "profilePicture": null'+
		'            },'+
		'            "assignees": ['+
		'                {'+
		'                    "id": 6335393,'+
		'                    "username": "Daniela Guadalupe Marcos Pizar",'+
		'                    "color": "#0ab4ff",'+
		'                    "initials": "DP",'+
		'                    "email": "dmarcos@ts4.mx",'+
		'                    "profilePicture": null'+
		'                }'+
		'            ],'+
		'            "watchers": [],'+
		'            "checklists": [],'+
		'            "tags": [],'+
		'            "parent": null,'+
		'            "priority": {'+
		'                "id": "2",'+
		'                "priority": "high",'+
		'                "color": "#ffcc00",'+
		'                "orderindex": "2"'+
		'            },'+
		'            "due_date": "1656666000000",'+
		'            "start_date": "1656406800000",'+
		'            "points": null,'+
		'            "time_estimate": 36000000,'+
		'            "time_spent": 18000000,'+
		'            "custom_fields": ['+
		'                {'+
		'                    "id": "baee9ebb-fa32-4187-b968-4ec42757c68d",'+
		'                    "name": "Progreso",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true,'+
		'                            "assigned_comments": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1634318700301",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "51f5f18a-876b-4373-bb6c-1045521ddee8",'+
		'                    "name": "Progress",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1632800957705",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "cc3e9676-4e18-48a8-a2ea-24b8debaea33",'+
		'                    "name": "t-shirt size",'+
		'                    "type": "drop_down",'+
		'                    "type_config": {'+
		'                        "default": 0,'+
		'                        "placeholder": null,'+
		'                        "options": ['+
		'                            {'+
		'                                "id": "173a0e0c-3909-485c-aab6-3c1272f1d050",'+
		'                                "name": "XS",'+
		'                                "color": "#2ecd6f",'+
		'                                "orderindex": 0'+
		'                            },'+
		'                            {'+
		'                                "id": "b8f0ff3a-f3a0-46d2-bff9-a3a2661fe828",'+
		'                                "name": "Small",'+
		'                                "color": "#1bbc9c",'+
		'                                "orderindex": 1'+
		'                            },'+
		'                            {'+
		'                                "id": "3aabdb91-da38-4f87-96b7-ef647c81a965",'+
		'                                "name": "Medium",'+
		'                                "color": "#02BCD4",'+
		'                                "orderindex": 2'+
		'                            },'+
		'                            {'+
		'                                "id": "0a47bb97-569e-4c05-8190-ad951f76f923",'+
		'                                "name": "Large",'+
		'                                "color": "#f900ea",'+
		'                                "orderindex": 3'+
		'                            },'+
		'                            {'+
		'                                "id": "a0e68618-0798-4183-8e71-d8d1bd0ddd64",'+
		'                                "name": "XL",'+
		'                                "color": "#e50000",'+
		'                                "orderindex": 4'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    "date_created": "1633106035163",'+
		'                    "hide_from_guests": false,'+
		'                    "required": false'+
		'                }'+
		'            ],'+
		'            "dependencies": [],'+
		'            "linked_tasks": [],'+
		'            "team_id": "14131367",'+
		'            "url": "https://app.clickup.com/t/2k6yjbq",'+
		'            "permission_level": "create",'+
		'            "list": {'+
		'                "id": "158301043",'+
		'                "name": "Contrato280622",'+
		'                "access": true'+
		'            },'+
		'            "project": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "folder": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "space": {'+
		'                "id": "20169593"'+
		'            }'+
		'        },'+
		'        {'+
		'            "id": "2k6x9kp",'+
		'            "custom_id": null,'+
		'            "name": "Error plataforma SF",'+
		'            "text_content": "",'+
		'            "description": "",'+
		'            "status": {'+
		'                "status": "testing",'+
		'                "color": "#a875ff",'+
		'                "type": "custom",'+
		'                "orderindex": 2'+
		'            },'+
		'            "orderindex": "4411968.00018820000000000000000000000000",'+
		'            "date_created": "1656453997091",'+
		'            "date_updated": "1656552521851",'+
		'            "date_closed": null,'+
		'            "archived": false,'+
		'            "creator": {'+
		'                "id": 6335393,'+
		'                "username": "Daniela Guadalupe Marcos Pizar",'+
		'                "color": "#0ab4ff",'+
		'                "email": "dmarcos@ts4.mx",'+
		'                "profilePicture": null'+
		'            },'+
		'            "assignees": ['+
		'                {'+
		'                    "id": 6335392,'+
		'                    "username": "Maria de los Angeles Mauro Esparza",'+
		'                    "color": "#ff00fc",'+
		'                    "initials": "ME",'+
		'                    "email": "mmauro@ts4.mx",'+
		'                    "profilePicture": "https://attachments.clickup.com/profilePictures/6335392_OuE.jpg"'+
		'                }'+
		'            ],'+
		'            "watchers": [],'+
		'            "checklists": [],'+
		'            "tags": [],'+
		'            "parent": null,'+
		'            "priority": {'+
		'                "id": "3",'+
		'                "priority": "normal",'+
		'                "color": "#6fddff",'+
		'                "orderindex": "3"'+
		'            },'+
		'            "due_date": "1656579600000",'+
		'            "start_date": "1656406800000",'+
		'            "points": null,'+
		'            "time_estimate": 36000000,'+
		'            "time_spent": 39600000,'+
		'            "custom_fields": ['+
		'                {'+
		'                    "id": "baee9ebb-fa32-4187-b968-4ec42757c68d",'+
		'                    "name": "Progreso",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true,'+
		'                            "assigned_comments": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1634318700301",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "51f5f18a-876b-4373-bb6c-1045521ddee8",'+
		'                    "name": "Progress",'+
		'                    "type": "automatic_progress",'+
		'                    "type_config": {'+
		'                        "tracking": {'+
		'                            "subtasks": true,'+
		'                            "checklists": true'+
		'                        },'+
		'                        "complete_on": 3,'+
		'                        "subtask_rollup": false'+
		'                    },'+
		'                    "date_created": "1632800957705",'+
		'                    "hide_from_guests": false,'+
		'                    "value": {'+
		'                        "percent_complete": 0'+
		'                    },'+
		'                    "required": false'+
		'                },'+
		'                {'+
		'                    "id": "cc3e9676-4e18-48a8-a2ea-24b8debaea33",'+
		'                    "name": "t-shirt size",'+
		'                    "type": "drop_down",'+
		'                    "type_config": {'+
		'                        "default": 0,'+
		'                        "placeholder": null,'+
		'                        "options": ['+
		'                            {'+
		'                                "id": "173a0e0c-3909-485c-aab6-3c1272f1d050",'+
		'                                "name": "XS",'+
		'                                "color": "#2ecd6f",'+
		'                                "orderindex": 0'+
		'                            },'+
		'                            {'+
		'                                "id": "b8f0ff3a-f3a0-46d2-bff9-a3a2661fe828",'+
		'                                "name": "Small",'+
		'                                "color": "#1bbc9c",'+
		'                                "orderindex": 1'+
		'                            },'+
		'                            {'+
		'                                "id": "3aabdb91-da38-4f87-96b7-ef647c81a965",'+
		'                                "name": "Medium",'+
		'                                "color": "#02BCD4",'+
		'                                "orderindex": 2'+
		'                            },'+
		'                            {'+
		'                                "id": "0a47bb97-569e-4c05-8190-ad951f76f923",'+
		'                                "name": "Large",'+
		'                                "color": "#f900ea",'+
		'                                "orderindex": 3'+
		'                            },'+
		'                            {'+
		'                                "id": "a0e68618-0798-4183-8e71-d8d1bd0ddd64",'+
		'                                "name": "XL",'+
		'                                "color": "#e50000",'+
		'                                "orderindex": 4'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    "date_created": "1633106035163",'+
		'                    "hide_from_guests": false,'+
		'                    "required": false'+
		'                }'+
		'            ],'+
		'            "dependencies": [],'+
		'            "linked_tasks": [],'+
		'            "team_id": "14131367",'+
		'            "url": "https://app.clickup.com/t/2k6x9kp",'+
		'            "permission_level": "create",'+
		'            "list": {'+
		'                "id": "158301043",'+
		'                "name": "Contrato280622",'+
		'                "access": true'+
		'            },'+
		'            "project": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "folder": {'+
		'                "id": "86297568",'+
		'                "name": "Imperquimia",'+
		'                "hidden": false,'+
		'                "access": true'+
		'            },'+
		'            "space": {'+
		'                "id": "20169593"'+
		'            }'+
		'        }'+
		'    ]'+
		'}';
        
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',json,null));
        Test.startTest();
        AMS_SFClickupIntegration.getTasks(contrato.AMS_IdListaClickup__c);
       
       String hora = '0 0 23 * * ?';
       String jobId = System.schedule('AMS_UpdateTasksSFSchedule',
                hora,
                new AMS_UpdateTasksSFSchedule());      
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
            NextFireTime
            FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(0, ct.TimesTriggered,'ok');

        Test.stopTest();
        
    }


}