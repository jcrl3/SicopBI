//
//  NSArray-NestedArrays.h
//  Sicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 29/03/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray(NestedArrays)
/** 
  Este metodo regresarà un objeto contenido con un arreglo contenido en otro arreglos, con la intenciòn
 de permitir en u solo paso la recuperaciòn de los objetos en el arreglo anidado utilizando el index
 */
	
-(id)nestedObjectAtIndexPath:(NSIndexPath *)indexPath; 
	
/**
 este metodo regresara e conteo de item de un subarray
 */
	
-(NSInteger)CountOfNestedArray:(NSUInteger)section;	



@end
