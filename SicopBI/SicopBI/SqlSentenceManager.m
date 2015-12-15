//
//  SqlSentenceManager.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 30/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "SqlSentenceManager.h"

@implementation SqlSentenceManager{

}


+(NSString*)getSentenceForKpi:(NSString*)fieldToCount
				 fieldToGroup:(NSString*)fieldToGroup
				   fromIdDate:(NSString*)fromIdDate
					 toIdDate:(NSString*)toIdDate
				 fieldToGroupAfterFrom:(NSString*)fieldToGroupAfterFrom
				 fieldToOrder:(NSString*)fieldToOrder
		   aditionalCondition:(NSString*)aditionalCondition {
	
	
	NSString *querySn= [NSString stringWithFormat:@"SELECT \
						%@ as FieldtoGroup, \
						%@ AS FieldToCount \
						FROM \
						  KPIS \
						WHERE \
						  IdFecha BETWEEN %@ and  %@  %@\
						GROUP BY \
						   %@ ",fieldToGroup, fieldToCount, fromIdDate, toIdDate, aditionalCondition, fieldToGroupAfterFrom];

						if (fieldToOrder!=nil) {
		querySn = [querySn stringByAppendingString:[NSString stringWithFormat:@" ORDER BY %@",fieldToOrder]];
	}

	
    return querySn;
}

@end
