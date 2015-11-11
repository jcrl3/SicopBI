//
//  BarChartDataSource.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "BarChartDataSource.h"

@implementation BarChartDataSource
{
	NSDictionary* _sales;
}

- (id)initWithData:(NSDictionary *)dataX  {
	if(self = [super init]) {
		_sales = dataX;
	}
	return self;
}

- (NSDictionary*)dataForYear {
	
	NSDictionary* salesForYear = _sales[@"NOV"];
	return salesForYear;
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
	return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
	SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
	columnSeries.title = index == 0 ? @"Nov" : @"2012";
	columnSeries.crosshairEnabled=YES;
	columnSeries.selectionMode = SChartSelectionSeries;

	SChartColumnSeriesStyle *styleBar = [[SChartColumnSeriesStyle alloc] init];
	styleBar.areaColor = [UIColor colorWithRed:88.0/255
										 green:152.0/255
										  blue:254.0/255
										 alpha:1.0 ];
	
	
	styleBar.showAreaWithGradient= false;
	[columnSeries setStyle:styleBar];
	
	return columnSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
//	return _sales.count;
	
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
