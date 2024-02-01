({
    consultasBase: function(component) {
        var action = component.get('c.obtenerSetOpciones');
        action.setCallback(this, function(response) {
            var listOpciones = response.getReturnValue();
            component.set('v.valorSetOpciones', listOpciones);
            $A.enqueueAction(actionRespuestas);
        });
        
        var actionRespuestas = component.get('c.obtenerRespuestas');
        actionRespuestas.setParams({
            'idContactoEncuesta': component.get('v.recordId')
        });
        actionRespuestas.setCallback(this, function(response) {
            var responseRespuesta = response.getReturnValue();
            component.set('v.listaRespuesta', responseRespuesta);
            $A.enqueueAction(actionAppContacto);
        });
        var actionAppContacto = component.get('c.obtenerDatosAppEncuesta');
        actionAppContacto.setParams({
            'idAppEncuestaContacto': component.get('v.recordId')
        });
        actionAppContacto.setCallback(this, function(response) {
            var listaRespuesta = component.get('v.listaRespuesta');
            var datosAppEncuesta = response.getReturnValue();
            var listaSetOpciones = component.get('v.valorSetOpciones');
            var datosEncuesta = datosAppEncuesta.encuesta.TS4_endDate__c;
            if (Date.parse(datosEncuesta) >= Date.now()) {
                var datosGuiaEncuesta = datosAppEncuesta.guias;
                for (var i = 0; i < datosGuiaEncuesta.length; i++) {
                    var seccionesGuia = datosGuiaEncuesta[i].secciones;
                    for (var j = 0; j < seccionesGuia.length; j++) {
                        if (seccionesGuia[j].TS4_sectionDependet__c == undefined) {
                            seccionesGuia[j].muestraSeccion = true;
                        } else {
                            seccionesGuia[j].muestraSeccion = false;
                        }
                        var preguntasGuia = seccionesGuia[j].Preguntas__r;
                        for (var k = 0; k < preguntasGuia.length; k++) {
                            if (preguntasGuia[k].TS4_questionDependent__c == undefined) {
                                preguntasGuia[k].muestraPregunta = true;
                            } else {
                                preguntasGuia[k].muestraPregunta = false;
                            }
							preguntasGuia[k].tipoDato = preguntasGuia[k].TS4_TipoDato__c;
                            for (var l = 0; l < listaSetOpciones.length; l++) {
                                if (preguntasGuia[k].TS4_setOptions__c == listaSetOpciones[l].Id) {
                                    var setOpcion = listaSetOpciones[l].Opciones__r;
                                    var opciones = setOpcion.map(item => {
                                        return {
                                        value: item.Id,
                                        label: item.TS4_optionTitle__c
                                    };
                                                                 });
                                    preguntasGuia[k].opciones = opciones;
                                }
                            }
                            for (var m = 0; m < listaRespuesta.length; m++) {
                                if (preguntasGuia[k].Id == listaRespuesta[m].TS4_question__c) {
                                    console.log(preguntasGuia[k]);
                                    if (preguntasGuia[k].TS4_TipoDato__c == 'Set de opciones'){
                                    	preguntasGuia[k].respuesta = listaRespuesta[m].TS4_option__c;    
                                    }else{
                                        preguntasGuia[k].respuesta = listaRespuesta[m].TS4_RespuestaTexto__c;    
                                    }
                                    
                                }
                            }
                            
                            if (preguntasGuia[k].TS4_questionDependent__c != undefined) {
                                for (var n = 0; n < listaRespuesta.length; n++) {
                                    if (preguntasGuia[k].TS4_questionDependent__c == listaRespuesta[n].TS4_question__c && preguntasGuia[k].optionDependent__c == listaRespuesta[n].TS4_option__c) {
                                        preguntasGuia[k].muestraPregunta = true;
                                    }
                                }
                            }
                            if (seccionesGuia[j].TS4_sectionDependet__c != undefined) {
                                
                                for (var papa = 0; papa < seccionesGuia.length; papa++) {
                                    if(seccionesGuia.Id == seccionesGuia[papa].TS4_DependentSeccion__c){
                                        var preguntasGuiaAgain = seccionesGuia[papa].Preguntas__r;
                                        for (var q = 0; q < preguntasGuiaAgain.length; q++) {
                                            if(preguntasGuiaAgain[q].respuesta == seccionesGuia[j].TS4_sectionDependet__c){
                                                seccionesGuia[j].muestraSeccion = true;
                                            }
                                        }
                                    }
                                }
                                if(seccionesGuia[j].muestraSeccion == true){
                                    preguntasGuia[k].muestraPregunta = true;
                                }else{
                                    preguntasGuia[k].muestraPregunta = false;
                                    preguntasGuia[k].respuesta = undefined;
                                }
                            }
                        }
                    }
                }
                
                
                component.set('v.valorContactosApp', datosAppEncuesta);
                console.log(datosAppEncuesta);
            } else {
                $A.util.removeClass(component.find("finEncuesta"), "slds-hide");
                $A.util.addClass(component.find("finEncuesta"), "slds-show");
            };
        });
        $A.enqueueAction(action);
    },
    
    guardaDatosEncuesta: function(component, respuestaLista, tipoGuardado, encuestaContestada) {
        var action = component.get('c.guardaDatosEncuesta');
        action.setParams({
            'listaRespuestas': respuestaLista,
            'encuestaContestada': encuestaContestada
        });
        action.setCallback(this, function(response) {
            var listaRespuestas = response.getReturnValue();
            var datosAppEncuesta = component.get('v.valorContactosApp');
            for (var m = 0; m < listaRespuestas.length; m++) {
                for (var i = 0; i < datosAppEncuesta.length; i++) {
                    var datosGuiaEncuesta = datosAppEncuesta[i].guias;
                    for (var i = 0; i < datosGuiaEncuesta.length; i++) {
                        var seccionesGuia = datosGuiaEncuesta[i].secciones;
                        for (var j = 0; j < seccionesGuia.length; j++) {
                            var preguntasGuia = seccionesGuia[j].Preguntas__r;
                            for (var k = 0; k < preguntasGuia.length; k++) {
                                if (listaRespuestas[m].TS4_question__c == preguntasGuia[k].Id) {
                                    preguntasGuia[k].idContactoEncuesta = listaRespuestas[m].Id;
                                }
                            }
                        }
                    }
                }
            }
            component.set('v.valorContactosApp', datosAppEncuesta);
            if (tipoGuardado == "guardadoGral") {
                var severity = 'confirm'; //it could be 'confirm' or null
                var title = '¡Guardado Exitoso!';
                var message = 'Se ha guardado la información correctamente';
                var messageContainer = component.find("messageContainer");
                messageContainer.displayMessage(severity, title, message);
                
                $A.util.removeClass(component.find("encuesta"), "slds-show");
                $A.util.addClass(component.find("encuesta"), "slds-hide");
                $A.util.removeClass(component.find("agradecimiento"), "slds-hide");
                $A.util.addClass(component.find("agradecimiento"), "slds-show");
                return;
            } else {
                var severity = 'confirm'; //it could be 'confirm' or null
                var title = '¡Guardado Exitoso!';
                var message = 'Se ha guardado la información correctamente';
                var messageContainer = component.find("messageContainer");
                messageContainer.displayMessage(severity, title, message);
                return;
            }
            
        });
        $A.enqueueAction(action);
    }
})