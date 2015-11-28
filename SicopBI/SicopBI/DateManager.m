//
//  DateManager.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 27/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager{
	
	
	
	
}

NSString* currentDate;
NSString* yearOfDate;
NSString* dayOfDate;
NSString* monthOfDate;


@synthesize currentDate;
@synthesize yearOfDate;
@synthesize dayOfDate;
@synthesize monthOfDate;
@synthesize dateFormat;

- (instancetype)init
{
	self = [super init];
	
	if (self) {
		if (self.dateFormat == nil){
			self.dateFormat=@"yyy-MM-dd";
		}
		currentDate = [self stringFromDate];
		[self setYearDayMonthFromDate];
	}
	return self;
}

- (instancetype)initWithDate: (NSDate*) date;
{
	self = [super init];
	
	if (self) {

		if (self.dateFormat == nil){
			self.dateFormat=@"yyy-MM-dd";
		}

		  currentDate = [self stringFromDate:date];

		
		[self setYearDayMonthFromDate];

	}
	return self;
}


-(NSString*) getDate{
	self.currentDate = currentDate;
	return self.currentDate;
}

-(NSString*) getYear{
	self.yearOfDate=yearOfDate;
	return self.yearOfDate;
}
-(NSString*) getDay{
	self.dayOfDate = dayOfDate;
	return self.dayOfDate;
}
-(NSString*) getMonth{
	self.monthOfDate = monthOfDate;
	return self.monthOfDate;
}

/*
-(NSArray*)  getIdFromDate:(NSString*)fromDate toDate:(NSString*)toDate{
	
	
}
*/

-(NSString*) addOrLessDaysToDate:(NSInteger)days{
	NSDate *date = [self dateFromString:currentDate];
	NSDate *sevenDaysAgo = [date dateByAddingTimeInterval:days*24*60*60];
	return [self stringFromDate:sevenDaysAgo];
}
-(void) setYearDayMonthFromDate{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self dateFromString:currentDate]];
	
	NSInteger year = [components year];
	NSInteger month = [components month];
	NSInteger day = [components day];
	
	yearOfDate= [NSString stringWithFormat: @"%ld", (long)year];
	dayOfDate= [NSString stringWithFormat: @"%ld", (long)day];
	monthOfDate= [NSString stringWithFormat: @"%ld", (long)month];
	
}
-(NSDate*)dateFromString:(NSString*)date{
	NSDateFormatter *dateFormatter;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:self.dateFormat];
	}
	return [dateFormatter dateFromString:date];
}

- (NSString*) stringFromDate {
	NSDateFormatter *dateFormatter;
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:self.dateFormat];
	return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString*) stringFromDate:(NSDate*) date; {
	NSDateFormatter *dateFormatter;
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:self.dateFormat];
	return [dateFormatter stringFromDate:date];
}



@end
