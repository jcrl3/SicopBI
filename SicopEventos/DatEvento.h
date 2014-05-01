//
//  DatEvento.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DBAccess.h"
#import "Evento.h"
@interface DatEvento : DBAccess{
   NSString* mensajeError;
}
@property (nonatomic,retain) NSString* mensajeError;
-(void) borraTablaEventos;
-(NSString*) insertaEvento:(Evento*) pObjEvento ;
-(NSString*) validaEvento:(Evento*) pObjEvento;
-(NSInteger) eventoDefinido;
-(Evento*) getInfoEvento;
@end
