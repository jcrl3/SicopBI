//
//  ManejoRequestsMensajes.h
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 30/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "XMLParser.h"
#import "Mensaje.h"
@interface ManejoRequestsMensajes : NSObject{
   	SicopRecepcionAppDelegate *appDelegate;
}
-(ManejoRequestsMensajes*) initWithRequest;
@end
