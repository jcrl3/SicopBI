//
//  EjecutivoComplemento.m
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "EjecutivoComplemento.h"

@implementation EjecutivoComplemento

@synthesize  nombre;
@synthesize  idDistribuidor; 

-(id) init
{
   if (self == [super init])
   {
      self.nombre=@"";
      self.idDistribuidor=@"";
      
   }
	return self;
}

- (void)dealloc {
   self.nombre=nil;   
   self.idDistribuidor=nil;   
  	[super dealloc];
}

@end
