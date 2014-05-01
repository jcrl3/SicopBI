//
//  Usuario.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Usuario : NSObject{
  NSString  *IdProspecto;
  NSString  *IdEjecutivo;
  NSString  *IdDistribuidor;
  NSString  *IdDispositivo;
  NSString  *IdMarca;
  NSString  *Distribuidor;
  NSString  *Ejecutivo;
  NSString  *Prospecto;
  NSString  *PaginaWEB;
   NSString  *direccion; 
   NSString *Puesto;  
   NSString * TelefonoDistribuidor;
   NSString * Telefono;
   NSString * Celular;
   NSString * Radio;
   NSString * ClaveRadio;
   NSString *  latitude;
   NSString *  longitude; 
   
}
@property (nonatomic,retain) NSString  *IdProspecto;
@property (nonatomic,retain) NSString  *IdEjecutivo;
@property (nonatomic,retain) NSString  *IdDistribuidor;
@property (nonatomic,retain) NSString  *IdDispositivo;
@property (nonatomic,retain) NSString  *IdMarca;
@property (nonatomic,retain) NSString  *Distribuidor;
@property (nonatomic,retain) NSString  *Ejecutivo;
@property (nonatomic,retain) NSString  *Prospecto;
@property (nonatomic,retain) NSString  *PaginaWEB;
@property (nonatomic,retain) NSString  *Puesto;  
@property (nonatomic,retain) NSString  *direccion;;
@property (nonatomic,retain) NSString  *TelefonoDistribuidor;
@property (nonatomic,retain) NSString  *Telefono;
@property (nonatomic,retain) NSString  *Celular;
@property (nonatomic,retain) NSString  *Radio;
@property (nonatomic,retain) NSString  *ClaveRadio;
@property (nonatomic,retain) NSString  *latitude;
@property (nonatomic,retain) NSString  *longitude;
@end
