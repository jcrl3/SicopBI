//
//  Ejecutivo.m
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 25/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Ejecutivo.h"


@implementation Ejecutivo

@synthesize  idEjecutivo;

-(id) init
{
   if (self == [super init])
   {
      self.idEjecutivo=@"";
   }
	return self;
}

- (void)dealloc {
   self.idEjecutivo=nil;   
  	[super dealloc];
}

@end
