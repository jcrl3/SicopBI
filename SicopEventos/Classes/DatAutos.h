//
//  DatAutos.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DBAccess.h"
#import "Autos.h"
@interface DatAutos : DBAccess{
         NSString* mensajeError;
}
@property (nonatomic,retain) NSString* mensajeError;
-(void) borraTablaAutos;
-(NSString*) insertaAuto:(Autos*) pObjAuto;
-(NSString*) validarAuto:(Autos*) pObjAuto;

@end
