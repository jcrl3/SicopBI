//
//  Prospecto.h
//  DemoSicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Prospecto : NSObject {
	NSString	*idRegistro;
	NSString	*primerNombre;
	NSString	*segundoNombre;
	NSString	*tercerNombre;
	NSString	*telefono;
	NSString	*telefonoMovil;
	NSString	*correo;
	NSString	*lineaInteres;
	NSString	*ejecutivoAsignado;
	NSString	*hizoPruebaDeManejo;
	NSString	*deseaPruebaDeManejo;
	NSString	*deseaCotizacion;
	NSString	*interesadoAccesorios;
	NSString	*renglonLinea;
	NSString	*renglonEjecutivo;
	NSString	*observaciones;
	NSString	*cp;
	NSString	*idSicop;
	NSString	*idDistribuidor;
	NSString	*autorizaContacto;
}

@property (retain,nonatomic) NSString	*idRegistro;
@property (retain,nonatomic) NSString	*primerNombre;
@property (retain,nonatomic) NSString	*segundoNombre;
@property (retain,nonatomic) NSString	*tercerNombre;
@property (retain,nonatomic) NSString	*telefono;
@property (retain,nonatomic) NSString	*telefonoMovil;
@property (retain,nonatomic) NSString	*correo;
@property (retain,nonatomic) NSString	*lineaInteres;
@property (retain,nonatomic) NSString	*ejecutivoAsignado;
@property (retain,nonatomic) NSString	*hizoPruebaDeManejo;
@property (retain,nonatomic) NSString	*deseaPruebaDeManejo;
@property (retain,nonatomic) NSString	*deseaCotizacion;
@property (retain,nonatomic) NSString	*interesadoAccesorios;
@property (retain,nonatomic) NSString	*renglonLinea;
@property (retain,nonatomic) NSString	*renglonEjecutivo;
@property (retain,nonatomic) NSString	*observaciones;
@property (retain,nonatomic) NSString	*cp;
@property (retain,nonatomic) NSString	*idSicop;
@property (retain,nonatomic) NSString	*idDistribuidor;
@property (retain,nonatomic) NSString	*autorizaContacto;

@end
