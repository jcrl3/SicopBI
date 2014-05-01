//
//  Urls.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 03/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Urls.h"

#if TARGET_IPHONE_SIMULATOR
//  NSString *const kUrlServicios  =@"http://www.answerspip.com/development";
  NSString *const kUrlServicios  = @"https://www.sicopweb.com";
#else
  NSString *const kUrlServicios  = @"https://www.sicopweb.com";
#endif

//NSString *const kRamaLogin=@"/ford/verify.xml";
NSString *const kRamaLogin=@"/7.0.37/workspace/verify.xml";
NSString *const kRamaEnvio=@"/web/services/mobile/check/prospect.xml";
NSString *const kRamaWorkspace=@"/7.0.37/workspace/";

@implementation Urls

//https://www.sicopweb.com/7.0.37/workspace/verify.xml?Login=ventas1@soniinsurgentes.com&Password=nissan
@end
