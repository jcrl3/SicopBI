//
//  NSArray-NestedArrays.m
//  Sicop
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 29/03/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "NSArray-NestedArrays.h"


@implementation NSArray(NestedArrays)

-(id)nestedObjectAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
    NSArray *subArray = [self objectAtIndex:section];
	
	if (![subArray isKindOfClass:[NSArray class]])
		  return nil;
		  
	if (row >= [subArray count])
		  return nil;
		  
	return [subArray objectAtIndex:row];	  

}

-(NSInteger)CountOfNestedArray:(NSUInteger)section
{
	NSArray *subArray=[self objectAtIndex:section];
	return [subArray count];
 
}
		  
@end
