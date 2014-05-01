//
//  DatMensaje.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DatMensaje.h"

@implementation DatMensaje
@synthesize mensajeError;

-(NSString*) getIdProspecto: (NSString*) idDistribuidor{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);   
   NSString *valorId;
   char *idPros; 

   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Select idProspecto From Usuario where IdDistribuidor= '%@'",
                       idDistribuidor];
   
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);

   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK){
      while(sqlite3_step(statement)== SQLITE_ROW){
         idPros=(char *)sqlite3_column_text(statement,0);  
         valorId= (idPros) ? [NSString stringWithUTF8String:idPros] : @"";
      }
        sqlite3_finalize(statement);
   }   
   NSLog(@"ValorID %@", valorId);
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   

   return  valorId;

}


-(NSMutableArray*) getResumenMensaje:(NSString*) pIdDistribuidor TipoMensajes:(NSString*) pTipoMsj {
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   NSString *idProspecto;
   idProspecto =[self getIdProspecto:pIdDistribuidor];
   
   
   NSString *sqlCmd = [NSString stringWithFormat:
    @"Select \
    A.idMensaje, \
    A.IdEnviado, \
    A.Fecha, \
    A.Mensaje, \
    (Select NombreEjecutivo from Usuario where idEjecutivo=(Select idEnviado from Conversaciones where \
    idEnviado <> '%@' and idMensaje=A.IdMensaje Limit 1) ) as NombreEjecutivo, \
    Enviado, Tipo, Leido \
    From \
    Conversaciones A \
    Where \
    (  A.IdEnviado = (Select IdEjecutivo From Usuario where IdDistribuidor='%@')  or \
    A.IdEnviado = (Select IdProspecto From Usuario where IdDistribuidor='%@') \
    )   and \
    A.IdRegistro = (Select Max(IdRegistro) From Conversaciones where IdMensaje=A.IdMensaje and IdEnviado <>'' and A.idEnviado=IdEnviado) and A.Tipo='%@'\
    Group By     IdMensaje \
    Order By \
    A.IdRegistro",
         idProspecto, pIdDistribuidor , pIdDistribuidor, pTipoMsj  ];

   NSLog(@"Sentencia  %@", sqlCmd);  
   
   const char  *sn= [sqlCmd UTF8String];   
   NSMutableArray *encabezados = [[[NSMutableArray alloc] init] autorelease];	 
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
       
         NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
         
         Mensaje *encabezado=[[Mensaje alloc ] init];
         
         char *idMensaje=(char *)sqlite3_column_text(statement,0);
         char* idEnviado=(char *)sqlite3_column_text(statement,1);
         char* fecha=(char *)sqlite3_column_text(statement,2);
         char* mensaje=(char *)sqlite3_column_text(statement,3);
         char* NombreEjecutivo=(char *)sqlite3_column_text(statement,4);
         char* enviado=(char *)sqlite3_column_text(statement,5);
         char* tipo=(char *)sqlite3_column_text(statement,6);
         char* leido=(char *)sqlite3_column_text(statement,7);
         
         encabezado.idMensaje=(idEnviado) ? [NSString stringWithUTF8String:idMensaje] : @"";
         encabezado.idEnviado=(idEnviado) ? [NSString stringWithUTF8String:idEnviado] : @"";
         encabezado.fecha=(fecha) ? [NSString stringWithUTF8String:fecha] : @"";
         encabezado.mensaje=(mensaje) ? [NSString stringWithUTF8String:mensaje] : @"";
         encabezado.enviado=(enviado) ? [NSString stringWithUTF8String:enviado] : @"";
         encabezado.remitente=(NombreEjecutivo) ? [NSString stringWithUTF8String:NombreEjecutivo] : @"";         
         encabezado.tipo=(tipo) ? [NSString stringWithUTF8String:tipo] : @"";         
         encabezado.leido=(leido) ? [NSString stringWithUTF8String:leido] : @"";      
         
         //Elimimo el caracter de Enter en los datos
         encabezado.idMensaje=([encabezado.idMensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.idEnviado=([encabezado.idEnviado stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.fecha=([encabezado.fecha stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
       //  encabezado.mensaje=([encabezado.mensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.remitente=([encabezado.remitente stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.enviado= ([encabezado.enviado stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.tipo= ([encabezado.tipo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         encabezado.leido=([encabezado.leido stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         
         [encabezados  addObject:encabezado];
         [encabezado release];
         [pool drain];
       }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}

   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);

   return  encabezados;
}


//este procedimiento graba un mensaje en la base de datos
-(NSString*) insertaMensaje:(Mensaje*) objMensaje fueraDelinea:(BOOL) pFueraDeLinea  {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
//   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   
   NSString *tipoDeEnvio;
   
   if([objMensaje.leido isEqualToString:@""]){
      objMensaje.leido=@"1";
   }
   if(pFueraDeLinea==TRUE){
      tipoDeEnvio = @"0";
   }else{
      tipoDeEnvio=@"1";
   }   

   objMensaje.idMensaje= ([objMensaje.idMensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objMensaje.idEnviado=([objMensaje.idEnviado stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objMensaje.fecha= ([objMensaje.fecha stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objMensaje.tipo = ([objMensaje.tipo stringByReplacingOccurrencesOfString:@"\n" withString:@""]); 
   objMensaje.idDistribuidor = ([objMensaje.idDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]); 

   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Insert into Conversaciones \
                       (idMensaje, Mensaje, Fecha, idEnviado, Enviado, Tipo, Leido, idDistribuidor) \
                       Values ('%@','%@','%@','%@','%@','%@',%@ ,'%@')", 
                       objMensaje.idMensaje,
                       objMensaje.mensaje,
                       objMensaje.fecha,
                       objMensaje.idEnviado,
                       tipoDeEnvio,
                       objMensaje.tipo,
                       objMensaje.leido, objMensaje.idDistribuidor
                       ];
   //char const *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia \n %@", sqlCmd);
  
   if (objMensaje.idMensaje==nil){
      mensajeError=@"Id de mensaje vacio";
      return mensajeError;
   }
   
   
   [self ejecutarSentencia: sqlCmd];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   return mensajeError;


}

//este procedimiento borra los encabezados de la tabla encabezados
-(void) borraEncabezados{

   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   char *sn = "Delete From Encabezados";
   
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces borro los encabezados recientes para actualizarlos con los ultimos
   if(sqlResult == SQLITE_OK){	
        if(SQLITE_DONE != sqlite3_step(statement)){
            mensajeError=@"Error al momento de borra  los registros'%s'", sqlite3_errmsg(dbCnxAct);
         }
      
     }else{
      mensajeError=@"La sentencia de borrado es incorrecta'%s'", sqlite3_errmsg(dbCnxAct);      
   }
   
   sqlite3_finalize(statement);
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

///este procedimiento borra los registros de la tabla mensajes
-(void) borraMensajes{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   char *sn = "Delete From Conversaciones";
   
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces borro los encabezados recientes para actualizarlos con los ultimos
   if(sqlResult == SQLITE_OK){	
      if(SQLITE_DONE != sqlite3_step(statement)){
         mensajeError=@"Error al momento de borra  los registros'%s'", sqlite3_errmsg(dbCnxAct);
      }
      
   }else{
      mensajeError=@"La sentencia de borrado es incorrecta'%s'", sqlite3_errmsg(dbCnxAct);      
   }
   
   sqlite3_finalize(statement);
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}





- (void)dealloc {
   mensajeError=nil;
   [super dealloc];
}


-(NSMutableArray*) getMensajes: (NSString*) idMensaje{

   NSMutableArray *mensajes = [[[NSMutableArray alloc] init] autorelease];	 
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta

   NSString *sqlCmd = [NSString stringWithFormat:
         @"Select \
          idMensaje, \
          IdEnviado, \
          Fecha, \
          Mensaje, \
          NombreProspecto, \
          NombreEjecutivo, \
          Enviado \
        from \
           MensajesDeConversacion \
      where \
          IdMensaje = '%@'  Order By IdRegistro ASC", idMensaje];
   
      NSLog(@"Sentencia  %@", sqlCmd);  
                        
      const char  *sn= [sqlCmd UTF8String];   

	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
     // sqlite3_bind_text(statement, 1,[idMensaje UTF8String], -1, SQLITE_TRANSIENT);
      
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
                                    
         Mensaje *msj=[[Mensaje alloc ] init];
         
     //    char *idMensaje=(char *)sqlite3_column_text(statement,0);
     //    char* idEnviado=(char *)sqlite3_column_text(statement,1);
     //    char* fecha=(char *)sqlite3_column_text(statement,2);
     //    char* mensaje=(char *)sqlite3_column_text(statement,3);
        char* NombreProspecto = (char *)sqlite3_column_text(statement,4);
         char* NombreEjecutivo=(char *)sqlite3_column_text(statement,5);
      
      
         
     //    char* enviado=(char *)sqlite3_column_text(statement,6);
/*         
         msj.idMensaje=(idMensaje) ? [NSString stringWithUTF8String:idMensaje] : @"";
         msj.idEnviado=(idEnviado) ? [NSString stringWithUTF8String:idEnviado] : @"";
         msj.fecha=(fecha) ? [NSString stringWithUTF8String:fecha] : @"";
         msj.mensaje=(mensaje) ? [NSString stringWithUTF8String:mensaje] : @"";
         msj.enviado=(enviado) ? [NSString stringWithUTF8String:enviado] : @"";
*/
         
         
         msj.idMensaje=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
         msj.idEnviado= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
         msj.fecha= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
         msj.mensaje= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
         msj.enviado=  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
         
        
         
         if (NombreEjecutivo==nil){
           // msj.remitente=(NombreProspecto) ? [NSString stringWithUTF8String:NombreProspecto] : @"";
            msj.remitente=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
         }      
         if (NombreProspecto==nil){
          //  msj.remitente=(NombreEjecutivo) ? [NSString stringWithUTF8String:NombreEjecutivo] : @"";
            msj.remitente=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
         }
         
         //Elimimo el caracter de Enter en los datos
        /*
         msj.idMensaje=([msj.idMensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         msj.idEnviado=([msj.idEnviado stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         msj.fecha=([msj.fecha stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
        // msj.mensaje=([msj.mensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         msj.remitente=([msj.remitente stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         msj.enviado=([msj.enviado stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
         */
         
         [mensajes  addObject:msj];
         [msj release]; 
       
         [pool drain];                          
      }
      
//      sqlite3_finalize(statement);
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   
   return  mensajes;

}


-(NSMutableArray*) getMensajesNoEnviados{
   
   char *sn="SELECT  Fecha,IdEnviado,Mensaje,IdMensaje, IdRegistro, Tipo FROM MENSAJES_NO_ENVIADOS";
   
   NSMutableArray *mensajes = [[[NSMutableArray alloc] init] autorelease];	 
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
      NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
         Mensaje *msj=[[Mensaje alloc ] init];
         
         char* fecha=(char *)sqlite3_column_text(statement,0);
         char* idEnviado=(char *)sqlite3_column_text(statement,1);
         char* mensaje=(char *)sqlite3_column_text(statement,2);
         char *idMensaje=(char *)sqlite3_column_text(statement,3);
         char *idRegistro=(char *)sqlite3_column_text(statement,4);
         char *tipo=(char *)sqlite3_column_text(statement,5);
         
         msj.idMensaje=(idEnviado) ? [NSString stringWithUTF8String:idMensaje] : @"";
         msj.idEnviado=(idEnviado) ? [NSString stringWithUTF8String:idEnviado] : @"";
         msj.fecha=(fecha) ? [NSString stringWithUTF8String:fecha] : @"";
         msj.mensaje=(mensaje) ? [NSString stringWithUTF8String:mensaje] : @"";
         msj.idRegistro=(idRegistro) ? [NSString stringWithUTF8String:idRegistro] : @"";
         msj.tipo=(tipo) ? [NSString stringWithUTF8String:tipo] : @"";
         
         [mensajes  addObject:msj];
         [msj release]; 
         [pool drain]; 
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   
   return  mensajes;
   
}

-(void) borraMensaje: (NSString*) idRegistro{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta

   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Delete From Conversaciones where IdRegistro= %@",
                       idRegistro];
   
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);

   
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces borro los encabezados recientes para actualizarlos con los ultimos
   if(sqlResult == SQLITE_OK){	
      
      
      if(SQLITE_DONE != sqlite3_step(statement)){
         mensajeError=@"Error al momento de borra  los registros'%s'", sqlite3_errmsg(dbCnxAct);
      }
      
   }else{
      mensajeError=@"La sentencia de borrado es incorrecta'%s'", sqlite3_errmsg(dbCnxAct);      
   }
   
   sqlite3_finalize(statement);
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  

   
}

-(NSString*) getUltimaFechaConsultaConversacion:(NSString*) idMensaje{
   NSString* fecha;    

   
   char *sn="Select \
     Fecha \
      From Conversaciones \
    Where \
     IdRegistro = (Select Max(IdRegistro) From Conversaciones where IdMensaje=?)";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      sqlite3_bind_text(statement, 1,[idMensaje UTF8String], -1, SQLITE_TRANSIENT);
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
       char* fechaChar=(char *)sqlite3_column_text(statement,0);
       fecha=(fechaChar) ? [NSString stringWithUTF8String:fechaChar] : @"";
      }
     
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   NSLog(@"Fecha %@", fecha);
   return fecha;
}

-(NSInteger) totalMsjsBd: (NSString*) tipoMensaje{  
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  

   NSInteger totalRegistros;

   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Select  Total from totalMensajes where Tipo= '%@'",
                       tipoMensaje];
   
   const char *sn = [sqlCmd UTF8String];
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta

	totalRegistros=0;
	
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
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
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   return totalRegistros; 
}

-(NSInteger) getTotalMsjSinLeer: (NSString*) tipoMsj idDistribuidor:(NSString*)pIdDistribudor   {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);     
   NSInteger totalRegistros;
	totalRegistros=0;

   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Select Total from TotalMensajesSinLeerPortipo where Tipo= '%@' and idDistribuidor='%@'",
                       tipoMsj, pIdDistribudor];
   
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta

   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK){
      while(sqlite3_step(statement)== SQLITE_ROW){
         totalRegistros=(int )sqlite3_column_int(statement,0);
      }
      
    sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   return totalRegistros; 
}


-(void) marcaConversacionLeida: (NSString*) idMensaje{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update Conversaciones Set Leido=1 where idMensaje= '%@'",
                       idMensaje];
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);

   [self ejecutarSentencia: sqlCmd];
NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

@end
