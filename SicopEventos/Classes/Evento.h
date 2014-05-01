//
//  Evento.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evento : NSObject{
   
   NSString* idEvento;
   NSString* nombreEvento;
   NSString* inicioEvento;
   NSString* finEvento;
   NSString* idFuente;
   NSString* passwordEvento;
   NSString* idSubcampana;
   NSString* disclaimer;
   NSString* soloDistribuidor;
   NSString* idMarca;
   BOOL activo;
}
@property (nonatomic,retain) NSString* idEvento;
@property (nonatomic,retain) NSString* nombreEvento;
@property (nonatomic,retain) NSString* inicioEvento;
@property (nonatomic,retain) NSString* finEvento;
@property (nonatomic,retain) NSString* idFuente;
@property (nonatomic,retain) NSString* passwordEvento;
@property (nonatomic,retain) NSString* idSubcampana;
@property (nonatomic,retain) NSString* disclaimer;
@property (nonatomic,retain) NSString* soloDistribuidor;
@property (nonatomic,retain) NSString* idMarca;
@property (nonatomic) BOOL activo;

@end
