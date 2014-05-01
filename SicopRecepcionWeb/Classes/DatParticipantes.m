//
//  DatParticipantes.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 26/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DatParticipantes.h"


@implementation DatParticipantes
@synthesize   mensajeError;   
   
-(NSString*) insertaParticipante: (Participantes*) objParticipante{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   mensajeError=@"";
   
   NSLog(@"idProspecto %@", objParticipante.idMensaje );
   NSLog(@"IdEjecutivo %@", objParticipante.IdEjecutivo );
   NSLog(@"Ejecutivo %@", objParticipante.Ejecutivo );

   objParticipante.idMensaje=([objParticipante.idMensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objParticipante.IdEjecutivo=([objParticipante.IdEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objParticipante.Ejecutivo=([objParticipante.Ejecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   
   
   NSString *sqlCmd=[NSString stringWithFormat:@"Insert into ParticipantesConversacion (IdMensaje, IdEjecutivo, Ejecutivo) \
                     Values('%@','%@','%@')",
                     objParticipante.idMensaje, objParticipante.IdEjecutivo, objParticipante.Ejecutivo
                     ];
  
   
   const char  *sn= [sqlCmd UTF8String];  
   NSLog(@"Inserta %@",  [NSString stringWithUTF8String:sn] );

   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte


   //Si la sentencia no esta correcta entonces grabo en el log de sucesos
   if(sqlResult == SQLITE_OK){	
      if(SQLITE_DONE != sqlite3_step(statement)){
         mensajeError=@"Error al momento de insertar el registro'%s'", sqlite3_errmsg(dbCnxAct);
      }
      
   }else{
      mensajeError=@"Error al momento de insertar el registro'%s'", sqlite3_errmsg(dbCnxAct);      
   }
   
   sqlite3_finalize(statement);
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   
   return mensajeError;   
}

#pragma mark -
#pragma mark verifiacion de participantes por conversacion
-(BOOL) existenParticipantes:(NSString*) idMensaje{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   NSInteger totalRegistros;
   totalRegistros=0;
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta   

   NSString *sqlCmd=[NSString stringWithFormat:@"SElect Total from TotalPartipantesPorConversacion \
                     where idMensaje='%@'",
                     idMensaje
                     ];
   
   const char  *sn= [sqlCmd UTF8String];  
   NSLog(@"Inserta %@",  [NSString stringWithUTF8String:sn] );
   
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces grabo en el log de sucesos
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
         totalRegistros=(int )sqlite3_column_int(statement,0);
         
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   
   sqlite3_finalize(statement);
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
  
   if (totalRegistros==0){
      return FALSE;
   }else{ 
      return TRUE;
   }

}


-(void)dealloc{
   mensajeError=nil;
}

@end
