public without sharing class AMS_LoginPortal {
    
    @auraenabled 
    public static LoginData infoLogin(String user, String pass, Integer intentos){
        LoginData datosLogin = new LoginData();
        datosLogin.userBloqueado ='no bloqueado';
        datosLogin.contactId = 'identificando';
        datosLogin.intentos = intentos+1;
        List<Contact> loginBloq = [SELECT id, AMS_UsuarioBloqueado__c, AMS_FechaBloqueoUsuario__c ,AMS_FormulaDiferenciaFechas__c FROM Contact WHERE Email=:user];        
        if(loginBloq.size() > 0){
            if(loginBloq[0].AMS_UsuarioBloqueado__c == true){
                datosLogin.FormulaDiferenciaFechas= loginBloq[0].AMS_FormulaDiferenciaFechas__c;
                datosLogin.userBloqueado= 'El usuario se encuentra Bloqueado, no podras accesar hasta que se cumpla el tiempo establecido';
            } else {
                List<Contact> login = [SELECT id FROM Contact WHERE Email=:user AND Password__c=:pass];
                if(login.size() > 0 && datosLogin.intentos < 3) {
                    datosLogin.contactId =login[0].id;
                    Contact concatoIniciado = new Contact();
                    concatoIniciado.Id =login[0].id;
                    concatoIniciado.AMS_FechaHrInicioSesion__c= DateTime.now();     
                    update concatoIniciado;
                } 
                if(datosLogin.intentos >= 3){
                    dateTime fechaHActual = system.now();
                    datosLogin.userBloqueado = 'No podras accesar durante 15 minutos, debido a que excedio limite de intentos.';
                    Contact contactBloqueado = new Contact();
                    contactBloqueado.id = loginBloq[0].id;
                    contactBloqueado.AMS_UsuarioBloqueado__c= true;
                    contactBloqueado.AMS_FechaBloqueoUsuario__c= fechaHActual;
                    UPDATE contactBloqueado;
                }
            }
        }
        return datosLogin;
    }
    
    public class LoginData{
        @auraEnabled public String contactId {get;set;}
        @auraEnabled public Integer intentos {get;set;}
        @auraEnabled public String userBloqueado {get;set;} 
        @auraEnabled public Datetime FormulaDiferenciaFechas {get;set;}
    }
}