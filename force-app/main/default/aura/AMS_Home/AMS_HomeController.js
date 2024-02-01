({
     abrirModalCasos : function(component, event, helper) {
        component.set('v.NewCase',{});
        component.set('v.showButtonRegister',true);
		component.set('v.showModalCasos',true);
	},
    
    cancelarCaso : function(component, event, helper) {
        var componentServiceContract = component.find("ServiceContractDetail");
        componentServiceContract.initAgain(event.getParam('contractID'));
        component.set('v.showModalCasos',false);
	},
    
     cancelarHistorial : function(component, event, helper) {
        component.set('v.showModalHistorial',false);
	},
    
    doInit : function(component, event, helper) {
        var contactID = component.get('v.contactID');
        helper.GetInfoAccount(component, event, helper);
        
    },
    
    abrirModalHistorial : function(component, event, helper) {
		component.set('v.showModalHistorial',true);
	},
    
    actualizaCurrentIDHome : function(component, event, helper) {
        var componentServiceContract = component.find("ServiceContractDetail");
        component.set('v.showModalHistorial',false);
        component.set('v.currentContractId', event.getParam('contractID'));
        componentServiceContract.initAgain(event.getParam('contractID'));
	},
    
})