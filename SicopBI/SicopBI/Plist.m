//
//  Plist.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 08/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "Plist.h"

@implementation Plist


+(NSArray*)getArrayFromPlist:(NSString *) pPlistName Section:(NSString*) pSectionName{
	NSString *path = [[NSBundle mainBundle] pathForResource:pPlistName ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	NSArray *tableData = [dict objectForKey:pSectionName];
	return tableData;
}

@end
