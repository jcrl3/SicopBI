//
//  SqlSentenceManager.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 30/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqlSentenceManager : NSObject{
	
}
+(NSString*)getSentenceForKpi:(NSString*)fieldToCount
				 fieldToGroup:(NSString*)fieldToGroup
				   fromIdDate:(NSString*)fromIdDate
					 toIdDate:(NSString*)toIdDate
		fieldToGroupAfterFrom:(NSString*)fieldToGroupAfterFrom
				 fieldToOrder:(NSString*)fieldToOrder
		   aditionalCondition:(NSString*)aditionalCondition;

@end
