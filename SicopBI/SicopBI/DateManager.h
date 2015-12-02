//
//  DateManager.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 27/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject{
	
}
/*
@property (nonatomic,strong) NSString* currentDate;
@property (nonatomic,strong) NSString* yearOfDate;
@property (nonatomic,strong) NSString* dayOfDate;
@property (nonatomic,strong) NSString* monthOfDate;
*/
@property (nonatomic,strong) NSString* dateFormat;

-(NSString*) getDate;
-(NSString*) getYear;
-(NSString*) getDay;
-(NSString*) getMonth;
-(void) setDate:(NSString*)date;
-(NSDate*)dateFromString:(NSString*)date;
-(NSString*) addOrLessDaysToDate:(NSInteger)days;
- (instancetype)initWithDate: (NSDate*) date;
//-(NSArray*)  getIdFromDate:(NSString*)fromDate toDate:(NSString*)toDate;

@end
