//
//  DatEvento.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 18/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DatEvento.h"

@implementation DatEvento
@synthesize mensajeError;

-(void) borraTablaEventos{  
      NSString *sqlCmd = @"DELETE FROM DefinicionEvento";
      const char *sn = [sqlCmd UTF8String];
      NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
      [self ejecutarSentencia: sqlCmd];
}

-(NSString*) insertaEvento:(Evento*) pObjEvento{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   self.mensajeError=@"";
   
   //limpio los strings del caracter Enter
   pObjEvento.idEvento=[pObjEvento.idEvento stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.nombreEvento=[pObjEvento.nombreEvento stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.inicioEvento=[pObjEvento.inicioEvento stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.finEvento=[pObjEvento.finEvento stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.idFuente=[pObjEvento.idFuente stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.idSubcampana=[pObjEvento.idSubcampana stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.disclaimer=[pObjEvento.disclaimer stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   pObjEvento.idMarca=[pObjEvento.idMarca stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	
   //valido que las variables esten llenas 
   self.mensajeError=[self validaEvento:pObjEvento];
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Insert into \
                       DefinicionEvento \
                       (idEvento, \
                       nombreEvento, \
                       fechaInicio, \
                       fechaFin, \
                       idFuente, \
                       idSubcampana, disclaimer, passwordEvento, idMarca) \
                       Values('%@','%@','%@','%@','%@','%@', '%@', '%@','%@')",
                       pObjEvento.idEvento,
                       pObjEvento.nombreEvento,
                       pObjEvento.inicioEvento,
                       pObjEvento.finEvento,
                       pObjEvento.idFuente,
                       pObjEvento.idSubcampana,
                       pObjEvento.disclaimer,
                       pObjEvento.passwordEvento,
					   pObjEvento.idMarca
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

-(NSString*) validaEvento:(Evento*) pObjEvento{
   
   pObjEvento.passwordEvento=@"password";
   return @"";
}

-(Evento*) getInfoEvento{

 
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Select \
                       idEvento, \
                       nombreEvento, \
                       FechaInicio, \
                       FechaFin, \
                       idFuente, \
                       idSubcampana, \
                       disclaimer, idMarca \
                       from \
                       DefinicionEvento"];

   NSLog (@"Sentencia de selección \n %@",sqlCmd);
   const char *sn = [sqlCmd UTF8String];
   
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   Evento*  infoEvento=[[[Evento alloc] init] autorelease];
   
   infoEvento.idEvento  =nil;

	int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK) {
      while(sqlite3_step(statement)== SQLITE_ROW){
         char* idevento=(char *)sqlite3_column_text(statement,0);
         char* nombreevento=(char *)sqlite3_column_text(statement,1);
         char* inicioevento=(char *)sqlite3_column_text(statement,2);
         char *finevento=(char *)sqlite3_column_text(statement,3);
         char *idfuente=(char *)sqlite3_column_text(statement,4);
         char *idsubcampana=(char *)sqlite3_column_text(statement,5);
         char *disclaimerlegal=(char *)sqlite3_column_text(statement,6);
		 char *idmarca=(char *)sqlite3_column_text(statement,7);
         
         infoEvento.idEvento  =(idevento) ? [NSString stringWithUTF8String:idevento] : @"";
         infoEvento.nombreEvento=(nombreevento) ? [NSString stringWithUTF8String:nombreevento] : @"";
         infoEvento.inicioEvento=(inicioevento) ? [NSString stringWithUTF8String:inicioevento] : @"";
         infoEvento.finEvento=(finevento) ? [NSString stringWithUTF8String:finevento] : @"";
         infoEvento.idFuente=(idfuente) ? [NSString stringWithUTF8String:idfuente] : @"";
         infoEvento.idSubcampana=(idsubcampana) ? [NSString stringWithUTF8String:idsubcampana] : @"";
         infoEvento.disclaimer=(disclaimerlegal) ? [NSString stringWithUTF8String:disclaimerlegal] : @"";
		 infoEvento.idMarca=(idmarca) ? [NSString stringWithUTF8String:idmarca] : @"";
       }
      sqlite3_finalize(statement);
    	
     }else{
      
	   	NSLog(@"Problemas con la base de datos");
		  NSLog(@"%s", sqlite3_errmsg(self.getCnxBdActual));
	}
   
   return  infoEvento;

}

#pragma mark -
#pragma mark rutina de validaciòn de configuracion del evento
-(NSInteger) eventoDefinido{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   NSInteger totalRegistros;
   const char *sn="Select count(*) as Total from DefinicionEvento";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   
	totalRegistros=0;
	
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK) {  //esta sentencia recupera los datos 
      while(sqlite3_step(statement)== SQLITE_ROW){
         totalRegistros=(int )sqlite3_column_int(statement,0);
      }
      sqlite3_finalize(statement);
     }else{
		  NSLog(@"Problemas con la base de datos");
		  NSLog(@"%s", sqlite3_errmsg(self.getCnxBdActual));
	 }
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   return totalRegistros; 
}

- (void)dealloc {
  	[super dealloc];
}

@end
