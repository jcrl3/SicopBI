//
//  InfoDispositivo.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "InfoDispositivo.h"


@implementation InfoDispositivo

-(id) init{
	if(self == [super init])
  {
    // [self getIdDispositivo];
  }
   return self;
}

-(NSString*) getIdDispositivo{
   idDispositivo = [[UIDevice currentDevice] uniqueDeviceIdentifier];
   NSLog(@"ID %@", idDispositivo);
   return idDispositivo;
}

- (void)dealloc
{
	idDispositivo=nil;
   [super dealloc];
}

@end
