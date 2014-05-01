//
//  Distribuidor.h
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 28/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Distribuidor : NSObject{
   NSString* idDistribuidor;
   NSString* nombreDistribuidor; 

}
@property (nonatomic,retain) NSString* idDistribuidor;
@property (nonatomic,retain) NSString* nombreDistribuidor; 

@end
