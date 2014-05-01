//
//  DatCodigoPostal.h
//  SicopEventos
//
//  Created by JUAN RAMIREZ on 27/02/14.
//  Copyright (c) 2014 Sicop Consulting, SA de CV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBAccess.h"

@interface DatCodigoPostal : DBAccess{

}
-(NSString*) existeCodigoPostal:(NSString*) pCodigo;

@end
