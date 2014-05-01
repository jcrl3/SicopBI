//
//  DatUsuario.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DatUsuario.h"

@implementation DatUsuario

@synthesize mensajeError;


-(id) init
{
   if (self == [super init])
   {
      
   }
	return self;
}

#pragma mark -
#pragma mark procedimiento de obtecion de datos del usuario actual 
-(void) getDatosUsuario:(Usuario*) objUsuario {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   const char *sn= "SELECT   \
   idProspecto, \
   idDispositivo, \
   idMarca, \
   NombreDistribuidor, \
   NombreProspecto, \
   NombreEjecutivo, paginaWeb, IdDistribuidor, latitude, Longitude \
   FROM \
   Usuario LIMIT 1";
   
   //aseguro el valor del objeto user
   objUsuario.IdProspecto= @"";
   objUsuario.IdDispositivo= @"";
   objUsuario.IdMarca= @"";
   objUsuario.Distribuidor= @"";
   objUsuario.Prospecto= @"";
   objUsuario.Ejecutivo= @"";
   objUsuario.IdDistribuidor= @"";
   objUsuario.PaginaWEB=@"";
   objUsuario.IdDistribuidor=@"";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
	  {
		  while(sqlite3_step(statement)== SQLITE_ROW)
		  {
         
           char *idProspecto=(char *)sqlite3_column_text(statement,0);
           char* idDispositivo=(char *)sqlite3_column_text(statement,1);
           char* idMarca=(char *)sqlite3_column_text(statement,2);
           char* NombreDistribuidor=(char *)sqlite3_column_text(statement,3);
           char* NombreProspecto = (char *)sqlite3_column_text(statement,4);
           char* NombreEjecutivo=(char *)sqlite3_column_text(statement,5);
           char* paginaWeb=(char *)sqlite3_column_text(statement,6);
           char* idDistribuidor=(char *)sqlite3_column_text(statement,7);
           double latitude=(double) sqlite3_column_double(statement,8);
           double longitude=(double) sqlite3_column_double(statement,9);
           
           objUsuario.IdProspecto=(idProspecto) ? [NSString stringWithUTF8String:idProspecto] : @"";
           objUsuario.IdDispositivo=(idDispositivo) ? [NSString stringWithUTF8String:idDispositivo] : @"";
           objUsuario.IdMarca=(idMarca) ? [NSString stringWithUTF8String:idMarca] : @"";
           objUsuario.Distribuidor=(NombreDistribuidor) ? [NSString stringWithUTF8String:NombreDistribuidor] : @"";
           objUsuario.Prospecto=(NombreProspecto) ? [NSString stringWithUTF8String:NombreProspecto] : @"";
           objUsuario.Ejecutivo=(NombreEjecutivo) ? [NSString stringWithUTF8String:NombreEjecutivo] : @"";
           objUsuario.PaginaWEB=(paginaWeb) ? [NSString stringWithUTF8String:paginaWeb] : @"";
           objUsuario.IdDistribuidor=(idDistribuidor) ? [NSString stringWithUTF8String:idDistribuidor] : @"";
           
           NSString *miLatitude = [NSString stringWithFormat:@"%f",latitude];
           NSString *miLongitude = [NSString stringWithFormat:@"%f",longitude];

           objUsuario.longitude=miLatitude;
           objUsuario.latitude=miLongitude;
           
           objUsuario.IdProspecto= ([objUsuario.IdProspecto stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.IdDispositivo=([objUsuario.IdDispositivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.IdMarca= ([objUsuario.IdMarca stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.Distribuidor=([objUsuario.Distribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.Prospecto=([objUsuario.Prospecto stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.Ejecutivo=([objUsuario.Ejecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.PaginaWEB=([objUsuario.PaginaWEB stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           objUsuario.IdDistribuidor=([objUsuario.IdDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
           
        }
		 
        sqlite3_finalize(statement);
    	
     }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}

   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

#pragma mark -
#pragma marl procedimiento de obtener el perfil de un vendedor
-(Usuario*) getPerfilUsuario:(NSString*) pIdUsuario {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
  
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Select \
                       NombreEjecutivo, \
                       Puesto, \
                       NombreDistribuidor, \
                       TelefonoDistribuidor, \
                       Direccion, \
                       PaginaWeb, Telefono \
                       from \
                       DatosUsuario \
                       Where \
                       NombreEjecutivo='%@'",
                       pIdUsuario];
   
   const char *sn= [sqlCmd UTF8String]; 
   Usuario* objUsuario=[[[Usuario alloc] init] autorelease];
   
   NSLog(@"Senetencia %@", sqlCmd);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW){
      
         char* NombreEjecutivo=(char *)sqlite3_column_text(statement,0);
         char* puesto=(char *)sqlite3_column_text(statement,1);
         char* NombreDistribuidor=(char *)sqlite3_column_text(statement,2);
         char* telefonoDistribuidor=(char *)sqlite3_column_text(statement,3);
         char *direccion=(char *)sqlite3_column_text(statement,4);
         char* paginaWeb=(char *)sqlite3_column_text(statement,5);
         char* telefono=(char *)sqlite3_column_text(statement,6);         
         
         objUsuario.Ejecutivo   =(NombreEjecutivo) ? [NSString stringWithUTF8String:NombreEjecutivo] : @"";
         objUsuario.Puesto=(puesto) ? [NSString stringWithUTF8String:puesto] : @"";
         objUsuario.Distribuidor=(NombreDistribuidor) ? [NSString stringWithUTF8String:NombreDistribuidor] : @"";
         objUsuario.TelefonoDistribuidor=(telefonoDistribuidor) ? [NSString stringWithUTF8String:telefonoDistribuidor] : @"";
         objUsuario.direccion=(direccion) ? [NSString stringWithUTF8String:direccion] : @"";
         objUsuario.PaginaWEB=(paginaWeb) ? [NSString stringWithUTF8String:paginaWeb] : @"";
         objUsuario.Telefono=(telefono) ? [NSString stringWithUTF8String:telefono] : @"";
      
                  
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}
   
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   
   return objUsuario;
}

#pragma mark -
#pragma mark -procedimiento de inserccion para un usuario nuevo
-(NSString*) insertaUsuario:(Usuario*) objUsuario{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   mensajeError=@"";
   
   //quitamos el caracter de ENTER en las cadenas
   objUsuario.IdProspecto= ([objUsuario.IdProspecto stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.IdDispositivo=([objUsuario.IdDispositivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.IdMarca= ([objUsuario.IdMarca stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.Distribuidor=([objUsuario.Distribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.Prospecto=([objUsuario.Prospecto stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.Ejecutivo=([objUsuario.Ejecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.IdEjecutivo=([objUsuario.IdEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.PaginaWEB=([objUsuario.PaginaWEB stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.IdDistribuidor=([objUsuario.IdDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.Telefono=([objUsuario.Telefono stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.TelefonoDistribuidor= ([objUsuario.TelefonoDistribuidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.latitude=   ([objUsuario.latitude stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   objUsuario.longitude=([objUsuario.longitude stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
   
   objUsuario.Puesto=@"EJECUTIVO DE VENTAS";
   
   NSString *sqlCmd = [NSString stringWithFormat:
                  @"Insert into \
                  Usuario \
                  (idProspecto, idDispositivo, idMarca,NombreDistribuidor,NombreProspecto, NombreEjecutivo, IdEjecutivo,PaginaWeb,IdDistribuidor, Telefono, TelefonoDistribuidor, Puesto, Latitude, Longitude, FechaInstalacion) \
                       Values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', %@, %@ ,strftime('%Y-%m-%d'))",
                       objUsuario.IdProspecto,
                       objUsuario.IdDispositivo,
                       objUsuario.IdMarca,
                       objUsuario.Distribuidor,
                       objUsuario.Prospecto,
                       objUsuario.Ejecutivo ,
                       objUsuario.IdEjecutivo,
                       objUsuario.PaginaWEB,
                       objUsuario.IdDistribuidor,
                       objUsuario.Telefono,
                       objUsuario.TelefonoDistribuidor,
                       objUsuario.Puesto, objUsuario.latitude, objUsuario.longitude
                       ];
   const char *sn = [sqlCmd UTF8String];
      
   NSLog (@"Sentencia de insercciòn \n %@",sqlCmd);
   //valido que las variables esten llenas 
   mensajeError=[self validaDatosUser:objUsuario];

   if (mensajeError!=@""){
      return mensajeError;
   }
   

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

-(NSString*) actualizaUsuario:(Usuario*) objUsuario{
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   mensajeError=@"";
   
   
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update \
                       Usuario Set \
                       idProspecto='%@', \
                       idDispositivo='%@', \
                       idMarca='%@', \
                       NombreDistribuidor='%@', \
                       NombreProspecto='%@', \
                       NombreEjecutivo='%@', \
                       IdEjecutivo='%@', \
                       PaginaWeb='%@', \
                       idDistribuidor='%@', \
                       Telefono='%@', \
                       TelefonoDistribuidor='%@', Puesto='%@',\
                       latitude=%@, \
                       longitude=%@ \
                       Where IdProspecto='%@'",
                       objUsuario.IdProspecto,
                       objUsuario.IdDispositivo,
                       objUsuario.IdMarca,
                       objUsuario.Distribuidor,
                       objUsuario.Prospecto,
                       objUsuario.Ejecutivo ,
                       objUsuario.IdEjecutivo,
                       objUsuario.PaginaWEB,
                       objUsuario.IdDistribuidor,
                       objUsuario.Telefono,
                       objUsuario.TelefonoDistribuidor,
                       objUsuario.Puesto, objUsuario.latitude, objUsuario.longitude, objUsuario.IdProspecto
                       ];
   
   const char *sn = [sqlCmd UTF8String];
   
   NSLog (@"Sentencia de insercciòn \n %@",sqlCmd);
   mensajeError=[self validaDatosUser:objUsuario];
   
   if (mensajeError!=@""){
      return mensajeError;
   }
   
   
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
   return mensajeError;
}



-(NSMutableArray*) getListaDistribuidores{
	NSMutableArray *distribuidores = [[[NSMutableArray alloc] init] autorelease];	  
   const char *sn= "Select IdEjecutivo, \
        IdProspecto, \
        NombreDistribuidor, \
        PaginaWeb, \
        NombreProspecto, \
        NombreEjecutivo, \
        idMarca, \
        idDispositivo, IdDistribuidor, Latitude, Longitude \
      From \
        Distribuidores";
   
//   NSLog(@"SENTENCIA %@", [NSString uti  sn);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
         
         Usuario *distribuidor = [[Usuario alloc] init];

            char* idEjecutivo=(char *)sqlite3_column_text(statement,0);
            char *idProspecto=(char *)sqlite3_column_text(statement,1);
            char* NombreDistribuidor=(char *)sqlite3_column_text(statement,2);
            char* paginaWeb = (char *)sqlite3_column_text(statement,3);
            char* NombreProspecto = (char *)sqlite3_column_text(statement,4);
            char* NombreEjecutivo=(char *)sqlite3_column_text(statement,5);
            char* idMarca=(char *)sqlite3_column_text(statement,6);
            char* idDispositivo=(char *)sqlite3_column_text(statement,7);
            char* iddistribuidor=(char *)sqlite3_column_text(statement,8);
            double latitude=(double) sqlite3_column_double(statement,9); 
            double longitude=(double) sqlite3_column_double(statement,10);

         
             NSString *miLatitude = [NSString stringWithFormat:@"%f",latitude];
              NSString *miLongitude = [NSString stringWithFormat:@"%f",longitude];
         
         
            distribuidor.longitude=miLatitude;
            distribuidor.latitude=miLongitude;
            distribuidor.IdProspecto= (idProspecto) ? [NSString stringWithUTF8String:idProspecto] : @"";
            distribuidor.Distribuidor=(NombreDistribuidor) ? [NSString stringWithUTF8String:NombreDistribuidor] : @"";
            distribuidor.PaginaWEB=(paginaWeb) ? [NSString stringWithUTF8String:paginaWeb] : @"";
            distribuidor.IdEjecutivo=(idEjecutivo) ? [NSString stringWithUTF8String:idEjecutivo] : @"";
            distribuidor.IdDispositivo=(idDispositivo) ? [NSString stringWithUTF8String:idDispositivo] : @"";
            distribuidor.IdMarca=(idMarca) ? [NSString stringWithUTF8String:idMarca] : @"";
            distribuidor.Prospecto=(NombreProspecto) ? [NSString stringWithUTF8String:NombreProspecto] : @"";
            distribuidor.Ejecutivo=(NombreEjecutivo) ? [NSString stringWithUTF8String:NombreEjecutivo] : @"";
            distribuidor.IdDistribuidor=(iddistribuidor) ? [NSString stringWithUTF8String:iddistribuidor] : @"";
		   	
         [distribuidores addObject:distribuidor];
			[distribuidor release];
         
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(dbCnxAct));
	}


   return distribuidores;
}

#pragma -
#pragma procedimiento de obtecion de datos del usuario actual 

-(NSString*) validaDatosUser:(Usuario*) objUsuario{
   
   
   if ( [objUsuario.IdProspecto isEqualToString:@""] || objUsuario.IdProspecto==nil ){
      mensajeError=@"Falta el id del prospecto.";}

   if ( [objUsuario.IdMarca isEqualToString:@""] || objUsuario.IdMarca==nil ){
      mensajeError=@"Falta la marca asociada al prospecto.";}

   if ( [objUsuario.Distribuidor isEqualToString:@""] || objUsuario.Distribuidor==nil ){
      mensajeError=@"Falta el nombre del distribuidor.";}

   if ( [objUsuario.Prospecto isEqualToString:@""] || objUsuario.Prospecto==nil ){
      mensajeError=@"Falta el nombre del prospecto.";}

   if ( [objUsuario.Ejecutivo isEqualToString:@""] || objUsuario.Ejecutivo==nil ){
      mensajeError=@"Falta el nombre del ejecutivo.";}

   return mensajeError;
}


- (void)dealloc {
    mensajeError=nil;
   [super dealloc];
}
@end
