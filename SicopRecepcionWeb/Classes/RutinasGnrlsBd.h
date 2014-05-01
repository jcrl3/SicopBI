//
//  RutinasGnrlsBd.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 27/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBConexion.h"

@interface RutinasGnrlsBd : DBConexion{

}
-(NSMutableArray*) getListaDatosSnlgEditor:(char*) Sentencia;
@end
