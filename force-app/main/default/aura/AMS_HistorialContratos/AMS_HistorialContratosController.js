({
    doInit : function(component, event, helper) {
        
        //helper.GetInfoHistory(component, event, helper);
    },
    cancelarModalHistorial: function(component, event, helper) {
        var cerrarModalHiatorial = component.getEvent('cerrarModalHistorial');
        cerrarModalHiatorial.fire();
    },
    
    consultaDetalle: function(component, event, helper) {
        /*Obtiene ContractID*/
        var contractID = event.getSource().get('v.name');
        /*Invoca el event*/
        var actualizaContractIDHome = component.getEvent('consultaDetail');
        /*Manda el ContractID*/
        actualizaContractIDHome.setParams({'contractID' : contractID});        
        actualizaContractIDHome.fire();
    }
})