({
    
    getSubunidades: function(component, event, helper) {
        var sendData = component.get('c.getUnidades');
        var idUnidad = component.get('v.recordId');
        console.log('idUnidad',idUnidad);

        sendData.setParams({'url': idUnidad});
        sendData.setCallback(this,function(response){
            var respuesta = response.getReturnValue();  
            console.log('respuesta',respuesta);
            //var urlNext='https://ts4--ts4dev.lightning.force.com/lightning/r/TS4_subunidad__c/'+respuesta+'/view';
            //var urlNext='https://ts4.lightning.force.com/lightning/r/TS4_subunidad__c/'+respuesta+'/view';
            var urlNext ='https://ts4.force.com/ts4u/s/ts4-subunidad/'+respuesta+'/'+''+'';
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": urlNext
            });
            
            urlEvent.fire();
        });
        $A.enqueueAction(sendData);
        
        
    }
})