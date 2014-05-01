//
//  EjecutivoComplemento.h
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Ejecutivo.h"

@interface EjecutivoComplemento : Ejecutivo{
   NSString* nombre;
   NSString* idDistribuidor; 

}

@property (retain,nonatomic) NSString* nombre;
@property (retain,nonatomic) NSString *idDistribuidor;

@end
