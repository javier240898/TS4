({
    doInit: function(component, event, helper) {
        var action = component.get('c.obtieneAppContactos');
        action.setParams({
            'idAppEncuesta': component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var listContactos = response.getReturnValue();
            component.set('v.contactosApp', listContactos);
            $A.enqueueAction(getContacts);
        });

        var getContacts = component.get('c.obtieneContactos');
        getContacts.setParams({
            'idAppEncuesta': component.get('v.recordId')
        });
        getContacts.setCallback(this, function(response) {
            var listContactos = response.getReturnValue();
            var listContactosApp = component.get('v.contactosApp');
            var numberSelected = 0;
            for (var i = 0; i < listContactos.length; i++) {
                for (var j = 0; j < listContactosApp.length; j++) {
                    if (listContactos[i].Id == listContactosApp[j].TS4_contact__c) {
                        listContactos[i].selected = true;
                        numberSelected++;
                    }
                }
            }
            if (listContactos.length == numberSelected) {
                component.find("checkboxAll").set("v.checked", true);
            }
            component.set('v.contactos', listContactos);

        });
        $A.enqueueAction(action);

    },
    handleClick: function(component, event, helper) {
        var listContactos = component.get('v.contactos');
        var listContactosApp = component.get('v.contactosApp');
        var listContactNew = new Array();
        var listContactDelete = new Array();

        for (var i = 0; i < listContactos.length; i++) {
            var existe = false;
            for (var j = 0; j < listContactosApp.length; j++) {
                if (listContactos[i].Id == listContactosApp[j].TS4_contact__c) {
                    existe = true;
                }
            }
            if (!existe && listContactos[i].selected == true) {
                listContactNew.push(listContactos[i]);
            }
            if (existe && listContactos[i].selected == false) {
                listContactDelete.push(listContactos[i]);
            }
        }
        var actionSave = component.get('c.guardarContactos');
        actionSave.setParams({
            'contactos': listContactNew,
            'idAppEncuesta': component.get('v.recordId')
        });
        actionSave.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "¡Exito!",
                    "message": "Contacto agregado a la aplicación de encuesta.",
                    "type": 'success'
                });
                toastEvent.fire();
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "¡Error!",
                    "message": "Ocurrio un error al guardar el contacto.",
                    "type": 'error'
                });
                toastEvent.fire();
            }
            $A.enqueueAction(actionDelete);
        });

        var actionDelete = component.get('c.eliminarContactos');
        actionDelete.setParams({
            'contactosEliminar': listContactDelete,
            'idAppEncuesta': component.get('v.recordId')
        });
        actionDelete.setCallback(this, function(response) {
            var state = response.getState();
            var action = component.get('c.obtieneAppContactos');
            action.setParams({
                'idAppEncuesta': component.get('v.recordId')
            });
            action.setCallback(this, function(response) {
                var listContactos = response.getReturnValue();
                component.set('v.contactosApp', listContactos);
            });
            $A.get('e.force:refreshView').fire();
            $A.get("e.force:closeQuickAction").fire();

            $A.enqueueAction(action);
        });

        $A.enqueueAction(actionSave);
    },
    handleCheck: function(component, event, helper) {
        var isChecked = component.find("checkboxAll").get("v.checked");
        var listContactos = component.get('v.contactos');
        for (var i = 0; i < listContactos.length; i++) {
            listContactos[i].selected = isChecked;
        }
        component.set('v.contactos', listContactos);
    }
})