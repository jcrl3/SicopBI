//
//  datProspecto.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 14/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DBAccess.h"
#import "Prospecto.h"
#import "DatCodigoPostal.h"
@interface datProspecto : DBAccess{
     NSString *mensajeError;
}
@property(nonatomic,retain) NSString *mensajeError;
-(NSString *) getNumeroRegistrosCapturados;
-(NSString*) getIdUltimoRegistroCapturado;
-(NSString*) insertaProspecto:(Prospecto*) objProspecto; 
-(NSString*) actualizaProspecto:(Prospecto*) objProspecto; 
-(NSString*) validaDatosProspecto:(Prospecto*) objProspecto;
-(NSDictionary*) obtenerDatosDiccionario:(Prospecto*) objProspecto;
-(NSMutableArray*) getListaProspectosPorEnviar;
-(NSMutableArray*) getListaProspectos;
-(NSInteger) getNumeroRegistrosPendientesPorEnviar;
-(void) grabarDatosEnXml:(NSMutableArray*) surveyDataArray;
-(void) marcaProspectoComoEnviado: (NSString*) pIdRegistro;
-(void) estableceIdSicop: (NSString*) pIdRegistro idSicop:(NSString*) pIdSicop;
-(void) borraTablaProspectos;

@end
