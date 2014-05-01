//
//  Participantes.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 26/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Mensaje.h"

@interface Participantes : Mensaje{
   
   NSString* IdEjecutivo;
   NSString* Ejecutivo;
   
}
@property (nonatomic,retain)  NSString* IdEjecutivo;
@property (nonatomic,retain)  NSString* Ejecutivo;


@end
