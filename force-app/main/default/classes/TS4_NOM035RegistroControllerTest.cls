/**
 * @File Name          : TS4_NOM035RegistroControllerTest.apx
 * @Description        : Clase de prueba de la clase TS4_NOM035RegistroController.apx para el
  						 registro de un Prospecto. 
 * @Author             : mmauro@ts4.mx
 * @Group              : 
 * @Last Modified By   : 
 * @Last Modified On   : 
 * @Modification Log   : 
 * Ver       Date            Author      		         Modification
 * 1.0    22/09/2020    Maria de los Angeles Mauro E.   Initial Version
**/
@isTest
public class TS4_NOM035RegistroControllerTest 
{
    public static testMethod void NOM035Registro()
    {
        TS4_NOM035RegistroController.Suscriptor registroProspecto= new TS4_NOM035RegistroController.Suscriptor();
        registroProspecto.Nombre ='Angeles';
        registroProspecto.Apellido ='Mauro';
        registroProspecto.Email ='mauro@ts4.mx';
        registroProspecto.Compania ='TS4';
        registroProspecto.Telefono ='5551040002';
        TS4_NOM035RegistroController.guardaInscripcion(registroProspecto);
    }
    public static testmethod void pruebaNOM035RegistroError()
    {
        TS4_NOM035RegistroController.Suscriptor registroProspectoErr= new TS4_NOM035RegistroController.Suscriptor();
        registroProspectoErr.Nombre ='Angeles';
        registroProspectoErr.Apellido ='Mauro';
        registroProspectoErr.Email ='mmauro@ts4.mx';
        registroProspectoErr.Compania ='TS4';
        registroProspectoErr.Telefono ='5551040002';
        TS4_NOM035RegistroController.guardaInscripcion(registroProspectoErr);
        TS4_NOM035RegistroController.guardaInscripcion(registroProspectoErr);
    }
}