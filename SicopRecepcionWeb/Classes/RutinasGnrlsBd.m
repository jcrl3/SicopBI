//
//  RutinasGnrlsBd.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 27/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "RutinasGnrlsBd.h"

@implementation RutinasGnrlsBd


-(NSMutableArray*) getListaDatosSnlgEditor: (char*) Sentencia{
	NSMutableArray *arrDatos = [[[NSMutableArray alloc] init] autorelease];	  
	
   //"SELECT Descripcion FROM fuenteInformacion Order by Descripcion";
	
	sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	
	int sqlResult = sqlite3_prepare_v2(dbCnxAct, Sentencia, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	if (sqlResult== SQLITE_OK)  //esta sentencia recupera los datos 
	{
		while(sqlite3_step(statement)== SQLITE_ROW)
		{
			char* nombreDato=(char *)sqlite3_column_text(statement,0);
			[arrDatos addObject:(nombreDato) ? [NSString stringWithUTF8String:nombreDato] : @""];
      }
		sqlite3_finalize(statement);
   }
	else
	{
		NSLog(@"Problemas con la base de datos");
		NSLog(@"%d", sqlResult);
	}
	
	
	return arrDatos;
	
}

@end
