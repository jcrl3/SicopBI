//
//  NSString+FuncionesExtendidas.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 14/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "NSString+FuncionesExtendidas.h"

@implementation NSString (FuncionesExtendidas)


-(BOOL)ExistePalabraEnCadena:(NSString*) pCadenaBuscar {
  
   NSRange match;
   
   match = [self rangeOfString: pCadenaBuscar];
   
   if (match.location == NSNotFound){
      return FALSE;
   }else{
      return TRUE;
   }

}
@end
