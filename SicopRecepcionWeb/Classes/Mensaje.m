//
//  Mensaje.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Mensaje.h"

@implementation Mensaje

@synthesize  idMensaje;
@synthesize  mensaje;
@synthesize  idEnviado;
@synthesize  fecha;
@synthesize  tipo;
@synthesize  remitente;
@synthesize  enviado;
@synthesize  idRegistro;
@synthesize  leido;
@synthesize idDistribuidor;
-(id) init
{
   if (self == [super init])
   {
      
    idMensaje =[[NSString alloc] init];
    mensaje =[[NSString alloc] init];
    idEnviado=[[NSString alloc] init];
    fecha=[[NSString alloc] init];
    tipo=[[NSString alloc] init];
    remitente=[[NSString alloc] init];   
    enviado=[[NSString alloc] init];
    idRegistro=[[NSString alloc] init];
    leido=[[NSString alloc] init];
    idDistribuidor=[[NSString alloc]init];
      
      idMensaje=@"";
      mensaje=@"";
      idEnviado=@"";
      fecha=@"";
      tipo=@"";
      remitente=@"";
      enviado=@"";
      idRegistro=@"";
      leido=@"";
      idDistribuidor=@"";
   }
	return self;
}

- (void)dealloc {
   
   [idMensaje release];
   [mensaje release];
   [idEnviado release];
   [fecha release];
   [tipo release];
   [remitente release];
   [enviado release];
   [idRegistro release];
   [leido release];
   [idDistribuidor release];
   
   idMensaje=nil;
   mensaje=nil;
   idEnviado=nil;
   fecha=nil;
   tipo=nil;
   remitente= nil;
   enviado=nil;
   idRegistro=nil;
   leido=nil;
   idDistribuidor=nil;
   
   
  	[super dealloc];
}

@end
