//
//  ResultDataObject.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 02/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "ResultDataObject.h"

@implementation ResultDataObject{
	
}
@synthesize fieldtoGroup;
@synthesize fieldtoCount;

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.fieldtoGroup =@"";
		self.fieldtoCount =@"";
	}
	return self;
}
@end
