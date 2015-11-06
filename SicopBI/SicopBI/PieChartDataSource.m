//
//  PieChartDataSource.m
//  HandlingSelection
//
//  Created by Colin Eberhardt on 16/07/2013.
//  Copyright (c) 2013 ShinobiControls. All rights reserved.
//

#import "PieChartDataSource.h"

@implementation PieChartDataSource
{
    NSDictionary* _ejecutivos;
}

- (id)initWithSales:(NSDictionary *)ejecutivos displayYear:(NSString *)year {
    if(self = [super init]) {
        _ejecutivos = ejecutivos;
        _displayYear = year;
    }
    return self;
}

- (NSDictionary*)dataForYear {

	NSDictionary* salesForYear = _ejecutivos[self.displayYear];
	NSLog(@"Serie seleccionada %@", self.displayYear);
	
	return salesForYear;
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
	SChartDonutSeries *series = [SChartDonutSeries new];
	series.selectionAnimation.duration = @(0.4);
	series.selectedStyle.protrusion = 10.0f;
	series.selectedPosition = @0.0;
/*
	// Show spokes for default and selected slices
	series.style.spokeStyle.showSpokes = YES;
	series.selectedStyle.spokeStyle.showSpokes = YES;
	// Deselected slice spoke styles
	series.style.spokeStyle.anchorRadius = 2.0f;
	// Selected slice spoke styles
	series.selectedStyle.spokeStyle.anchorColor = [UIColor blueColor];
	series.selectedStyle.spokeStyle.anchorRadius = 5.0f;
	*/
	return series;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
	NSLog(@"Numero de puntos %ld",[self dataForYear].count);
	return [self dataForYear].count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
	SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    NSDictionary* salesForYear = [self dataForYear];
	NSLog(@"Punto %ld",(long)dataIndex);
    NSString* key = salesForYear.allKeys[dataIndex];
	NSLog(@"Key %@",key);
	datapoint.xValue = key;
	datapoint.yValue = salesForYear[key];
	
	
    return datapoint;
}

@end
