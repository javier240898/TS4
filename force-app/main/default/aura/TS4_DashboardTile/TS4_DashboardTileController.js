({
	doInit : function(component, event, helper) {
        
		let blueScale=component.get('v.blueScale');
        let greenScale=component.get('v.greenScale');
        let yellowScale=component.get('v.yellowScale');
        let orangeScale=component.get('v.orangeScale');
        let redScale=component.get('v.redScale');
        
        let scoreValue=component.get('v.scoreValue');
        
        console.log(scoreValue,blueScale,greenScale,yellowScale,orangeScale, redScale);
        
        if(scoreValue < blueScale){
            let changeBadge = component.find('blue');
            component.set('v.blueValue', scoreValue);
            $A.util.addClass(changeBadge, 'slds-active');
        }else if(scoreValue < greenScale){
            console.log(scoreValue);
            let changeBadge = component.find('green');
            component.set('v.greenValue', scoreValue);
            $A.util.addClass(changeBadge, 'slds-active');
        }else if(scoreValue < yellowScale){
            let changeBadge = component.find('yellow');
            component.set('v.yellowValue', scoreValue);
            $A.util.addClass(changeBadge, 'slds-active');
        }else if(scoreValue < orangeScale){
            let changeBadge = component.find('orange');
            component.set('v.orangeValue', scoreValue);
            $A.util.addClass(changeBadge, 'slds-active');
        }else if(scoreValue < redScale){
            let changeBadge = component.find('red');
            component.set('v.redValue', scoreValue);
            $A.util.addClass(changeBadge, 'slds-active');
        }
	}
})