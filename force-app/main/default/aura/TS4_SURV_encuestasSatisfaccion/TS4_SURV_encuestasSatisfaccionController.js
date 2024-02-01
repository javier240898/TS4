({
    doInit: function(component, event, helper) {
        helper.consultasBase(component);
    },
    
    handleClick: function(component, event, helper) {
        var selTabId = component.get('v.selTabId');
        var datosAppEncuesta = component.get('v.valorContactosApp');
        var listaRespuesta = component.get('v.listaRespuesta');
        var respuestaLista = [];
        var existeRespuesta = true;
        for (var i = 0; i < datosAppEncuesta.length; i++) {
            var datosGuiaEncuesta = datosAppEncuesta[i].guias;
            for (var i = 0; i < datosGuiaEncuesta.length; i++) {
                var seccionesGuia = datosGuiaEncuesta[i].secciones;
                for (var j = 0; j < seccionesGuia.length; j++) {
                    if (seccionesGuia[j].TS4_referenceGuide__c == selTabId) {
                        var preguntasGuia = seccionesGuia[j].Preguntas__r;
                        for (var k = 0; k < preguntasGuia.length; k++) {
                            console.log(preguntasGuia[k]);
                            if (preguntasGuia[k].muestraPregunta == true) {
                                if (preguntasGuia[k].respuesta == undefined || preguntasGuia[k].respuesta == "" || preguntasGuia[k].respuesta == null) {
                                    existeRespuesta = false;
                                    break;
                                } else {
                                    var respuestaOBJ = {};
                                    respuestaOBJ.sobjectType = 'TS4_response__c';
                                    respuestaOBJ.TS4_question__c = preguntasGuia[k].Id;
                                    if(preguntasGuia[k].tipoDato =='Set de opciones'){
                                    	respuestaOBJ.TS4_option__c = preguntasGuia[k].respuesta;
                                    }else{
                                        respuestaOBJ.TS4_RespuestaTexto__c = preguntasGuia[k].respuesta;
                                    }
                                    respuestaOBJ.TS4_contactSurveyApplication__c = component.get('v.recordId');
                                    if (preguntasGuia[k].idContactoEncuesta != undefined) {
                                        respuestaOBJ.Id = preguntasGuia[k].idContactoEncuesta;
                                    } else if (preguntasGuia[k].idContactoEncuesta == undefined) {
                                        for (var l = 0; l < listaRespuesta.length; l++) {
                                            if (preguntasGuia[k].Id == listaRespuesta[l].TS4_question__c) {
                                                respuestaOBJ.Id = listaRespuesta[l].Id;
                                            }
                                        }
                                    }
                                    respuestaLista.push(respuestaOBJ);
                                }
                            }
                        }
                        if (!existeRespuesta) {
                            break;
                        }
                    }
                }
            }
        }
        if (!existeRespuesta) {
            var severity = 'error'; //it could be 'confirm' or null
            var title = 'Revise el siguiente mensaje';
            var message = 'Faltan preguntas por contestar';
            var messageContainer = component.find("messageContainer");
            messageContainer.displayMessage(severity,title,message);
            return;
        } else {
            helper.guardaDatosEncuesta(component, respuestaLista, "guardadoIndv", false);
        }
    },
    sendClick: function(component, event, helper) {
        component.set('v.Enviado', 'true');
        var selTabId = component.get('v.selTabId');
        var datosAppEncuesta = component.get('v.valorContactosApp');
        var listaRespuesta = component.get('v.listaRespuesta');
        var respuestaLista = [];
        var existeRespuesta = true;
        for (var i = 0; i < datosAppEncuesta.length; i++) {
            var datosGuiaEncuesta = datosAppEncuesta[i].guias;
            for (var i = 0; i < datosGuiaEncuesta.length; i++) {
                var seccionesGuia = datosGuiaEncuesta[i].secciones;
                for (var j = 0; j < seccionesGuia.length; j++) {
                    var preguntasGuia = seccionesGuia[j].Preguntas__r;
                    for (var k = 0; k < preguntasGuia.length; k++) {
                        console.log(preguntasGuia[k]);
                        if (preguntasGuia[k].muestraPregunta == true) {
                            if (preguntasGuia[k].respuesta == undefined || preguntasGuia[k].respuesta == "" || preguntasGuia[k].respuesta == null) {
                                existeRespuesta = false;
                                break;
                            } else {var respuestaOBJ = {};
                                respuestaOBJ.sobjectType = 'TS4_response__c';
                                respuestaOBJ.TS4_question__c = preguntasGuia[k].Id;
                                if(preguntasGuia[k].tipoDato =='Set de opciones'){
                                    	respuestaOBJ.TS4_option__c = preguntasGuia[k].respuesta;
                                    }else{
                                        respuestaOBJ.TS4_RespuestaTexto__c = preguntasGuia[k].respuesta;
                                    }
                                respuestaOBJ.TS4_contactSurveyApplication__c = component.get('v.recordId');
                                if (preguntasGuia[k].idContactoEncuesta != undefined) {
                                    respuestaOBJ.Id = preguntasGuia[k].idContactoEncuesta;
                                } else if (preguntasGuia[k].idContactoEncuesta == undefined) {
                                    for (var l = 0; l < listaRespuesta.length; l++) {
                                        if (preguntasGuia[k].Id == listaRespuesta[l].TS4_question__c) {
                                            respuestaOBJ.Id = listaRespuesta[l].Id;
                                            component.set('v.Enviado', 'false');
                                        }
                                    }
                                }
                                respuestaLista.push(respuestaOBJ);
                            }
                        }
                    }
                    if (!existeRespuesta) {
                        break;
                    }
                }
            }
        }
        if (!existeRespuesta) {
            var severity = 'error'; //it could be 'confirm' or null
            var title = 'Revise el siguiente mensaje';
            var message = 'Faltan preguntas por contestar';
            var messageContainer = component.find("messageContainer");
            messageContainer.displayMessage(severity,title,message);
            return;
        } else {
            helper.guardaDatosEncuesta(component, respuestaLista, "guardadoGral", true);
            
        }
    },
    handleChange: function(component, event, helper) {
        var changeValue = event.getParam("value");
        var idPregunta = event.getSource().get('v.name');
        var datosAppEncuesta = component.get('v.valorContactosApp');
        for (var i = 0; i < datosAppEncuesta.length; i++) {
            var datosGuiaEncuesta = datosAppEncuesta[i].guias;
            for (var i = 0; i < datosGuiaEncuesta.length; i++) {
                var seccionesGuia = datosGuiaEncuesta[i].secciones;
                var seccionPregunta = '';
                for (var j = 0; j < seccionesGuia.length; j++) {
                    if (seccionesGuia[j].TS4_sectionDependet__c != undefined) {
                        seccionesGuia[j].muestraSeccion = false;
                        if (changeValue == seccionesGuia[j].TS4_sectionDependet__c && seccionPregunta == seccionesGuia[j].TS4_DependentSeccion__c) {
                            seccionesGuia[j].muestraSeccion = true;
                        }
                    } 
                    var preguntasGuia = seccionesGuia[j].Preguntas__r;
                    
                    for (var k = 0; k < preguntasGuia.length; k++) {
                        if (idPregunta == preguntasGuia[k].Id){
                            seccionPregunta = seccionesGuia[j].Id;
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
                        if (preguntasGuia[k].TS4_questionDependent__c == idPregunta) {
                            if (changeValue == preguntasGuia[k].optionDependent__c) {
                                preguntasGuia[k].muestraPregunta = true;
                            } else {
                                preguntasGuia[k].muestraPregunta = false;
                                preguntasGuia[k].respuesta = undefined;
                            }
                        }
                    }
                }
            }
        }
        component.set('v.valorContactosApp', datosAppEncuesta);
    },
    startClick: function(component, event, helper) {
        $A.util.removeClass(component.find("bienvenida"), "slds-show");
        $A.util.addClass(component.find("bienvenida"), "slds-hide");
        $A.util.removeClass(component.find("encuesta"), "slds-hide");
        $A.util.addClass(component.find("encuesta"), "slds-show");
    }
})