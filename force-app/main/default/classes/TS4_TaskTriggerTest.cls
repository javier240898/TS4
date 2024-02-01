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

@isTest
public class TS4_TaskTriggerTest {

    testmethod static void testTaskTrigger(){
        Task tarea = new Task();
        tarea.Subject = 'S* Test Subject';
        insert tarea;
    }
}