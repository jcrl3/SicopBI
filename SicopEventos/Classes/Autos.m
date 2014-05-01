//
//  Autos.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Autos.h"

@implementation Autos

@synthesize idAuto;
@synthesize nombreAuto;

-(id) init
{
   if (self == [super init])
   {
      self.idAuto=@"";
      self.nombreAuto=@"";   
   }
	return self;
}

- (void)dealloc {
   self.idAuto=nil;   
   self.nombreAuto=nil;      
  	[super dealloc];
}


@end
