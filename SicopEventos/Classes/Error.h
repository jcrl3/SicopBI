//
//  Error.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 21/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject{
   NSString* mensajeDeError;
   NSInteger numeroError;
}
@property (nonatomic,retain) NSString* mensajeDeError;
@property (nonatomic) NSInteger numeroError;
@end
