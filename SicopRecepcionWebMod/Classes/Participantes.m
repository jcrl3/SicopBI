//
//  Participantes.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 26/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Participantes.h"

@implementation Participantes

@synthesize   IdEjecutivo;
@synthesize   Ejecutivo;

-(id) init
{
   if (self == [super init])
   {
      IdEjecutivo=@"";
      Ejecutivo=@"";
   }
	return self;
}

- (void)dealloc {
   IdEjecutivo=nil;
   Ejecutivo=nil;
  	[super dealloc];
}


@end
