//
//  DBAccess.m
//  DemoSicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBAccess.h"

@implementation DBAccess
sqlite3* databaseCn;

-(id) init{
    if (self == [super init]){
        [self abreBaseDeDatos];  
    }
	return self;
}

-(NSMutableArray*) getListaEjecutivosParaPicker{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  

	NSMutableArray *ejecutivos = [[[NSMutableArray alloc] init ] autorelease];	  

   NSString*  ejecutivoNulo= @"EJECUTIVO...";
   [ejecutivos addObject:ejecutivoNulo];

	const char *sn = "Select  TRIM( N_Nombre) from Ejecutivos Order by Orden";
	
	sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(databaseCn, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK){
		    while(sqlite3_step(statement)== SQLITE_ROW){
             NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

		     	   char* nombreEjecutivo=(char *)sqlite3_column_text(statement,0);
			      [ejecutivos addObject:(nombreEjecutivo) ? [NSString stringWithUTF8String:nombreEjecutivo] : @""];
              [pool drain]; 
		      }
		    sqlite3_finalize(statement);
      }else{
		   NSLog(@"Problemas con la base de datos");
		   NSLog(@"%d", sqlResult);
	}
	return ejecutivos;
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

-(NSMutableArray*) getListaLineasParaPicker{
	NSMutableArray *lineas = [[[NSMutableArray alloc]  init ] autorelease];	  
    NSString*  lineaNula= @"AUTO...";
   [lineas addObject:lineaNula];
   

	const char *sn = "SELECT idAuto, Nombre From Autos where Nombre <>'.' Order by Nombre";
	
	sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(databaseCn, sn, -1, &statement, NULL);	
   //Verificamos si la sentencia está correcta
	if (sqlResult== SQLITE_OK) {
      //Recuperamos los registros
		while(sqlite3_step(statement)== SQLITE_ROW){
           NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	   		char* nombreLinea=(char *)sqlite3_column_text(statement,1);
  		   	[lineas addObject:(nombreLinea) ? [NSString stringWithUTF8String:nombreLinea] : @""];
           [pool drain]; 
	   	}
		  sqlite3_finalize(statement);
		
	  }else{
		 NSLog(@"Problemas con la base de datos");
		 NSLog(@"%d", sqlResult);
	}
   
	return lineas;
   }


-(NSString *)databasePath{
	
	NSArray *documentDirectoryPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDir =[NSString stringWithFormat:@"%@/SicopEventos.db", [documentDirectoryPath objectAtIndex:0]];
	return docDir;  
}

-(void) cierraBaseDeDatos{
	if (sqlite3_close(databaseCn) != SQLITE_OK)	{
		NSAssert1(0, @"Fallo el cierre de la base de datos: '%s'.", sqlite3_errmsg(databaseCn));
	 }
	
}

-(void) abreBaseDeDatos{
   [self verificaBdModificable]; 
	NSString *ruta = [self databasePath];       
	//abrimos la base de datos
	if (sqlite3_open([ruta UTF8String], &databaseCn)== SQLITE_OK){
		NSLog(@"Abriendo base de datos");	
   	}else{
		//cerrar la bd sino se encuentra
		sqlite3_close(databaseCn);
		NSAssert1(0, @"Fallo la apertura de la base de datos: '%s'.", sqlite3_errmsg(databaseCn));
	}
}

-(void) verificaBdModificable{
	BOOL existeBD;

	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *writableDB =[documentsDir stringByAppendingPathComponent:@"SicopEventos.db"];
	existeBD = [fileManager fileExistsAtPath:writableDB];
	
	if (existeBD) return;
	
    //sino existe la copia entonces se hace una copia del bundle a documentsdirectory
	
  	NSString *defaultPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SicopEventos.db"];
	existeBD = [fileManager copyItemAtPath:defaultPath toPath:writableDB error:&error];
	
	if(!existeBD){
		NSAssert1(0, @"Fallo la copia de la BD al directorio de documentos:'%@'.", [error localizedDescription]); 
	}
	
	return;
}

#pragma mark -
#pragma mark - Rutina para ejecuciòn de sentencias SQL
-(void)ejecutarSentencia:(NSString*) sntSql  {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   const char *sn = [sntSql UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   
   int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
   //Si la sentencia no esta correcta entonces borro los encabezados recientes para actualizarlos con los ultimos
   if(sqlResult == SQLITE_OK){	
      
      if(SQLITE_DONE != sqlite3_step(statement)){
         NSLog(@">>> Error al momento de ejecutar la sentencia");  
      }
      
   }else{
      NSLog(@">>> La sentencia es incorrecta");  
   }
   
   sqlite3_finalize(statement);
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   
}


-(sqlite3*) getCnxBdActual{
	return databaseCn;
}

@end