//
//  DatEjecutivos.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DatEjecutivos.h"

@implementation DatEjecutivos

@synthesize mensajeError;

#pragma mark -
#pragma mark - Rutina de borrado de la tabla de ejecutivos

-(void) borraTablaEjecutivos{
   NSString *sqlCmd = @"DELETE FROM EJECUTIVOS";
   const char *sn = [sqlCmd UTF8String];
    NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: sqlCmd];

}
#pragma mark -
#pragma mark - Rutina de insercción de ejecutivos solo ID

-(NSString*) insertaEjecutivo: (Ejecutivo*) pObjEjecutivo{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   self.mensajeError=@"";
   
   //limpio los strings del caracter Enter
   pObjEjecutivo.idEjecutivo=[pObjEjecutivo.idEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""];

   //valido que las variables esten llenas 
   self.mensajeError=[self validarEjecutivo:pObjEjecutivo];
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Insert into \
                       Ejecutivos \
                       (idEjecutivo) \
                       Values('%@')",
                       pObjEjecutivo.idEjecutivo];
   
   
   
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

#pragma mark -
#pragma mark - Rutina de insercción de distribuidores como ejecutivos
-(NSString*) insertaDistribuidorComoEjecutivo: (Distribuidor*) pObjDistribudor{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   self.mensajeError=@"";
   
   //limpio los strings del caracter Enter
   pObjDistribudor.idDistribuidor=[pObjDistribudor.idDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   
   //valido que las variables esten llenas 
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Insert into \
                       Ejecutivos \
                       (idEjecutivo, N_Nombre, A_Paterno, A_Materno, IdDistribuidor) \
                       Values('%@','%@','.','.','%@')",
                       pObjDistribudor.idDistribuidor,
                       pObjDistribudor.nombreDistribuidor,
                       pObjDistribudor.idDistribuidor
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


#pragma mark -
#pragma mark - Rutina de actualización del nombre del ejecutivo

-(void) actualizaEjecutivo:(NSString*) pIdEjecutivo objEjecutivo: (EjecutivoComplemento*) pObjEjecutivo{
 NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);

   //limpio los strings del caracter Enter
   pIdEjecutivo=[pIdEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEjecutivo.nombre=[pObjEjecutivo.nombre stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEjecutivo.idDistribuidor=[pObjEjecutivo.idDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   
   //valido que las variables esten llenas 
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update Ejecutivos \
                       Set \
                       N_Nombre='%@', idDistribuidor='%@' \
                       where IdEjecutivo='%@'",
                       pObjEjecutivo.nombre,
                       pObjEjecutivo.idDistribuidor,
                       pIdEjecutivo
                       ];
   
   
   [self ejecutarSentencia: sqlCmd];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

#pragma mark -
#pragma mark - Rutina de validación de datos del ejecutivo

-(NSString*) validarEjecutivo:(Ejecutivo*) pObjEjecutivo{
   
   return @"";
}

- (void)dealloc {
  	[super dealloc];
}


@end
