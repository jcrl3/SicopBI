//
//  Mensaje.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mensaje : NSObject{
   NSString   *idMensaje;
   NSString   *mensaje;
   NSString   *idEnviado;
   NSString   *fecha;
   NSString   *tipo;
   NSString   *remitente;   
   NSString   *enviado;
   NSString   *idRegistro;   
   NSString   *leido;
   NSString   *idDistribuidor;
}

@property (nonatomic,retain) NSString *idMensaje;
@property (nonatomic,retain) NSString *mensaje;
@property (nonatomic,retain) NSString *idEnviado;
@property (nonatomic,retain) NSString *fecha;
@property (nonatomic,retain) NSString *tipo;
@property (nonatomic,retain) NSString  *remitente;   
@property (nonatomic,retain) NSString  *enviado;
@property (nonatomic,retain) NSString  *idRegistro;
@property (nonatomic,retain) NSString  *leido;
@property (nonatomic,retain) NSString   *idDistribuidor;

@end
