//
//  datProspecto.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 14/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "datProspecto.h"
#import "Prospecto.h"
#import "SurveyAppDelegate.h"
@implementation datProspecto
SurveyAppDelegate *appDelegate;
@synthesize mensajeError;


-(id) init
{
   if (self == [super init])
   {
      appDelegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
  
   }
	return self;
}

#pragma mark -
#pragma mark -función que regresa el número de registros en la base de datos
-(NSString*) getNumeroRegistrosCapturados{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   NSString* totalRegistrosString;
   NSInteger totalRegistros;
   const char *sn="Select Count(*) as Total from Prospectos";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   
	totalRegistros=0;
	
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
         totalRegistros=(int )sqlite3_column_int(statement,0);
         
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(self.getCnxBdActual));
	}
   
   
   totalRegistrosString= [NSString stringWithFormat:@"%d", totalRegistros];
   return totalRegistrosString; 
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

#pragma mark -
#pragma mark -función que retorna el número de registros pendientes por enviar
-(NSInteger) getNumeroRegistrosPendientesPorEnviar{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  

   NSInteger totalRegistros;
   const char *sn="Select Count(idRegistro) As Total From ListaProspectosPorEnviar";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   
	totalRegistros=0;
	
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
         totalRegistros=(int )sqlite3_column_int(statement,0);
         
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(self.getCnxBdActual));
	}
   
   
   return totalRegistros; 
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

#pragma mark -
#pragma mark -función que regresa el ultimo id de prospecto insertado en la base de datos
-(NSString*) getIdUltimoRegistroCapturado{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   NSString* totalRegistrosString;
   NSInteger totalRegistros;
   const char *sn="Select max(IdRegistro) as IdRegistro from prospectos";
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   
	totalRegistros=0;
	
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
   {
      while(sqlite3_step(statement)== SQLITE_ROW)
      {
         
         totalRegistros=(int )sqlite3_column_int(statement,0);
         
      }
      
      sqlite3_finalize(statement);
    	
   }else{
      
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%s", sqlite3_errmsg(self.getCnxBdActual));
	}
   
   
   totalRegistrosString= [NSString stringWithFormat:@"%d", totalRegistros];
   return totalRegistrosString; 
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

#pragma mark -
#pragma mark -procedimiento de inserccion para un prospecto nuevo
-(NSString*) insertaProspecto:(Prospecto*) objProspecto{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   NSString *sqlCmd ;
   self.mensajeError=@"";
   
   //valido que las variables esten llenas 
   self.mensajeError=[self validaDatosProspecto:objProspecto];
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }


      sqlCmd = [NSString stringWithFormat:
                       @"Insert into \
                       Prospectos \
                       (idRegistro,primerNombre, segundoNombre, tercerNombre, telefono, correo, lineaInteres, ejecutivoAsignado, hizoPruebaDeManejo, deseaPruebaDeManejo,deseaCotizacion,renglonLinea, renglonEjecutivo, observaciones, interesadoAccesorios,CP,TelefonoMovil,autorizaContacto) \
                       Values((SELECT max(idRegistro) FROM Prospectos)+1,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@', '%@' , '%@','%@','%@',%@)",
                        objProspecto.primerNombre,
                        objProspecto.segundoNombre,
                        objProspecto.tercerNombre,
                        objProspecto.telefono,
                        objProspecto.correo,
                        objProspecto.lineaInteres ,
                        objProspecto.ejecutivoAsignado,
                        objProspecto.hizoPruebaDeManejo,
                        objProspecto.deseaPruebaDeManejo,
                        objProspecto.deseaCotizacion,
                        objProspecto.renglonLinea,
                        objProspecto.renglonEjecutivo, 
                        objProspecto.observaciones, 
                        objProspecto.interesadoAccesorios,
                        objProspecto.cp,
				        objProspecto.telefonoMovil,
				        objProspecto.autorizaContacto
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

//rutina de actualización de datos
-(NSString*) actualizaProspecto:(Prospecto*) objProspecto{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   self.mensajeError=@"";
   
   //valido que las variables esten llenas 
   self.mensajeError=[self validaDatosProspecto:objProspecto];
   
   if ([self.mensajeError  length]>0){
      return self.mensajeError;
   }

   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update \
                          Prospectos \
                       SET \n \
                           primerNombre='%@', \
                           segundoNombre='%@', \
                           tercerNombre='%@', \
                           telefono='%@', \
                           correo='%@', \
                           lineaInteres='%@', \
                           ejecutivoAsignado='%@', \
                           hizoPruebaDeManejo='%@', \
                           deseaPruebaDeManejo='%@', \
                           deseaCotizacion='%@', \
                           renglonLinea='%@', \
                           renglonEjecutivo='%@', \
                           observaciones='%@', \
                           interesadoAccesorios='%@', \
                           CP='%@', \
					       Enviado=0, \
					       TelefonoMovil='%@', \
					      autorizaContacto=%@  \
                       WHERE \
                         IdRegistro=%@",
                       objProspecto.primerNombre,
                       objProspecto.segundoNombre,
                       objProspecto.tercerNombre,
                       objProspecto.telefono,
                       objProspecto.correo,
                       objProspecto.lineaInteres ,
                       objProspecto.ejecutivoAsignado,
                       objProspecto.hizoPruebaDeManejo,
                       objProspecto.deseaPruebaDeManejo,
                       objProspecto.deseaCotizacion,
                       objProspecto.renglonLinea,
                       objProspecto.renglonEjecutivo, 
                       objProspecto.observaciones, 
                       objProspecto.interesadoAccesorios,
                       objProspecto.cp,
					   objProspecto.telefonoMovil,
					   objProspecto.autorizaContacto,
					   objProspecto.idRegistro
                       ];
   
   

   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: sqlCmd];

   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   return self.mensajeError;

}

#pragma mark -
#pragma mark -Grabado de los datos a nivel archivo para recuperciòn con XML
-(NSDictionary*) obtenerDatosDiccionario:(Prospecto*) objProspecto{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);

   NSArray *keys=[NSArray arrayWithObjects:@"primerNombre",
                  @"segundoNombre",
                  @"tercerNombre", 
                  @"telefono",
                  @"correo", 
                  @"lineaInteres",
                  @"ejecutivoAsignado",
                  @"hizoPruebaDeManejo",
                  @"deseaPruebaDeManejo",
                  @"deseaCotizacion",
                  @"renglonLinea",
                  @"renglonEjecutivo",
                  @"observaciones",
                  @"interesadoAccesorios",
                  @"codigoPostal", 
                  @"idRegistro",
				  @"telefonoMovil",
				  @"autorizaContacto",
                  nil];
   
   NSMutableArray *objects = [NSMutableArray arrayWithObjects: 
                  objProspecto.primerNombre,
                  objProspecto.segundoNombre,
                  objProspecto.tercerNombre,
                  objProspecto.telefono,
                  objProspecto.correo,
                  objProspecto.lineaInteres,	
                  objProspecto.ejecutivoAsignado,		
                  objProspecto.hizoPruebaDeManejo,
                  objProspecto.deseaPruebaDeManejo,		   
                  objProspecto.deseaCotizacion,	
                  objProspecto.renglonLinea,
                  objProspecto.renglonEjecutivo,
                  objProspecto.observaciones,
                  objProspecto.interesadoAccesorios, 
                  objProspecto.cp,	
                  objProspecto.idRegistro,
				  objProspecto.telefonoMovil,
			      objProspecto.autorizaContacto,
               nil];
   
   NSDictionary* sData = [[[NSDictionary alloc] initWithObjects:objects forKeys:keys] autorelease];

   return  sData;
 NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

-(void) grabarDatosEnXml:(NSMutableArray*) surveyDataArray{
  NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__); 
   ///grabo los datos del arreglo en  el  disco
   NSData *serializedData;
   NSString *error;
   
   serializedData= [NSPropertyListSerialization
                    dataFromPropertyList:surveyDataArray
                    format:NSPropertyListXMLFormat_v1_0 
                    errorDescription:&error];

   if (serializedData){
      NSArray *documentDirectoryPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *docDir =[NSString stringWithFormat:@"%@/prospectos.xml", [documentDirectoryPath objectAtIndex:0]];
      [serializedData writeToFile:docDir atomically:YES];
   }
 
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}
#pragma mark -
#pragma mark -Validación de los datos a insertar

-(NSString*) validaDatosProspecto:(Prospecto*) objProspecto{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
	BOOL telefonoUnoOk;
	BOOL telefonoDosOk;
	BOOL correoOk;
	
	telefonoUnoOk=TRUE;
	telefonoDosOk=TRUE;
	correoOk=TRUE;
	
   NSCharacterSet* myNumberSet;
   NSString* existeCp;
   myNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
   
   /*
   NSCharacterSet* myNumberSet; 
   myNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
   
   NSCharacterSet* myMailSet; 
   myMailSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];
   
   NSCharacterSet* myInvalidlSet; 
   myInvalidlSet = [NSCharacterSet characterSetWithCharactersInString:@"'/,.><}{[]"];
  */ 
   
   
   
   NSMutableString* mensajesDeError= [[[NSMutableString alloc] initWithString:@"" ] autorelease];
   
   if ( [objProspecto.primerNombre isEqualToString:@""] || objProspecto.primerNombre==nil   ){
       [mensajesDeError appendString:@"Nombre.\n"];
   }
   
   if ( [objProspecto.segundoNombre isEqualToString:@""] || objProspecto.segundoNombre ==nil ){
       [mensajesDeError appendString:@"Apellido paterno.\n"];
   }
   
   if ( [objProspecto.tercerNombre isEqualToString:@""] || objProspecto.tercerNombre ==nil ){
       [mensajesDeError appendString:@"Apellido materno.\n"];
   }


   
   if ( [objProspecto.telefono isEqualToString:@""] || objProspecto.telefono ==nil || [objProspecto.telefono length]<8  ){
    // [mensajesDeError appendString:@"Teléfono está incompleto o vacío.\n"];
	   telefonoUnoOk=false;
     }
   
	if ( [objProspecto.telefonoMovil isEqualToString:@""] || objProspecto.telefonoMovil ==nil || [objProspecto.telefonoMovil length]<8  ){
//		[mensajesDeError appendString:@"Teléfono está incompleto o vacío.\n"];
		telefonoDosOk=false;
	}
	

   if ( [objProspecto.correo isEqualToString:@""] || objProspecto.correo ==nil ){
        //[mensajesDeError appendString:@"Correo electrónico.\n"];
	   correoOk=false;
      }else{
         if (![objProspecto.correo esCorrectoEmail: objProspecto.correo]){
             [mensajesDeError appendString:@"El correo electrónico no es correcto.\n"];
			 correoOk=false;
         }
   }


   if ( [objProspecto.lineaInteres isEqualToString:@""] || objProspecto.lineaInteres ==nil || [objProspecto.lineaInteres isEqualToString:@"AUTO..."] ){
      [mensajesDeError appendString:@"línea de interés.\n"];
   }

   if ( [objProspecto.ejecutivoAsignado isEqualToString:@""] || objProspecto.ejecutivoAsignado ==nil ||[objProspecto.ejecutivoAsignado isEqualToString:@"EJECUTIVO..."] ){
      [mensajesDeError appendString:@"Ejecutivo de ventas.\n"];
   }
   
   //if (![objProspecto.cp isEqualToString:@""]) {
      //if ([appDelegate validaTextField:myNumberSet textovalidar:objProspecto.cp]==FALSE) {
        // [mensajesDeError appendString:@"El código postal no es numérico.\n"];
     // }
      
      if ([objProspecto.cp length]>0) {
		  DatCodigoPostal *baseDeCps =  [[DatCodigoPostal alloc] init];
		  existeCp=[baseDeCps existeCodigoPostal:objProspecto.cp];
		  if ([existeCp isEqualToString:@"NO"]){
           [mensajesDeError appendString:@"El código postal no es válido.\n"];
		  }
		  [baseDeCps release];
      }
  // }
   
	if (telefonoDosOk || telefonoUnoOk || correoOk){
       //todo ok
	}else{
		[mensajesDeError appendString:@"El correo o alguno de los teléfenos no esta capturado"];
	}
	
	
	
	
   self.mensajeError= [NSString stringWithString: mensajesDeError];
   return mensajeError;
 NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

#pragma mark -
#pragma mark Rutina que obtiene el listado de prospectos no enviados

-(NSMutableArray*) getListaProspectosPorEnviar{
   NSMutableArray *prospectos = [[[NSMutableArray alloc]  init ] autorelease];	  
   
   NSString* snSql= @"Select \
            idRegistro, \
            primerNombre, \
            segundoNombre,  \
            tercerNombre, \
            telefono, \
            correo, \
            lineaInteres, \
            ejecutivoAsignado, \
            hizoPruebaDeManejo, \
            deseaPruebaDeManejo, \
            deseaCotizacion, \
            observaciones, \
            interesadoAccesorios, \
            CP, IdSicop, IdDistribuidor, TelefonoMovil \
         From \
            ListaProspectosPorEnviar";
   
   const char *sn = [snSql UTF8String];	

	sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);	
   //Verificamos si la sentencia está correcta
	if (sqlResult== SQLITE_OK) {
      //Recuperamos los registros
		while(sqlite3_step(statement)== SQLITE_ROW){
         NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			char* idregistro			=(char*)sqlite3_column_text(statement,0);
			char* primerNombre			=(char*)sqlite3_column_text(statement,1);
			char* segundoNombre			=(char*)sqlite3_column_text(statement,2);
			char* tercerNombre			=(char*)sqlite3_column_text(statement,3);
			char* telefono				=(char*)sqlite3_column_text(statement,4);
			char* correo				=(char*)sqlite3_column_text(statement,5);
			char* lineaInteres			=(char*)sqlite3_column_text(statement,6);
			char* ejecutivoAsignado		=(char*)sqlite3_column_text(statement,7);
			char* hizoPruebaDeManejo	=(char*)sqlite3_column_text(statement,8);
			char* deseaPruebaDeManejo	=(char*)sqlite3_column_text(statement,9);
			char* deseaCotizacion		=(char*)sqlite3_column_text(statement,10);
			char* observaciones			=(char*)sqlite3_column_text(statement,11);
			char* interesadoAccesorios	=(char*)sqlite3_column_text(statement,12);
			char* cp					=(char*)sqlite3_column_text(statement,13);
			char* idsicop				=(char*)sqlite3_column_text(statement,14);
			char* iddistribuidor		=(char*)sqlite3_column_text(statement,15);
			char* telefonomovil			=(char*)sqlite3_column_text(statement,16);
         
			Prospecto *prospectoPorEnviar = [[Prospecto alloc] init];

            prospectoPorEnviar.idRegistro			=(idregistro) ? [NSString stringWithUTF8String:idregistro] : @"";
            prospectoPorEnviar.primerNombre			=(primerNombre) ? [NSString stringWithUTF8String:primerNombre] : @"";
            prospectoPorEnviar.segundoNombre		=(segundoNombre) ? [NSString stringWithUTF8String:segundoNombre] : @"";
            prospectoPorEnviar.tercerNombre			=(tercerNombre) ? [NSString stringWithUTF8String:tercerNombre] : @"";
            prospectoPorEnviar.telefono				=(telefono) ? [NSString stringWithUTF8String:telefono] : @"";
            prospectoPorEnviar.correo				=(correo) ? [NSString stringWithUTF8String:correo] : @"";
            prospectoPorEnviar.lineaInteres			=(lineaInteres) ? [NSString stringWithUTF8String:lineaInteres] : @"";
            prospectoPorEnviar.ejecutivoAsignado	=(ejecutivoAsignado) ? [NSString stringWithUTF8String:ejecutivoAsignado] : @"";
            prospectoPorEnviar.hizoPruebaDeManejo	=(hizoPruebaDeManejo) ? [NSString stringWithUTF8String:hizoPruebaDeManejo] : @"";
            prospectoPorEnviar.deseaPruebaDeManejo	=(deseaPruebaDeManejo) ? [NSString stringWithUTF8String:deseaPruebaDeManejo] : @"";
            prospectoPorEnviar.deseaCotizacion		=(deseaCotizacion) ? [NSString stringWithUTF8String:deseaCotizacion] : @"";
            prospectoPorEnviar.observaciones		=(observaciones) ? [NSString stringWithUTF8String:observaciones] : @"";
            prospectoPorEnviar.interesadoAccesorios	=(interesadoAccesorios) ? [NSString stringWithUTF8String:interesadoAccesorios] : @"";
            prospectoPorEnviar.cp					=(cp) ? [NSString stringWithUTF8String:cp] : @"";
            prospectoPorEnviar.idSicop				=(idsicop) ? [NSString stringWithUTF8String:idsicop] : @"";
            prospectoPorEnviar.idDistribuidor		=(iddistribuidor) ? [NSString stringWithUTF8String:iddistribuidor] : @"";
			prospectoPorEnviar.telefonoMovil		=(telefonomovil) ? [NSString stringWithUTF8String:telefonomovil] : @"";
         
         //agregamos el objeto de prospectos a arreglo que contiene la lista de prospectos
          [prospectos addObject: prospectoPorEnviar];
         [prospectoPorEnviar release];
         [pool drain]; 
      }
      sqlite3_finalize(statement);
		
   }else{
      NSLog(@"Problemas con la base de datos");
      NSLog(@"%d", sqlResult);
	}
   
	return prospectos;

   
}

-(NSMutableArray*) getListaProspectos{
   NSMutableArray *prospectos = [[[NSMutableArray alloc]  init ] autorelease];	  
   
   NSString* snSql= @"Select \
   idRegistro, \
   primerNombre, \
   segundoNombre,  \
   tercerNombre, \
   telefono, \
   correo, \
   lineaInteres, \
   ejecutivoAsignado, \
   hizoPruebaDeManejo, \
   deseaPruebaDeManejo, \
   deseaCotizacion, \
   observaciones, \
   interesadoAccesorios, \
   CP, \
   renglonLinea, \
   renglonEjecutivo, \
   TelefonoMovil, \
   autorizaContacto \
   From \
   Prospectos";

   /*
    idRegistro,				0
    primerNombre,			1
    segundoNombre			2
    tercerNombre,			3
    telefono,				4
    correo,					5
    lineaInteres,			6
    ejecutivoAsignado,		7
    hizoPruebaDeManejo,		8
    deseaPruebaDeManejo,	9
    deseaCotizacion,		10
    observaciones			11
    interesadoAccesorios,	12
    CP,						13
    renglonLinea,			14
    renglonEjecutivo		15
    TelefonoMovil			16
	autorizaContacto		17
    */
   
   
   
   const char *sn = [snSql UTF8String];	
   
	sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);	
   //Verificamos si la sentencia está correcta
	if (sqlResult== SQLITE_OK) {
      //Recuperamos los registros
		while(sqlite3_step(statement)== SQLITE_ROW){
         NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
         char* idregistro			=(char*)sqlite3_column_text(statement,0);
         char* primerNombre			=(char*)sqlite3_column_text(statement,1);
         char* segundoNombre		=(char*)sqlite3_column_text(statement,2);
         char* tercerNombre			=(char*)sqlite3_column_text(statement,3);
         char* telefono				=(char*)sqlite3_column_text(statement,4);
         char* correo				=(char*)sqlite3_column_text(statement,5);
         char* lineaInteres			=(char*)sqlite3_column_text(statement,6);
         char* ejecutivoAsignado	=(char*)sqlite3_column_text(statement,7);
         char* hizoPruebaDeManejo	=(char*)sqlite3_column_text(statement,8);
         char* deseaPruebaDeManejo	=(char*)sqlite3_column_text(statement,9);
         char* deseaCotizacion		=(char*)sqlite3_column_text(statement,10);
         char* observaciones		=(char*)sqlite3_column_text(statement,11);
         char* interesadoAccesorios	=(char*)sqlite3_column_text(statement,12);
         char* cp					=(char*)sqlite3_column_text(statement,13);
         char* renlonlinea			=(char*)sqlite3_column_text(statement,14);
         char* renglonejecutivo		=(char*)sqlite3_column_text(statement,15);
		 char* telefonomovil		=(char*)sqlite3_column_text(statement,16);
		 char* autorizacontacto		=(char*)sqlite3_column_text(statement,17);
         
         Prospecto *prospectoPorEnviar = [[Prospecto alloc] init];
         
         prospectoPorEnviar.idRegistro			=(idregistro) ? [NSString stringWithUTF8String:idregistro] : @"";
         prospectoPorEnviar.primerNombre		=(primerNombre) ? [NSString stringWithUTF8String:primerNombre] : @"";
         prospectoPorEnviar.segundoNombre		=(segundoNombre) ? [NSString stringWithUTF8String:segundoNombre] : @"";
         prospectoPorEnviar.tercerNombre		=(tercerNombre) ? [NSString stringWithUTF8String:tercerNombre] : @"";
         prospectoPorEnviar.telefono			=(telefono) ? [NSString stringWithUTF8String:telefono] : @"";
         prospectoPorEnviar.correo				=(correo) ? [NSString stringWithUTF8String:correo] : @"";
         prospectoPorEnviar.lineaInteres		=(lineaInteres) ? [NSString stringWithUTF8String:lineaInteres] : @"";
         prospectoPorEnviar.ejecutivoAsignado	=(ejecutivoAsignado) ? [NSString stringWithUTF8String:ejecutivoAsignado] : @"";
         prospectoPorEnviar.hizoPruebaDeManejo	=(hizoPruebaDeManejo) ? [NSString stringWithUTF8String:hizoPruebaDeManejo] : @"";
         prospectoPorEnviar.deseaPruebaDeManejo	=(deseaPruebaDeManejo) ? [NSString stringWithUTF8String:deseaPruebaDeManejo] : @"";
         prospectoPorEnviar.deseaCotizacion		=(deseaCotizacion) ? [NSString stringWithUTF8String:deseaCotizacion] : @"";
         prospectoPorEnviar.observaciones		=(observaciones) ? [NSString stringWithUTF8String:observaciones] : @"";
         prospectoPorEnviar.interesadoAccesorios=(interesadoAccesorios) ? [NSString stringWithUTF8String:interesadoAccesorios] : @"";
         prospectoPorEnviar.cp					=(cp) ? [NSString stringWithUTF8String:cp] : @"";
         prospectoPorEnviar.renglonLinea		=(renlonlinea) ? [NSString stringWithUTF8String:renlonlinea] : @"";
         prospectoPorEnviar.renglonEjecutivo	=(renglonejecutivo) ? [NSString stringWithUTF8String:renglonejecutivo] : @"";
		 prospectoPorEnviar.telefonoMovil		=(telefonomovil) ? [NSString stringWithUTF8String:telefonomovil] : @"";
		 prospectoPorEnviar.autorizaContacto	=(autorizacontacto) ? [NSString stringWithUTF8String:autorizacontacto] : @"";
         
         //agregamos el objeto de prospectos a arreglo que contiene la lista de prospectos
         [prospectos addObject: prospectoPorEnviar];
         [prospectoPorEnviar release];
         [pool drain]; 
      }
      sqlite3_finalize(statement);
		
   }else{
      NSLog(@"Problemas con la base de datos");
      NSLog(@"%d", sqlResult);
	}
   
	return prospectos;
  
}

#pragma mark -
#pragma mark Rutina marca prospecto como enviado
-(void) marcaProspectoComoEnviado: (NSString*) pIdRegistro{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update Prospectos set Enviado=1 where IdRegistro= %@",
                       pIdRegistro];
   
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: [NSString stringWithUTF8String:sn]];
NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

-(void) estableceIdSicop: (NSString*) pIdRegistro idSicop:(NSString*) pIdSicop {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   NSString *sqlCmd = [NSString stringWithFormat:
                       @"Update Prospectos set IdSicop='%@' where IdRegistro= %@",
                       pIdSicop,pIdRegistro];
   
   const char *sn = [sqlCmd UTF8String]; 
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: [NSString stringWithUTF8String:sn]];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}


#pragma mark -
#pragma mark Rutina para borrar la tabla de prospectos

-(void) borraTablaProspectos{
   NSString *sqlCmd = @"DELETE FROM Prospectos";
   const char *sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   [self ejecutarSentencia: sqlCmd];
   
   sqlCmd = @"EXPLAIN QUERY PLAN VACUUM";
   sn = [sqlCmd UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]); 
   [self ejecutarSentencia: sqlCmd];
}


- (void)dealloc {    
   [super dealloc];   
}


@end
