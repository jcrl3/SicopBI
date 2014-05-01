//
//  DatDistribuidor.h
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DBAccess.h"
#import "Distribuidor.h"

@interface DatDistribuidor : DBAccess{
   NSString *mensajeError;
}
@property (nonatomic,retain) NSString *mensajeError;
-(NSString*) insertaDistribuidor:(Distribuidor*) pObjDistribuidor;
-(NSString*) validarDistribuidor:(Distribuidor*) pObjDistribuidor;
-(void) borraTablaDistribuidores;
@end
