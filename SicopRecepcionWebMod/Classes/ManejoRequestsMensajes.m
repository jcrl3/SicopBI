//
//  ManejoRequestsMensajes.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 30/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "ManejoRequestsMensajes.h"
#import "SicopRecepcionAppDelegate.h"
@implementation ManejoRequestsMensajes

- (ManejoRequestsMensajes *) initWithRequest{
	[super init];
	appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
	return self;
}

#pragma mark-
#pragma mark rutinas de parseo
- (void)requestFinished:(ASIHTTPRequest *)request
{
   BOOL finExistoso;
   NSData *xmlData = [[NSMutableData alloc] init];
   xmlData= [request responseData];
   NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
   XMLParser *parser = [[XMLParser alloc] initXMLParser];
   
   //Establezco el delegate
   parser.nmClaseDatos=@"Mensaje";
   [xmlParser setDelegate:parser];
   finExistoso= [xmlParser parse];
   

   NSString *response = [request responseString];
   NSLog(@"RES %@" ,  response);
   if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
      [appDelegate muestraAlertNoConexion:@"Hubo un error en la transferencia de datos."];
      return;
   }

   
   if(finExistoso){
      NSMutableArray* conversacion= [[NSMutableArray  alloc] init];
      [conversacion addObjectsFromArray:appDelegate.platica];      

      //por cada uno de los mensajes los grabo en la BD.
      for (Mensaje  *msj   in conversacion){
         if (msj.fecha!=nil){ 
             msj.leido=@"0";
            msj.idDistribuidor= appDelegate.usuarioActivo.IdDistribuidor;
            [appDelegate.datosMensajes insertaMensaje:msj fueraDelinea:NO];
             [[NSUserDefaults standardUserDefaults] setObject:msj.fecha forKey:kAppValorFechaUtimaLecturaGeneral];
          }  
      }

      [conversacion release];
     [[NSNotificationCenter defaultCenter] postNotificationName:kRecepcionNuevosMensajesNotificacion object:nil];
      
   }else{
      NSLog(@"Error Error Error!!!");
   }
   
   [xmlData release];
   [xmlParser release];
   [parser release];
   
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
   NSError *error = [request error];
   [appDelegate muestraAlertNoConexion:@"Error al momento de recuperar datos del servidor."];
    NSLog(@"Descripcion del error en el request %@", error.description);
}

-(void) dealloc{
   [super dealloc];
}

@end
