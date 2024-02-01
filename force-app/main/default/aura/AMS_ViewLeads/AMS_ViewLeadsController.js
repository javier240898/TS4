({
    fetchLeads : function(component, event, helper) {
        var idConcurso = component.get('v.recordId');
        component.set('v.mycolumns', [
            {label: 'Nombre', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Cargo', fieldName: 'Title', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'email'},
            {label: 'Teléfono', fieldName: 'Phone', type: 'phone'},
            {label: 'Estatus', fieldName: 'Status', type: 'Text'}
        ]);
        var action = component.get("c.getDataLeads");
        action.setParams({
            "idLead": idConcurso,
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var recordsEstatus =response.getReturnValue();
            if (recordsEstatus.status === "SUCCESS") {
                var records =recordsEstatus.LeadList;
                records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                component.set("v.leadList", records);
            }else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type" : "info",
                    "title": "Información!",
                    "message": "No se han encontrado prospectos relacionados"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})