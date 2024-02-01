({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
    
    saveNewCaseHelper : function(component, event) {
        component.set("v.spinner", true);
        var obtenerMapaCaso = component.get("v.NewCase");
        var contactId = component.get("v.contactId");
        console.log(contactId);
        if (component.find("fileId").get("v.files") !== null) {
            var action = component.get('c.saveNewCase');
            action.setParams({'infoCase':obtenerMapaCaso, 'contactId':contactId});
            action.setCallback(this,function(responde){
                var respuesta = responde.getReturnValue();
                console.log('respuesta ',respuesta);
                if(respuesta.status === true){
                    if(respuesta.caseId !== undefined && respuesta.caseId !== null){
                        if (component.find("fileId").get("v.files").length > 0) {
                            this.uploadHelper(component, event, respuesta.caseId);
                        }else {
                            component.set("v.spinner", false);
                            component.set('v.showMessage',true);
                            component.set('v.severityMessage','warning');
                            component.set('v.mensajeRequest','Por favor seleccione un archivo valido.');
                            component.set('v.titleMessage','Warning!');
                        }
                    }
                }
            });
            $A.enqueueAction(action);
            //$A.get('e.force:refreshView').fire();
        }else {
            component.set("v.spinner", false);
            component.set('v.showMessage',true);
            component.set('v.severityMessage','warning');
            component.set('v.mensajeRequest','Por favor seleccione un archivo.');
            component.set('v.titleMessage','Warning!');
        }
    },
    uploadHelper: function(component, event, caseId) {  
        console.log('caseId**! ',caseId);
        component.set("v.showLoadingSpinner", true);
        var fileInput = component.find("fileId").get("v.files"); 
        var file = fileInput[0];
        var self = this; 
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner", false);
            component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
        var objFileReader = new FileReader();  
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
            fileContents = fileContents.substring(dataStart);
            self.uploadProcess(component, file, fileContents, caseId);
        });
        
        objFileReader.readAsDataURL(file);
    },
    
    uploadProcess: function(component, file, fileContents, caseId) {
        var startPosition = 0;  
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '', caseId);
    },
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId, caseId) {
        console.log('caseId** ',caseId);
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: caseId,
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
        action.setCallback(this, function(response) {
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    component.set("v.showLoadingSpinner", false);
                    console.log('attachId ',attachId);
                    component.set('v.showButtonRegister',false);
                    component.set('v.showMessage',true);
                    component.set('v.severityMessage','confirm');
                    component.set('v.mensajeRequest','Se ha registrado!');
                    component.set('v.titleMessage','Success!');
                    component.set("v.spinner", false);
                    var cerrarModalCase = component.getEvent('cerrarModal');
                    cerrarModalCase.fire();
                }        
            } else if (state === "INCOMPLETE") {
                component.set('v.showMessage',true);
                component.set('v.severityMessage','error');
                component.set('v.mensajeRequest',"From server: " + response.getReturnValue());
                component.set('v.titleMessage','Error!');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})