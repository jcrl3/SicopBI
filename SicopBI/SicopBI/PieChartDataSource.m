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
    NSMutableArray* _dataX;
}

- (id)initWithData:(NSMutableArray *)dataX displayYear:(NSString *)year {
    if(self = [super init]) {
        _dataX = dataX;
        _displayYear = year;
    }
    return self;
}
#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
	SChartDonutSeries *series = [SChartDonutSeries new];
	series.selectionAnimation.duration = @(2.0);
	series.selectedStyle.protrusion = 3.f;
	series.selectedPosition = [NSNumber numberWithFloat:(float)(-M_PI/1.f)];
	series.style.chartEffect=SChartRadialChartEffectFlat;//SChartRadialChartEffectRoundedLight; //SChartRadialChartEffectFlat;
	series.style.showLabels=FALSE;
    series.labelFormatString = @"%.0f";
	//Define lines that connect de chart to labels
	series.style.spokeStyle.showSpokes = NO;
	series.selectedStyle.spokeStyle.showSpokes = NO;

	series.animationEnabled = YES;
	series.gesturePanningEnabled = YES;

	//Other properties
	//series.outerRadius = 65.f; //105.f;
	//series.innerRadius = 45.f; //65.f;
	//series.rotation = 10.0f;
    //series.rotationFriction= 10.0f;
    //series.outerRadius = 10.0f;
	
	//Set label fonts
	series.style.labelBackgroundColor =[UIColor colorWithRed:104/255       ///Black tenue
													   green:104/255
												  blue:104/255
													   alpha:1.0 ];
	
	series.style.labelFontColor =[UIColor whiteColor];
	series.style.labelFont = chart.legend.style.font;

	///Set labels configuration
	chart.legend.position = SChartLegendPositionMiddleRight;
	chart.legend.maxSeriesPerLine = 1;
	


	return series;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {

	return _dataX.count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
	SChartRadialDataPoint *datapoint = [SChartRadialDataPoint new];
	NSArray* currentPoint = [_dataX objectAtIndex:dataIndex];
  	datapoint.name = [currentPoint objectAtIndex:0];
	datapoint.value = (NSNumber*)[currentPoint objectAtIndex:1];
	return datapoint;
}

@end
