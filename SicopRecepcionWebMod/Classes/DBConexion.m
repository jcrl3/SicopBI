//
//  DBConexion.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DBConexion.h"

@implementation DBConexion
@synthesize dbCnxAct;

-(id) init
{
   if (self == [super init])
   {
      nombreBaseDatos=@"SicopComCntr.db";
	   [self abreBaseDeDatos];  
   }
	return self;
}


//*********************************************************************************************************************************
//  Procedimientos de apertuta y cierre de base de datos
//*********************************************************************************************************************************
#pragma
#pragma Procedimientos de verificación de la base de datos
#pragma
-(NSString *)databasePath
{
   NSArray *documentDirectoryPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *docDir =[NSString stringWithFormat:@"%@/SicopComCntr.db", [documentDirectoryPath objectAtIndex:0]];
	//[NSString stringWithFormat:@"%@/SicopComCntr.db", [documentDirectoryPath objectAtIndex:0]];
   NSString *docDir =[NSString stringWithFormat:@"%@/", [documentDirectoryPath objectAtIndex:0]];	
  
   docDir=[docDir stringByAppendingFormat:nombreBaseDatos];
   NSLog(@"Abriendo base de datos %@", docDir  );	

	return docDir;  
   
}

-(void) cierraBaseDeDatos

{
	if (sqlite3_close(dbCnxAct) != SQLITE_OK)
	{
		NSAssert1(0, @"Fallo el cierre de la base de datos: '%s'.", sqlite3_errmsg(dbCnxAct));
	}
	
}

-(void) abreBaseDeDatos
{
	//NSString *ruta = [[ NSBundle mainBundle] pathForResource:@"SicopIphone" ofType:@"db"];
   [self verificaBdModificable];
	NSString *ruta = [self databasePath];    //[[ NSBundle mainBundle] pathForResource:@"SicopIphone" ofType:@"db"];
   
	//abrimos la base de datos
	if (sqlite3_open([ruta UTF8String], &dbCnxAct)== SQLITE_OK)
	{
		NSLog(@"Abriendo base de datos");	
	}
	else
   {
		//cerrar la bd sino se encuentra
		sqlite3_close(dbCnxAct);
		NSAssert1(0, @"Fallo la apertura de la base de datos: '%s'.", sqlite3_errmsg(dbCnxAct));
		
	}
}

-(void) verificaBdModificable
{
   
	BOOL existeBD;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *writableDB =[documentsDir stringByAppendingPathComponent:nombreBaseDatos];
	existeBD = [fileManager fileExistsAtPath:writableDB];
	
	if (existeBD) return;
	
   //sino existe la copia entonces se hace una copia del bundle a documentsdirectory
	
	NSString *defaultPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:nombreBaseDatos];
	existeBD = [fileManager copyItemAtPath:defaultPath toPath:writableDB error:&error];
	
	if(!existeBD)
	{
		NSAssert1(0, @"Fallo la copia de la BD al directorio de documentos:'%@'.", [error localizedDescription]); 
      
	}
	
	
	
	return;
	
}

-(void)ejecutarSentencia:(NSString*) sntSql  {
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
   const char *sn = [sntSql UTF8String];
   NSLog(@"Sentencia %@",[NSString stringWithUTF8String:sn]);
   
   int sqlResult = sqlite3_prepare_v2(dbCnxAct, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
   
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


- (void)dealloc {
   [self cierraBaseDeDatos];
   nombreBaseDatos=nil;
  	[super dealloc];
   
}


@end
