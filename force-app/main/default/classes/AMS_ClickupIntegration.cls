/*************************************************************** 
Name: AMS_ClickupIntegration
Copyright © 2022 Salesforce
======================================================
Purpose:
Class to create the integration of Service Contracts,Cases in Clickup.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   09/06/2022    INITIAL    Class to create the integration of Service Contracts,Cases in Clickup.
***************************************************************/
public without sharing class AMS_ClickupIntegration {
    
/******************************************************************* 
Purpose: Declaration of variables.
Information about changes (versions)
********************************************************************/ 
    public String name;
    public String content;
    public Long start_date;
    public Long due_date;
    public String status;
    public String assignee;
    public Integer priority;
    public Decimal time_estimate;   
    public Decimal time_spent;
    public Object assignees;
    public class usuarios{
        public Integer[]  add;
        public Integer[]  rem;

    }
    
    //Data Get Time Tracked
    public cls_data[] data;
	class cls_data {
		public cls_user user;
		public String timeTr;
		public cls_intervals[] intervals;
	}
	class cls_user {
		public Integer id;	
		public String username;
		public String email;
		public String color;	
		public String initials;
	}
	
	class cls_intervals {
		public String id;	
		public String start;
		public String endT;
		public String timeT;
		public String source;	
		public String date_added;	
		public String billable;
		public String description;
		public String tags;
	}
    
/******************************************************************* 
Purpose: Create Service Contracts as lists in Clickup.
Parameters: String IdContract.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/ 
    @future(callout=true)
     public static void createLists(String IdContract){
        ServiceContract contrato = [SELECT Id, Name,Description,ContactId,Contact.AMS_IdUserClickup__c,CreatedDate,StartDate,EndDate,
                                    AMS_IdListaClickup__c,AMS_HorasCompradas__c FROM ServiceContract WHERE Id =:IdContract];
        Decimal milliseconds = contrato.AMS_HorasCompradas__c == null ? 0 : contrato.AMS_HorasCompradas__c * 60 * 60 *1000; 
        Datetime dt = contrato.StartDate == null ? null:contrato.StartDate;
        Long startDate = dt == null ? null :dt.getTime();
        Datetime dtEnd = contrato.EndDate == null ? null:contrato.EndDate;
        Long endDate = dtEnd == null ? null :dtEnd.getTime();
         
        AMS_ClickupIntegration prueba = new AMS_ClickupIntegration();
        prueba.name =contrato.Name;
        prueba.assignee = System.label.AMS_ListCreatorUser; //Salvador Pineda
        prueba.start_date =startDate;
        prueba.due_date =endDate;
        prueba.time_estimate =milliseconds;
        prueba.content = contrato.Description == null ? '' : contrato.Description;
        
        String body=JSON.serialize(prueba);
        HttpResponse response= getResponse('POST',body,System.label.AMS_ClickupListEndpointPost);    
        Map<String,Object> values = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        contrato.AMS_IdListaClickup__c = ''+values.get('id');
        upsert contrato;
    }
/******************************************************************* 
Purpose: Create Cases as tasks in Clickup.
Parameters: String IdCase.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/ 
    @future(callout=true)
    public static void createTasks(String IdCase){
        Integer priority;
        String status;
        
        Case caso = [SELECT Id,Subject,Status,Priority,FechaApertura__c,Description,Fecha_Hora_de_cierre__c,ServiceContractId,AMS_IdTareaClickup__c,
                     ServiceContract.AMS_IdListaClickup__c,ContactId,AMS_EspecialistaAsignado__r.AMS_IdUserClickup__c,Tiempo_Real__c,AMS_TiempoEstimado__c FROM Case WHERE Id =:IdCase];
        
        decimal millisecondsTimeEstimate = caso.AMS_TiempoEstimado__c == null ? 0 :caso.AMS_TiempoEstimado__c * 60 * 60 *1000;
        Integer user = caso.AMS_EspecialistaAsignado__r.AMS_IdUserClickup__c ==null ? Integer.valueOf(System.label.AMS_ListCreatorUser):Integer.valueOf(caso.AMS_EspecialistaAsignado__r.AMS_IdUserClickup__c);
        Integer[] users = new Integer[] {user}; 
        Datetime dt = caso.FechaApertura__c == null ? null:caso.FechaApertura__c;
        Long startDate = dt == null ? null :dt.getTime();
        Datetime dtEnd = caso.Fecha_Hora_de_cierre__c == null ? null:caso.Fecha_Hora_de_cierre__c;
        Long endDate = dtEnd == null ? null :dtEnd.getTime();
        
        if(caso.Priority=='Critica'){
            priority = 1;
        }else if(caso.Priority=='Alta'){
            priority = 2;
        }else if(caso.Priority=='Media'){
            priority = 3;
        }else if(caso.Priority=='Baja'){
            priority = 4;
        }
        
        if(caso.Status =='Nuevo'){
            status ='Open';
        }else if(caso.Status =='En proceso'){
            status ='In progress';
        }else if(caso.Status =='En validación' || caso.Status =='Necesita correcciones' || caso.Status =='On hold' || caso.Status =='QA' || caso.Status =='UAT'){
            status ='Testing';
        }else if(caso.Status =='Paquete a producción' || caso.Status =='Escalado'){
            status ='Completed';
            
        }else if(caso.Status =='Cancelado' || caso.Status =='Cerrado' || caso.Status =='Resuelto'){
            status ='Closed';
        }

        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.name = caso.Subject == null ? '' :caso.Subject;
        datos.status= status;
        datos.priority = priority;
        datos.start_date =startDate;
        datos.due_date =endDate;
        datos.assignees =users;
        datos.time_estimate = millisecondsTimeEstimate;
        datos.content = caso.Description == null ? '' : caso.Description;

        String body=JSON.serialize(datos);
        String apiUrl =System.label.AMS_ClickupTaskEndpoint+caso.ServiceContract.AMS_IdListaClickup__c+'/task';
        HttpResponse response= getResponse('POST',body,apiUrl);
        
        Map<String,Object> values = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        System.debug('values'+values);
        caso.AMS_IdTareaClickup__c = ''+values.get('id');     
        update caso;

    }  

/******************************************************************* 
Purpose: Update Cases as tasks in Clickup.
Parameters: String IdCase,String newUser, String oldUser.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/   
    @future(callout=true)
    public static void updateTask(String idCase,String newUser, String oldUser){
        
        Case caso = [SELECT Id,Subject,Status,Priority,FechaApertura__c,Fecha_Hora_de_cierre__c,ServiceContractId,AMS_IdTareaClickup__c,
                     ServiceContract.AMS_IdListaClickup__c,Description,ContactId,Contact.AMS_IdUserClickup__c,Tiempo_Real__c,AMS_TiempoEstimado__c
                     FROM Case WHERE Id =:idCase];
        
        if(Test.isRunningTest()){ 
            
            caso.AMS_IdTareaClickup__c ='prueba';
        }
        
        if(caso.AMS_IdTareaClickup__c !='null'){
            Contact newContact;
        Contact oldContact;
            try {
            newContact = [SELECT Id, Name, AMS_IdUserClickup__c FROM Contact WHERE Id = :newUser];
            oldContact = [SELECT Id, Name, AMS_IdUserClickup__c FROM Contact WHERE Id = :oldUser];
        } catch (QueryException e) {
            // Manejar la excepción cuando no se encuentra el registro de Contact
            // Puedes registrar un error, lanzar una excepción personalizada o tomar otra acción adecuada
            // Por ejemplo:
            System.debug('Error: No se encontró el registro de Contact.');
            return; // O lanzar una excepción personalizada
        }
            
            Integer newUserClickup = newContact.AMS_IdUserClickup__c == null ? Integer.valueOf(System.label.AMS_ListCreatorUser):Integer.valueOf(newContact.AMS_IdUserClickup__c);
            Integer oldUserClickup = oldContact.AMS_IdUserClickup__c == null ? Integer.valueOf(System.label.AMS_ListCreatorUser):Integer.valueOf(oldContact.AMS_IdUserClickup__c);
            Integer old;
            Integer priority;
            String status;
            String etiqueta ='';
            String apiUrl='';
            decimal millisecondsRealTime = caso.Tiempo_Real__c == null ? 0 :caso.Tiempo_Real__c * 60 * 60 *1000;
            decimal millisecondsTimeEstimate = caso.AMS_TiempoEstimado__c == null ? 0 :caso.AMS_TiempoEstimado__c * 60 * 60 *1000;
            Datetime dt = caso.FechaApertura__c == null ? null:caso.FechaApertura__c;
            Long startDate = dt == null ? null :dt.getTime();
            Datetime dtEnd = caso.Fecha_Hora_de_cierre__c == null ? null:caso.Fecha_Hora_de_cierre__c;
            Long endDate = dtEnd == null ? null :dtEnd.getTime();
            
            if(newUserClickup == oldUserClickup){
                old =0;
            }else{
                old =oldUserClickup;
            }
            
            if(caso.Priority=='Critica'){
                priority = 1;
            }else if(caso.Priority=='Alta'){
                priority = 2;
            }else if(caso.Priority=='Media'){
                priority = 3;
            }else if(caso.Priority=='Baja'){
                priority = 4;
            }
            
            if(caso.Status =='Nuevo'){
                status ='Open';
            }else if(caso.Status =='En proceso'){
                status ='In progress';
            }else if(caso.Status =='Necesita correcciones' || caso.Status =='On hold' || caso.Status =='QA' || caso.Status =='UAT'){
                status ='Testing';
            }else if(caso.Status =='Paquete a producción' || caso.Status =='Escalado'){
                status ='Completed';
                
            }else if(caso.Status =='Cerrado' || caso.Status =='Resuelto'){
                status ='Closed';
                
            }else if(caso.Status =='Cancelado'){
                status ='Closed';
                etiqueta = 'Cancelado';
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/'+etiqueta;
                HttpResponse response= getResponse('POST','',apiUrl);     
            }
            else if(caso.Status =='Bloqueado'){
                status ='In progress';
                etiqueta = 'Bloqueado';            
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/'+etiqueta;
                HttpResponse response= getResponse('POST','',apiUrl);
                
            }else if(caso.Status =='Escalado'){
                status ='Completed';
                etiqueta = 'Escalado';
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/'+etiqueta;
                HttpResponse response= getResponse('POST','',apiUrl);
            }
            if(caso.Status !='Cancelado'){
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/cancelado';
                HttpResponse response= getResponse('DELETE','',apiUrl);       
            }
            if(caso.Status !='Bloqueado'){
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/bloqueado';
                HttpResponse response= getResponse('DELETE','',apiUrl);
            }
            if(caso.Status !='Escalado'){
                apiUrl = System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/tag/escalado';
                HttpResponse response= getResponse('DELETE','',apiUrl);
            }
            
            AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
            Integer[] userAnt = new Integer[] {old}; 
                Integer[] userAct = new Integer[] {newUserClickup}; 
                    usuarios us = new usuarios();
            us.add = userAct;
            us.rem = userAnt;
            datos.name = caso.Subject == null ? '' :caso.Subject;
            datos.status= status;
            datos.priority = priority;
            datos.assignees=us;
            datos.time_estimate = millisecondsTimeEstimate;
            datos.start_date =startDate;
            datos.due_date =endDate;
            datos.content = caso.Description == null ? '' : caso.Description;
            ///Get Time Tracked
            HttpResponse responsegetTimeTracked= getResponse('GET','',System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/time/');
            System.debug('responsegetTimeTracked'+responsegetTimeTracked);
            AMS_ClickupIntegration responseTask = (AMS_ClickupIntegration)JSON.deserialize(responsegetTimeTracked.getBody(), AMS_ClickupIntegration.class);
            System.debug('responseTask'+responseTask);        
            if(!Test.isRunningTest()){ 
                for(AMS_ClickupIntegration.cls_data tasks : responseTask.data) {   
                    for(AMS_ClickupIntegration.cls_intervals intervalId : tasks.intervals) {
                        HttpResponse responseDeleteTimeTracked= getResponse('DELETE','',System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/time/'+intervalId.Id);
                    }
                }
                
            }
            
            String bodyTimePost = '{'+
                '"time":'+millisecondsRealTime+
                '}';
            HttpResponse responseCreateTimeTracked= getResponse('POST',bodyTimePost,System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c+'/time/');
            
            ///
            String body=JSON.serialize(datos);
            String apiUrlTask =System.label.AMS_UpdateTasksEndPoint+caso.AMS_IdTareaClickup__c;
            HttpResponse response= getResponse('PUT',body,apiUrlTask);
        }
        
        
        
    }
/******************************************************************* 
Purpose: Service response when creating Service Contracts, creating and updating cases in Clickup.
Parameters: String method,String body, String apiUrl.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/    
     public static HttpResponse getResponse(String method,String body, String apiUrl){
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setMethod(method);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Authorization',System.label.AMS_TokenClickup);
        req.setEndpoint(apiUrl);
        if(body !=''){
             req.setBody(body);
             
         }
        //req.setBody(body);
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('response'+response.getBody());
        return response;

    }
      
}