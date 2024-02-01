({
   	GetInfoDetail : function(component, event, helper) {
        var contractID = component.get('v.contractID');
        var action = component.get("c.InfoDetail");
        action.setParams({'currentContractId' : contractID});
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                var respuesta = response.getReturnValue();
                component.set('v.contratoServicioActivo', respuesta.contractList);
                component.set('v.listaCasos', respuesta.caseList);
                var valorBoton = component.get('v.mostrarGraficas');
                if(valorBoton== false || valorBoton=='false'){
                    component.set("v.mostrarGraficas", true);
                    component.set("v.leyendaButtom", 'Cerrar Gráficas de Casos');
                }
            }
        });
        $A.enqueueAction(action);
	}

})