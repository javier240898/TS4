/***************************************************************
Name: TaskTrigger()
Copyright © 2020 Salesforce
======================================================
Purpose:
Para automatizar la asignación del campo Tipo acorde al Asunto con abreviaturas
======================================================
History:
VERSION AUTHOR DATE DETAIL Description
1.0  sreyna@ts4.mx 11/05/2022 Se configurá haciendo uso de un Tipo de metadato que almacena las palabras cortas
***************************************************************/
trigger TS4_TaskTrigger on Task (before insert, before update) {
    
    List<TS4AsuntoEventos__mdt> asuntosMDT = [SELECT Id, DeveloperName, MasterLabel FROM TS4AsuntoEventos__mdt];
    
    for(Task tarea: Trigger.new){
        for(TS4AsuntoEventos__mdt asuntoMDT : asuntosMDT){
            if(tarea.Subject.contains (asuntoMDT.MasterLabel)){
                tarea.Type = asuntoMDT.DeveloperName;
            }
        }
    }

}