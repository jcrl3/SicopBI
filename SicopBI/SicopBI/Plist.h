//
//  Plist.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 08/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plist : NSObject{
	
}

+(NSArray*)getArrayFromPlist:(NSString *) pPlistName Section:(NSString*) pSectionName;


@end
