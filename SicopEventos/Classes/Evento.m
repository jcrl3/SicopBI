//
//  Evento.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Evento.h"

@implementation Evento

@synthesize idEvento;
@synthesize nombreEvento;
@synthesize inicioEvento;
@synthesize finEvento;
@synthesize idFuente;
@synthesize passwordEvento;
@synthesize disclaimer;
@synthesize idSubcampana;
@synthesize activo;
@synthesize soloDistribuidor;
@synthesize idMarca;

-(id) init
{
   if (self == [super init])
   {
       self.idEvento=@"";
       self.nombreEvento=@"";
       self.inicioEvento=@"";
       self.finEvento=@"";
       self.idFuente=@"";
       self.passwordEvento=@"";
       self.disclaimer=@"";
       self.idSubcampana=@"";
       self.activo=TRUE;
       self.soloDistribuidor=@"0";
	   self.idMarca=@"";
   }
	return self;
}

- (void)dealloc {
   self.idEvento=nil;
   self.nombreEvento=nil;
   self.inicioEvento=nil;
   self.finEvento=nil;
   self.idFuente=nil;
   self.passwordEvento=nil;
   self.disclaimer=nil;
   self.idSubcampana=nil;
   self.activo=FALSE;
   self.soloDistribuidor=nil;
   self.idMarca=nil;
  	[super dealloc];
}

@end
