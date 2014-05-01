//
//  DatParticipantes.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 26/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBConexion.h"
#import "Participantes.h"

@interface DatParticipantes : DBConexion{
   NSString* mensajeError;
}
@property (nonatomic,retain) NSString* mensajeError;
-(NSString*) insertaParticipante: (Participantes*) objParticipante;
-(BOOL) existenParticipantes:(NSString*) idMensaje;
@end
