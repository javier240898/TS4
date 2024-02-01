({
	saveInscripcion : function(component) {
        let guardaInscrito = component.get('c.guardaInscripcion');
        guardaInscrito.setParams({'infoSuscriptor':component.get('v.Suscriptor')});
        guardaInscrito.setCallback(this,function(responde){
            if(responde.getReturnValue() === true)
            {
                component.set('v.GuardadoExitoso',true);
                console.log('Ya entra en exito');
            }
            else
            {
                component.set('v.mensaje','Ya has sido registrado. !Gracias!');
                console.log('Entra a error');
            }
        });
        $A.enqueueAction(guardaInscrito);
	}
})