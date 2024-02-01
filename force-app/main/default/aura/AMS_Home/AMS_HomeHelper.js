({
    GetInfoAccount : function(component, event, helper) {
		var contactID = component.get('v.contactID');
        var action = component.get("c.InfoHomeGet");
        action.setParams({'contactId' : contactID});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var respuesta = response.getReturnValue();
                if(respuesta.redirect == true){
                    window.location.href = '/ams?t=0';
                }else{
                    component.set('v.accountID', respuesta.accountId);
                    component.set('v.currentContractId', respuesta.currentContractId);
                    component.set('v.currentContractHistory', respuesta.currentContractHistory);
                    console.log(respuesta.currentContractHistory);
                }
            }
        });
        //$A.get('e.force:refreshView').fire();
        $A.enqueueAction(action);
    }
})