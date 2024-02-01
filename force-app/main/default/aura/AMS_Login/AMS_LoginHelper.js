({
    helperLogin : function(component, event, helper) {
        var action = component.get("c.infoLogin");
        var user = component.find("userName").get("v.value");
        var pass = component.find("password").get("v.value");
        var intentos = component.get("v.intentos");
        action.setParams({'user' : user, 'pass' : pass, 'intentos' : intentos});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var respuesta = response.getReturnValue();
                if(respuesta.userBloqueado != 'no bloqueado'){
                    var horaDesbloqueo = $A.localizationService.formatDateTime(respuesta.FormulaDiferenciaFechas);
                    //alert(horaDesbloqueo);
                    component.set('v.mensajeBloqueo','Podras accesar a la plataforma a la hora '+ horaDesbloqueo +'.');
                    component.set("v.bloqueado", true);
                } else {
                    //console.log("entro aqui");
                    if(respuesta.contactId !='identificando') {
                        window.location.href = '/ams/AMS_Home?contactID='+respuesta.contactId;
                    } else {
                        if(respuesta.intentos == 1 || respuesta.intentos == 2){
                            component.set('v.mensajeBloqueo','Usuario o Password incorrectos.');
                            component.set("v.intentos", respuesta.intentos);
                            //alert("Usuario no encontrado o Pass Incorrecto");
                        }else if(respuesta.intentos == 3){
                            component.set('v.mensajeBloqueo','No podras accesar durante 15 minutos, debido a que exedio limite de intentos.');
                            //alert("No podras accesar durante 15 minutos :(");                        
                        }
                    }
                }
                
                
                
            }
        });
        $A.enqueueAction(action);
    }
})