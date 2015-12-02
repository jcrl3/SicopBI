//
//  LineChartDataSource.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "LineChartDataSource.h"

@implementation LineChartDataSource{
	NSMutableArray * _dataX;
}

- (id)initWithData:(NSMutableArray *)dataX  {
	if(self = [super init]) {
		_dataX = dataX;

	}
	return self;
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
	return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
	SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
	lineSeries.crosshairEnabled=YES;
	lineSeries.style.lineWidth=@(5.0);  //@(2.0); [NSNumber numberWithInt:];
	SChartLineSeriesStyle *styleBar = [[SChartLineSeriesStyle alloc] init];
	styleBar.lineColor = [UIColor colorWithRed:88.0/255
										 green:152.0/255
										  blue:254.0/255
										 alpha:0.95 ];
	
	styleBar.lineWidth=@(3.0);
	[lineSeries setStyle:styleBar];

	
	return lineSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
	return _dataX.count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
	/*
	SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
	datapoint = _dataX[dataIndex];
	datapoint.xValue=[NSString stringWithFormat:@"%ld", (long)dataIndex+1];
	*/
	/*NSDictionary* salesForYear = [self dataForYear];
	 NSLog(@"Punto %ld",(long)dataIndex);
	 NSString* key = salesForYear.allKeys[dataIndex];
	 NSLog(@"Key %@",key);
	 datapoint.xValue = key;
	 datapoint.yValue = salesForYear[key];*/
	return _dataX[dataIndex];
	

}


@end
