/*************************************************************** 
Name: AMS_SFClickupIntegration
Copyright © 2022 Salesforce
======================================================
Purpose:
Class to create the integration to get information about the updated tasks in Clickup.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   30/06/2022    INITIAL    Class to create the integration to get information about the updated tasks in Clickup.
***************************************************************/
public class AMS_SFClickupIntegration {
    
    /******************************************************************* 
Purpose: Declaration of variables.
Information about changes (versions)
********************************************************************/ 
    public cls_tasks[] tasks;
    class cls_tasks {
        public String id;
        public String custom_id;
        public String name;
        public String text_content;
        public String description;	
        public cls_status status;
        public String orderindex;
        public String date_created;
        public String date_updated;
        public String date_closed;
        public boolean archived;
        public cls_creator creator;
        public cls_assignees[] assignees;
        public cls_watchers[] watchers;
        public cls_checklists[] checklists;
        public cls_tags[] tags;
        public String parent;
        public cls_priority priority;
        public String start_date;
        public String due_date;
        public cls_points points;
        public Integer time_estimate;	
        public Integer time_spent;	
        public cls_custom_fields[] custom_fields;
        public cls_dependencies[] dependencies;
        public cls_linked_tasks[] linked_tasks;
        public String team_id;
        public String url;
        public String permission_level;
        public cls_list lista;
        public cls_project project;
        public cls_folder folder;
        public cls_space space;
    }
    class cls_status {
        public String status;
        public String color;
        public String type;	
        public Integer orderindex;	
    }
    class cls_date_closed {
    }
    class cls_creator {
        public Integer id;	
        public String username;	
        public String color;	
        public String email;	
        public String profilePicture;
    }
    
    class cls_assignees {
        public String id;	
        public String username;	
        public String color;	
        public String initials;	
        public String email;	
        public String profilePicture;	
    }
    class cls_watchers {
    }
    class cls_checklists {
    }
    class cls_tags {
    }
    class cls_parent {
    }
    class cls_priority {
        public String id;	
        public String priority;	
        public String color;	
        public String orderindex;
    }
    class cls_due_date {
    }
    class cls_points {
    }
    class cls_custom_fields {
        public String id;	
        public String name;	
        public String type;	
        public cls_type_config type_config;
        public String date_created;	
        public boolean hide_from_guests;
        public cls_value value;
        public boolean required;
    }
    class cls_type_config {
        public cls_tracking tracking;
        public Integer complete_on;	
        public boolean subtask_rollup;
    }
    class cls_tracking {
        public boolean subtasks;
        public boolean checklists;
        public boolean assigned_comments;
    }
    class cls_value {
        public Integer percent_complete;	
    }
    class cls_dependencies {
    }
    class cls_linked_tasks {
    }
    class cls_list {
        public String id;	
        public String name;	
        public boolean access;
    }
    class cls_project {
        public String id;	
        public String name;	
        public boolean hidden;
        public boolean access;
    }
    class cls_folder {
        public String id;	
        public String name;	
        public boolean hidden;
        public boolean access;
    }
    class cls_space {
        public String id;	
    }
    /******************************************************************* 
Purpose: Get the updated information of the Clickup tasks.
Parameters: String idListaClickup.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/ 
    public static List<Case> getTasks(String idListaClickup){
        String apiUrl =System.label.AMS_ClickupTaskEndpoint+idListaClickup+'/task?include_closed=true';
        HttpResponse response= getResponse('GET',apiUrl);
        AMS_SFClickupIntegration responseTask = (AMS_SFClickupIntegration)JSON.deserialize(response.getBody(), AMS_SFClickupIntegration.class);
        List<Case> caso = [SELECT Id,Subject,Status,Priority,FechaApertura__c,Fecha_Hora_de_cierre__c,ServiceContractId,AMS_IdTareaClickup__c,
                           ServiceContract.AMS_IdListaClickup__c,Description,ContactId,Contact.AMS_IdUserClickup__c,Tiempo_Real__c FROM Case 
                           WHERE ServiceContract.AMS_IdListaClickup__c =:idListaClickup AND AMS_IdTareaClickup__c !=null];
        List<Contact> contacto =[SELECT Id,AMS_IdUserClickup__c FROM Contact WHERE AMS_IdUserClickup__c !=null];
        System.debug('contacto'+contacto);
        Map<String,String> mapTask = new Map<String,String> ();
        Map<String,Id> mapContact = new Map<String,Id> ();
        List<Case> listaCasos = new List<Case>();
        String status;
        String priority;
        for(Contact listaContacto : contacto){
            mapContact.put(listaContacto.AMS_IdUserClickup__c,listaContacto.Id);
        }
        for(Case listaClick : caso){
            mapTask.put(listaClick.AMS_IdTareaClickup__c,listaClick.AMS_IdTareaClickup__c);
        }
        
        for(AMS_SFClickupIntegration.cls_tasks tasks : responseTask.tasks) {
            for(String key : mapTask.keySet()){
                if(mapTask.get(key)==tasks.Id){
                    Case caso2 = [SELECT Id,Subject,Status,Priority,FechaApertura__c,Fecha_Hora_de_cierre__c,ServiceContractId,AMS_IdTareaClickup__c,
                                  ServiceContract.AMS_IdListaClickup__c,Description,ContactId,Contact.AMS_IdUserClickup__c,Tiempo_Real__c FROM Case 
                                  WHERE AMS_IdTareaClickup__c=:mapTask.get(key)];
                    
                    if(tasks.status.status =='Open'){
                        status='Nuevo';
                    }else if(tasks.status.status =='in progress'){
                        status='En proceso';
                        
                    }else if(tasks.status.status =='testing'){
                        // status='En validación';
                        status= 'On hold';
                        
                    }else if(tasks.status.status =='Completed' || tasks.status.status =='completed'){
                        // status='Resuelto';
                        status = 'Paquete a producción';
                        
                    }else if(tasks.status.status =='Closed' || tasks.status.status =='closed'){
                        status='Cerrado';
                        
                    }
                    
                    if(tasks.priority.id != null){
                        if(tasks.priority.id =='1'){
                            priority = 'Critica';
                        }else if(tasks.priority.id=='2'){
                            priority = 'Alta';
                        }else if(tasks.priority.id=='3'){
                            priority = 'Media';
                        }else if(tasks.priority.id=='4'){
                            priority = 'Baja';
                        }
                    }
                    
                    Long timestampdue = tasks.due_date==null ? null:Long.valueOf(tasks.due_date);
                    DateTime due_date = timestampdue == null ? null :DateTime.newInstance(timestampdue);     
                    Long timestampstart = tasks.start_date==null ? null: Long.valueOf(tasks.start_date);
                    DateTime start_date = timestampstart==null ? null : DateTime.newInstance(timestampstart);
                    Long millisecondsEstimate = tasks.time_estimate == null ? 0 :tasks.time_estimate ;
                    Long millisecondsTracked = tasks.time_spent == null ? 0 :tasks.time_spent ;
                    
                    Long mins = millisecondsEstimate / 60000;
                    Long hours = mins / 60;
                    Long remainingMins = mins - (hours * 60);                     
                    Decimal toround = remainingMins * 0.0166666667;
                    Decimal rounded = toround.setScale(2);
                    
                    Long minsTracked = millisecondsTracked / 60000;
                    Long hoursTracked = minsTracked / 60;
                    Long remainingMinsTracked = minsTracked - (hoursTracked * 60);                     
                    Decimal toroundTracked = remainingMinsTracked * 0.0166666667;
                    Decimal roundedTracked = toroundTracked.setScale(2);
                    
                    caso2.Subject =tasks.name==null ? null:tasks.name;
                    caso2.Status =status;
                    caso2.Priority =priority;
                    caso2.Description =tasks.text_content==null ? null: tasks.text_content;
                    caso2.Fecha_Hora_de_cierre__c = due_date;
                    caso2.FechaApertura__c = start_date;
                    caso2.AMS_TiempoEstimado__c = hours + rounded;
                    caso2.Tiempo_Real__c = hoursTracked + roundedTracked;
                    
                    /*for(AMS_SFClickupIntegration.cls_assignees asignes : tasks.assignees) {
                        if(mapContact.containskey(asignes.id)){
                            Contact contacto2 =[SELECT Id,AMS_IdUserClickup__c FROM Contact WHERE AMS_IdUserClickup__c !=null AND AMS_IdUserClickup__c =:asignes.Id];
                            caso2.Operador__c = contacto2.Id;
                            
                        }else{
                            Contact contactoCreador =[SELECT Id,AMS_IdUserClickup__c FROM Contact WHERE AMS_IdUserClickup__c =:System.label.AMS_ListCreatorUser];
                            caso2.Operador__c = contactoCreador.Id;

                        }
                    } */ 
                    listaCasos.add(caso2);
                    
                }
            }
            
        }
        return listaCasos;
        
        
        
    }
    /******************************************************************* 
Purpose: Response of the service when the information of the updated tasks is obtained.
Parameters: String method,String apiUrl.
Returns: 
Throws :
Information about changes (versions)
********************************************************************/    
    public static HttpResponse getResponse(String method, String apiUrl){
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setMethod(method);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Authorization',System.label.AMS_TokenClickup);
        req.setEndpoint(apiUrl);
        Http http = new Http();
        HTTPResponse response = http.send(req);
        return response;
        
    }
}