//
//  Usuario.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

@synthesize IdProspecto;
@synthesize IdEjecutivo;
@synthesize IdDispositivo;
@synthesize IdMarca;
@synthesize Distribuidor;
@synthesize Ejecutivo;
@synthesize Prospecto;
@synthesize IdDistribuidor;
@synthesize PaginaWEB;
@synthesize Puesto;
@synthesize TelefonoDistribuidor;
@synthesize Telefono;
@synthesize Celular;
@synthesize Radio;
@synthesize ClaveRadio;
@synthesize direccion;
@synthesize longitude;
@synthesize latitude;

-(id) init
{
   if (self == [super init])
   {
      IdProspecto=@"";
      IdEjecutivo=@"";
      IdDispositivo=@"";
      IdMarca=@"";
      Distribuidor=@"";
      Ejecutivo=@"";
      Prospecto=@"";
      IdDistribuidor=@"";
      PaginaWEB=@"";
      Puesto=@"";
      TelefonoDistribuidor=@"";
      Telefono=@"";
      Celular=@"";
      Radio=@"";
      ClaveRadio=@"";
      direccion=@"";
      latitude=@"0.0";
      longitude=@"0.0";
    }
	return self;
}

- (void)dealloc {
   IdProspecto=nil;
   IdEjecutivo=nil;
   IdDispositivo=nil;
   IdMarca=nil;
   Distribuidor=nil;
   Ejecutivo=nil;
   Prospecto=nil;
   IdDistribuidor=nil;
   PaginaWEB=nil;
   Puesto=nil;
   TelefonoDistribuidor=nil;
   Telefono=nil;
   Celular=nil;
   Radio=nil;
   ClaveRadio=nil;
   direccion=nil;
   
   
  	[super dealloc];
}


@end
