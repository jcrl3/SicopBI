//
//  Distribuidor.m
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Distribuidor.h"

@implementation Distribuidor

@synthesize  idDistribuidor;
@synthesize  nombreDistribuidor; 

-(id) init
{
   if (self == [super init])
   {
      self.idDistribuidor=@"";
      self.nombreDistribuidor=@"";

   }
	return self;
}

- (void)dealloc {
   self.idDistribuidor=nil;   
   self.nombreDistribuidor=nil;   
  	[super dealloc];
}

@end
