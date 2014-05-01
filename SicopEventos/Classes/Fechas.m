//
//  Utilerias.m
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 02/07/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Fechas.h"

@implementation Fechas
NSDateFormatter* formatter;

-(NSDate*) getFechaDeString:(NSString*) pStringFecha{
   NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
   
   
   NSDateComponents *dateComponent = [calendar components:NSYearCalendarUnit
                                      |NSMonthCalendarUnit
                                      |NSDayCalendarUnit 
                                       fromDate:[formatter dateFromString:pStringFecha]];
   
   
   NSString* ano=[pStringFecha substringWithRange:NSMakeRange(0, 4)];
   NSString* mes=[pStringFecha substringWithRange:NSMakeRange(5, 2)];
   NSString* dia=[pStringFecha substringWithRange:NSMakeRange(8, 2)];
   
   [dateComponent setMonth: [mes intValue]];
   [dateComponent setDay: [dia intValue]];
   [dateComponent setYear: [ano intValue]];
   
   NSDate* fechaRetorno= [[[NSDate alloc] init] autorelease];
   fechaRetorno  = [calendar dateFromComponents:dateComponent];
   
   return fechaRetorno;
}

-(NSDate*) getFechaDeHoy{
   
   NSDate *hoy = [NSDate date];
   NSString *dateString = [formatter stringFromDate:hoy];
   hoy = [formatter dateFromString:dateString];
   return hoy;
}

-(Fechas*) init{
	[super init];   
   formatter = [[NSDateFormatter alloc] init] ;
   [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
   [formatter setDateFormat:@"MM-dd-yyyy"];
   return self ;
}


-(void) dealloc{
   [super dealloc];
   [formatter release];   

}
@end
