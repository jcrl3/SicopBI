//
//  DBConexion.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBConexion : NSObject{
   sqlite3* dbCnxAct;
 
@private 
   NSString* nombreBaseDatos;
   
}
@property (nonatomic) sqlite3* dbCnxAct;
-(void) verificaBdModificable;
-(void) cierraBaseDeDatos;
-(void) abreBaseDeDatos;
-(void)ejecutarSentencia:(NSString*) sntSql;



@end
