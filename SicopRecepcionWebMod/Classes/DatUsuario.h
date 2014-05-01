//
//  DatUsuario.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBConexion.h"
#import "Usuario.h"

@interface DatUsuario : DBConexion{
   NSString *mensajeError;
}
@property(nonatomic,retain)   NSString *mensajeError;

-(void)       getDatosUsuario:(Usuario*) objUsuario;
-(NSString*)  insertaUsuario:(Usuario*)  objUsuario; 
-(NSString*)  actualizaUsuario:(Usuario*)objUsuario; 
-(NSString*)  validaDatosUser:(Usuario*) objUsuario;
-(Usuario*)   getPerfilUsuario:(NSString*) pIdUsuario;
-(NSMutableArray*) getListaDistribuidores;

@end
