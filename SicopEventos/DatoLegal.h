//
//  CodigoPostal.h
//  SicopEventos
//
//  Created by JUAN RAMIREZ on 27/02/14.
//  Copyright (c) 2014 Sicop Consulting, SA de CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatoLegal : NSObject{
@private
	NSString *textoLegal;
}
-(NSString*) getTextoLegal:(NSString*) pIdMarca;
@end
