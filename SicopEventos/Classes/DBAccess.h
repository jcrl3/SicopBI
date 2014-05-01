//
//  DBAccess.h
//  DemoSicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBAccess : NSObject {
    
}
-(NSMutableArray*) getListaLineasParaPicker;
-(NSMutableArray*) getListaEjecutivosParaPicker;
-(sqlite3*) getCnxBdActual;
-(NSString *)databasePath;
-(void) verificaBdModificable;
-(void) cierraBaseDeDatos;
-(void) abreBaseDeDatos;
-(void)ejecutarSentencia:(NSString*) sntSql ;
@end
