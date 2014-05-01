//
//  Urls.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 03/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Urls.h"

//#if TARGET_IPHONE_SIMULATOR
NSString* kUrlServicios;
//#else
//   NSString *const kUrlServicios  = @"http://www.answerspip.com/web/services/mobile";
//#endif

NSString *const kRamaLogin=@"/events/login.xml";
NSString *const kRamaCierraLogin=@"/close.xml";
NSString *const kRamaInfoEvento=@"/events/lista.xml";
NSString *const kRamaDistribuidoresEvento=@"/events/distributors/lista.xml";
NSString *const kRamaEjecutivosEvento=@"/events/executives/lista.xml";
NSString *const kRamaNombreEjecutivo=@"/events/executives/nombre.xml";
NSString *const kRamaAutosEvento=@"/events/cars/lista.xml";
NSString *const kRamaEnvioProspecto=@"/prospects/insert.xml";

@implementation Urls

@end
