//
//  DatMensaje.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBConexion.h"
#import "Mensaje.h"

@interface DatMensaje : DBConexion{
  NSString *mensajeError;
}
//Propiedades
@property(nonatomic,retain)   NSString *mensajeError;

//Metosdos y procedimentos
-(NSMutableArray*)   getResumenMensaje:(NSString*) pIdDistribuidor TipoMensajes:(NSString*) pTipoMsj;
-(NSString*)         insertaMensaje:(Mensaje*) objMensaje fueraDelinea:(BOOL) pFueraDeLinea;
-(NSMutableArray*)   getMensajes:(NSString*) idMensaje;
-(NSString*)         getUltimaFechaConsultaConversacion:(NSString*) idMensaje;
-(NSMutableArray*)   getMensajesNoEnviados;
-(NSString*)         getIdProspecto: (NSString*) idDistribuidor;
-(NSInteger)         totalMsjsBd: (NSString*) tipoMensaje;
//-(NSInteger)         getTotalMsjSinLeer: (NSString*) tipoMsj; 
-(NSInteger) getTotalMsjSinLeer: (NSString*) tipoMsj idDistribuidor:(NSString*)pIdDistribudor;
-(void) marcaConversacionLeida: (NSString*) idMensaje;
-(void) borraEncabezados;
-(void) borraMensajes;
-(void) borraMensaje: (NSString*) idRegistro;

 
@end
