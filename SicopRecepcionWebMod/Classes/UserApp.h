//
//  UserApp.h
//  SicopRecepcion
//
//  Created by JUAN RAMIREZ on 13/02/13.
//
//

#import <Foundation/Foundation.h>


@interface UserApp : NSObject{
 
    NSString  *IdEjecutivo;
    NSString  *IdMarca;
    NSString  *Marca;
    NSString  *Servidor;
    NSString  *BaseDeDatos;
    NSString  *isTablet;
}
@property (nonatomic,retain) NSString  *IdEjecutivo;
@property (nonatomic,retain) NSString  *IdMarca;
@property (nonatomic,retain) NSString  *Marca;
@property (nonatomic,retain) NSString  *Servidor;
@property (nonatomic,retain) NSString  *BaseDeDatos;
@property (nonatomic,retain) NSString  *isTablet;

@end
