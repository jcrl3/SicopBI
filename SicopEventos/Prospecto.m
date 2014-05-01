//
//  Prospecto.m
//  DemoSicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Prospecto.h"


@implementation Prospecto
@synthesize idRegistro;
@synthesize primerNombre;
@synthesize segundoNombre;
@synthesize tercerNombre;
@synthesize telefono;
@synthesize telefonoMovil;
@synthesize correo;
@synthesize lineaInteres;
@synthesize ejecutivoAsignado;
@synthesize hizoPruebaDeManejo;
@synthesize deseaPruebaDeManejo;
@synthesize deseaCotizacion;
@synthesize interesadoAccesorios;
@synthesize renglonLinea;
@synthesize renglonEjecutivo;
@synthesize observaciones;
@synthesize cp;
@synthesize idSicop;
@synthesize idDistribuidor;
@synthesize autorizaContacto;

-(id) init
{
   if (self == [super init])
   {
       self.idRegistro=@"";
       self.primerNombre=@"";
       self.segundoNombre=@"";
       self.tercerNombre=@"";
       self.telefono=@"";
	   self.telefonoMovil=@"";
       self.correo=@"";
       self.lineaInteres=@"";
       self.ejecutivoAsignado=@"";
       self.hizoPruebaDeManejo=@"";
       self.deseaPruebaDeManejo=@"";
       self.deseaCotizacion=@"";
       self.interesadoAccesorios=@"";
       self.renglonLinea=@"";
       self.renglonEjecutivo=@"";
       self.observaciones=@"";
       self.cp=@"";
       self.idSicop=@"";
       self.idDistribuidor=@"";
	   self.autorizaContacto=@"1";
   }
	return self;
}

- (void)dealloc {
	self.idRegistro=nil;
	self.primerNombre=nil;
	self.segundoNombre=nil;
	self.tercerNombre=nil;
	self.telefono=nil;
	self.telefonoMovil=nil;
	self.correo=nil;
	self.lineaInteres=nil;
	self.ejecutivoAsignado=nil;
	self.hizoPruebaDeManejo=nil;
	self.deseaPruebaDeManejo=nil;
	self.deseaCotizacion=nil;
	self.interesadoAccesorios=nil;
	self.renglonLinea=nil;
	self.renglonEjecutivo=nil;
	self.observaciones=nil;
	self.cp=nil;
	self.idSicop=nil;
	self.idDistribuidor=nil;
	self.autorizaContacto=nil;
  	[super dealloc];
}

@end
