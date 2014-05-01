//
//  UserApp.m
//  SicopRecepcion
//
//  Created by JUAN RAMIREZ on 13/02/13.
//
//

#import "UserApp.h"

@implementation UserApp

@synthesize IdEjecutivo;
@synthesize IdMarca;
@synthesize Marca;
@synthesize Servidor;
@synthesize BaseDeDatos;
@synthesize isTablet;

-(id) init
{
    if (self == [super init]){
      IdEjecutivo=@"";
      IdMarca=@"";
      Marca=@"";
      Servidor=@"";
      BaseDeDatos=@"";
      isTablet=@"";
    }
	return self;
}

- (void)dealloc {
   IdEjecutivo=nil;
   IdMarca=nil;
   Marca=nil;
   Servidor=nil;
   BaseDeDatos=nil;
   isTablet=nil;
  [super dealloc];
}


@end
