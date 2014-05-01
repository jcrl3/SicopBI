//
//  DatDistribuidor.m
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DatDistribuidor.h"

@implementation DatDistribuidor
@synthesize mensajeError;
-(id) init
{
   if (self == [super init])
   {
      self.mensajeError=@"";
   }
	return self;
}

#pragma mark -
#pragma mark Procedimeintos de inserciòn de datos
-(NSString*) insertaDistribuidor:(Distribuidor*) pObjDistribuidor{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   self.mensajeError=@"";
   
   //limpio los strings del caracter Enter
   pObjDistribuidor.idDistribuidor=[pObjDistribuidor.idDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjDistribuidor.nombreDistribuidor=[pObjDistribuidor.nombreDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   
   //valido que las variables esten llenas 
   self.mensajeError=[self validarDistribuidor:pObjDistribuidor];
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Insert into \
                       Distribuidores \
                       (idDistribuidor, \
                       nombreDistribuidor) \
                       Values('%@','%@')",
                       pObjDistribuidor.idDistribuidor,
                       pObjDistribuidor.nombreDistribuidor
                       ];
   
   
   
   const char *sn = [sqlCmd UTF8String];
   
   NSLog (@"Sentencia de inserción \n %@",sqlCmd);
   
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces grabo en el log de sucesos
   if(sqlResult == SQLITE_OK){	
      
      if(SQLITE_DONE != sqlite3_step(statement)){
         self.mensajeError=@"Error al momento de insertar el registro'%s'", sqlite3_errmsg(self.getCnxBdActual);
      }
      
   }else{
      self.mensajeError=@"Error al momento de insertar el registro'%s'", sqlite3_errmsg(self.getCnxBdActual);      
   }
   sqlite3_finalize(statement);
   return self.mensajeError;
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

-(NSString*) validarDistribuidor:(Distribuidor*) pObjDistribuidor{
   

   return @"";
}

-(void) borraTablaDistribuidores{
   NSString *sqlCmd = @"DELETE FROM Distribuidores";
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: sqlCmd];

}

- (void)dealloc {
  	[super dealloc];
}


@end
