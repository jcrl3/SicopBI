//
//  Sonido.m
//  SicopComunicationCenter
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 17/11/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Sonido.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation Sonido


- (id) init{
	if(self == [super init])
	{
	
   }
      return self;
}


-(void) reproduceSonido{

   NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/tink.wav"];
   
   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  
	//declare a system sound
	 SystemSoundID soundID;
   
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
   
   
   
	//Use audio sevices to create the sound

   AudioServicesCreateSystemSoundID(
                                    (CFURLRef) filePath,
                                    &soundID
                                    );	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
 
}

-(void) vibrar{
   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)dealloc {
  	[super dealloc];
}

@end
