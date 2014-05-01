//
//  DatEjecutivos.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DBAccess.h"
#import "Ejecutivo.h"
#import "EjecutivoComplemento.h"
#import "Distribuidor.h"
@interface DatEjecutivos : DBAccess{
       NSString* mensajeError;
   }
@property (nonatomic,retain) NSString* mensajeError;
-(void) borraTablaEjecutivos;
-(NSString*) insertaEjecutivo: (Ejecutivo*) pObjEjecutivo;
-(NSString*) validarEjecutivo:(Ejecutivo*) pObjEjecutivo;
-(void) actualizaEjecutivo:(NSString*) pIdEjecutivo objEjecutivo: (EjecutivoComplemento*) pObjEjecutivo;
-(NSString*) insertaDistribuidorComoEjecutivo: (Distribuidor*) pObjDistribudor;

@end
