//
//  InfoDispositivo.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 12/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIDevice+IdentifierAddition.h"
#import "NSString+MD5Addition.h"

@interface InfoDispositivo : NSObject{

@private
   NSString *idDispositivo;
}

-(NSString*) getIdDispositivo;
@end
