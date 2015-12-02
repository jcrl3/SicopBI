//
//  DimDate.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 29/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "DimDate.h"

@implementation DimDate{
	
}
+(NSString*)getIdFecha:(NSString*)day month:(NSString*)month year:(NSString*)year{
	AppDelegate *SicopBIDelegate;
	SicopBIDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *idDate;
	
	NSString *querySn= [NSString stringWithFormat:@"SELECT \
						IdFecha \
						From \
						Fechas \
						Where \
						DiaDelMes=%@ \
						and Mes =%@ \
						and Ano=%@",day, month,year];
						
	
	NSArray *idDates= [SicopBIDelegate.dbManager loadDataFromDB:querySn];
	idDate=@"1";
	
	if (idDates.count>0){
		//idDate=(NSString*)[idDates objectAtIndex:0];
		
		idDate=[NSString stringWithFormat:@"%@", [[idDates objectAtIndex:0] objectAtIndex:0]];

	}
 return idDate;
}

//+(NSInteger) daysFromTodayUntilFirstDayOfMonth:(

@end
