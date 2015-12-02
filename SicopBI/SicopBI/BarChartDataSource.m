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
	NSMutableArray* _dataX;
}

- (id)initWithData:(NSMutableArray *)dataX  {
	if(self = [super init]) {
		_dataX = dataX;
	}
	return self;
}

- (NSMutableArray*)dataForYear {
	
	NSMutableArray* salesForYear = _dataX;//_sales[@"NOV"];
	return salesForYear;
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
	return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
	SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
	columnSeries.crosshairEnabled=YES;
	columnSeries.animationEnabled = YES;
	columnSeries.selectionMode = SChartSelectionPoint;

	
	columnSeries.selectedStyle.showArea=TRUE;
	columnSeries.selectedStyle.areaColor = [UIColor redColor];
	columnSeries.selectedStyle.areaColorGradient= [UIColor redColor];
	
	SChartColumnSeriesStyle *styleBar = [[SChartColumnSeriesStyle alloc] init];
	styleBar.areaColor = [UIColor colorWithRed:88.0/255
										 green:152.0/255
										  blue:254.0/255
										 alpha:0.95 ];
	
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
	/*SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
	datapoint = _sales[dataIndex];
	datapoint.xValue=[NSString stringWithFormat:@"%ld", (long)dataIndex+1];
	
	return datapoint;*/

	return _dataX[dataIndex];
}

- (void)supplementStyleFromStyle:(SChartTitleStyle *)style{
	style.textColor = [UIColor greenColor];
}


@end
