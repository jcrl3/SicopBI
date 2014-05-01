//
//  DatCodigoPostal.m
//  SicopEventos
//
//  Created by JUAN RAMIREZ on 27/02/14.
//  Copyright (c) 2014 Sicop Consulting, SA de CV. All rights reserved.
//

#import "DatCodigoPostal.h"

@implementation DatCodigoPostal


-(NSString*) existeCodigoPostal:(NSString*) pCodigo{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
    sqlite3_stmt *statement;	//esta variable contendra el estado de la consulta
	NSString *mensaje;
	NSString* snSql;
	NSInteger totalRegistros;
	mensaje=@"NO";
	
	snSql= [NSString stringWithFormat:
	  @"Select \
			count(Codigo) as Existe \
		From \
			Codigos \
		Where \
		 Codigo='%@'", pCodigo];
	
const char *sn = [snSql UTF8String];

	NSLog (@"Sentencia de selección \n %@",snSql);
	
	
	int sqlResult = sqlite3_prepare_v2(self.getCnxBdActual, sn, -1, &statement, NULL);//Esta sentencia evalua si la sentencia es correcte
	
	//Si la sentencia no esta correcta entonces grabo en el log de sucesos
	if(sqlResult == SQLITE_OK){
		while(sqlite3_step(statement)== SQLITE_ROW) {
			totalRegistros=(int )sqlite3_column_int(statement,0);
		 }
		
		sqlite3_finalize(statement);
	}

	if (totalRegistros>0) {
		mensaje=@"SI";
	}
NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
return mensaje;
}

- (void)dealloc {
	[super dealloc];
}

@end
