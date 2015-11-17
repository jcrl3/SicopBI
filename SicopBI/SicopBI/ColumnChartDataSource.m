//
//  ColumnChartDataSource.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "ColumnChartDataSource.h"

@implementation ColumnChartDataSource{
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
	SChartBarSeries *barSeries = [[SChartBarSeries alloc] init];
	return barSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
	return _dataX.count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
	
	return _dataX[dataIndex];
	/*
	 SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
	 NSDictionary* salesForYear = _dataX;
	 NSLog(@"Punto %ld",(long)dataIndex);
	 NSString* key = salesForYear.allKeys[dataIndex];
	 NSLog(@"Key %@",key);
	 datapoint.xValue = key;
	 datapoint.yValue = salesForYear[key];
	 return datapoint;*/
	
}



@end
