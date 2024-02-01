({
    getWebinars : function(component){
        let action = component.get('c.getWebinars'); 
        action.setCallback(this,function(response){
                console.log('getWebinars::');
                console.log(response.getReturnValue());
                component.set('v.webinarsList',response.getReturnValue());
                component.set('v.Suscriptor.Webinar',response.getReturnValue()[0]);

        });   
        $A.enqueueAction(action);
    },
    saveInscripcion : function(component) {
        let guardaInscrito = component.get('c.guardaInscripcion');
        console.log(component.get('v.Suscriptor'));
        guardaInscrito.setParams({'infoSuscriptor':component.get('v.Suscriptor')});
        guardaInscrito.setCallback(this,function(responde){
            if(responde.getReturnValue() == true){
                component.set('v.GuardadoExitoso',true);
            }else{
                component.set('v.mensaje','Ya has sido registrado para esta sesión. !Gracias!');
            }
            
        });
        $A.enqueueAction(guardaInscrito);
	}
})