//
//  PropiedadesGraficas.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 08/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "PropiedadesGraficas.h"

@interface PropiedadesGraficas ()

@end


@implementation PropiedadesGraficas
{

}

+(NSString*) getLicence{
	NSString *licence;
	NSArray *dataPlist = [Plist getArrayFromPlist:@"InfoGraphics" Section:@"ShinobiLicence"];
	licence = [dataPlist objectAtIndex:0];
	return licence;
	
}


@end
