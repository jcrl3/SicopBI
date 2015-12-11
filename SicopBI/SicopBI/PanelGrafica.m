//
//  PanelGrafica.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "PanelGrafica.h"

@implementation PanelGrafica{
	BarChartDataSource* _barChartDataSource;
	PieChartDataSource* _pieChartDataSource;
	LineChartDataSource* _lineChartDataSource;
	ColumnChartDataSource* _columnChartDataSource;
	NSString *fontName;


	
}

@synthesize dataX;
@synthesize dataXLine;
@synthesize typeOfChart;
@synthesize hideLegend;
@synthesize titleGraph;
@synthesize yTitle;
@synthesize xTitle;
@synthesize yFormatString;
@synthesize xFormatString;
@synthesize formatString;
@synthesize gestDoubleTapEnabled;
@synthesize _chart;
@synthesize labelBottomDonut;
@synthesize labelCenterDonut;
@synthesize viewDelegate;


NSString * const BAR_CHART = @"BAR_CHART";
NSString * const PIE_CHART = @"PIE_CHART";
NSString * const LINE_CHART = @"LINE_CHART";
NSString * const COLUMN_CHART = @"COLUMN_CHART";

NSString * const FORMAT_DATE=@"FORMAT_DATE";
NSString * const FORMAT_NUMBER=@"FORMAT_NUMBER";
NSString * const FORMAT_STRING=@"FORMAT_STRING";


- (instancetype)init
{
	self = [super init];
	if (self) {
        self.titleGraph=@"";
		self.yTitle=@"";
		self.xTitle=@"";
	}
	return self;
}

-(void) viewDidAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	if (self.typeOfChart==nil) {
		self.typeOfChart=BAR_CHART;
		self.yFormatString=@"%d";
	}
	
	[self cofigureChart];
	
	if ([typeOfChart isEqualToString:BAR_CHART]){
		_barChartDataSource = [[BarChartDataSource alloc] initWithData:dataXLine];
	   [self createBarChart];
	}

	if ([typeOfChart isEqualToString:PIE_CHART]){
		_pieChartDataSource = [[PieChartDataSource alloc] initWithData:dataXLine displayYear:@"NOV"];
		[self createPieChart];
	}

	if ([typeOfChart isEqualToString:LINE_CHART]){
		_lineChartDataSource = [[LineChartDataSource alloc] initWithData:dataXLine];
		[self createLineChart];
	}

	if ([typeOfChart isEqualToString:COLUMN_CHART]){
		_columnChartDataSource = [[ColumnChartDataSource alloc] initWithData:dataXLine];
		[self createColumnChart];

	}

	//adding the chart to subview
	[self.viewContainer addSubview:self._chart];
    _chart.translatesAutoresizingMaskIntoConstraints=YES;
	[self setChartConstraints];
	_chart.delegate=self.viewDelegate;

	[self.spin stopAnimating];

}

#pragma mark -
#pragma mark - Configurador de las graficas

-(void) cofigureChart{
	//Set the font
///	UIColor *darkGrayColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	 fontName= [PropiedadesGraficas getFontName];
	
	_chart = [[ShinobiChart alloc] initWithFrame:[self getFrame]];
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	_chart.animateBoxGesture=YES;

	//Set area colors properties
	_chart.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.canvasAreaBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.borderColor = [UIColor whiteColor];
	_chart.plotAreaBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0]; //[UIColor whiteColor];
	_chart.plotAreaBorderColor = [UIColor clearColor];
	_chart.borderThickness = @0.f;
	_chart.opaque=YES;
	
	//Configure legends properties
	_chart.legend.hidden = self.hideLegend;
	_chart.legend.backgroundColor =  [UIColor whiteColor];
	_chart.legend.style.font=[UIFont fontWithName:fontName size:8.f];
	_chart.legend.style.borderColor=[UIColor clearColor];
	_chart.legend.style.titleFontColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	_chart.legend.style.fontColor= [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	_chart.legend.style.borderWidth = 0;
	_chart.legend.style.textAlignment=NSTextAlignmentRight;
	_chart.titlePosition = SChartTitlePositionBottomOrLeft;
	
	//Set the title properties
	_chart.title = self.titleGraph;
	_chart.titleLabel.font =  [UIFont fontWithName:fontName size:16.f];
	_chart.titleLabel.textColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];  //dr
	_chart.crosshair = self.viewDelegate;


	//Set crosshair style
	SChartCrosshairStyle *styleCrossHair = [[SChartCrosshairStyle alloc]init];
	styleCrossHair.defaultBackgroundColor = [UIColor blackColor];
	styleCrossHair.defaultTextColor = [UIColor whiteColor];
	styleCrossHair.defaultCornerRadius = @10.0;
	styleCrossHair.defaultFont =[UIFont fontWithName:fontName size:18.f];
	SChartCrosshair *customCrosshair =[[SChartCrosshair alloc] initWithChart:_chart];
	customCrosshair.style= styleCrossHair;
	_chart.crosshair = customCrosshair;
	
	//Set the gestures
	_chart.gestureDoubleTapEnabled = self.gestDoubleTapEnabled;

}

-(CGRect) getFrame{
	return CGRectMake(self.viewContainer.bounds.origin.x+10,
					  self.viewContainer.bounds.origin.y+10,
					  self.viewContainer.bounds.size.width-20,
					  self.viewContainer.bounds.size.height-20);
}

#pragma mark -
#pragma mark - Procedimientos que generan las graficas

-(void)createBarChart {
	NSObject *xAxis;

	xAxis = [self getAxisDef];
	[self formatDataXSeries:(SChartAxis*)xAxis title:self.title interSeriesPadding: @0];
	_chart.xAxis = (SChartAxis*)xAxis;
	
	SChartAxis* yAxis = [self setDataYSeries:self.yTitle interSeriesPadding:@1.0];
	_chart.yAxis = yAxis;
	
	_chart.datasource = _barChartDataSource;
	_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
	
}

-(void) setChartConstraints{
//Top
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_chart
																  attribute:NSLayoutAttributeTop
																  relatedBy:NSLayoutRelationEqual
																	 toItem:self.viewContainer
																  attribute:NSLayoutAttributeTop multiplier:1.0f constant:1.f];
	
	[self.viewContainer addConstraint:constraint];
	
	
//Bottom
	 constraint = [NSLayoutConstraint constraintWithItem:_chart
																  attribute:NSLayoutAttributeBottom
																  relatedBy:NSLayoutRelationEqual
																	 toItem:self.viewContainer
																  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-1.f];
	
	[self.viewContainer addConstraint:constraint];
	
	
//Left margin
	constraint = [NSLayoutConstraint constraintWithItem:_chart
											  attribute:NSLayoutAttributeLeft
											  relatedBy:NSLayoutRelationEqual
												 toItem:self.viewContainer
											  attribute:NSLayoutAttributeLeft multiplier:1.0f constant:1.f];
	
	[self.viewContainer addConstraint:constraint];
	
	
//rigth margin
	constraint = [NSLayoutConstraint constraintWithItem:_chart
											  attribute:NSLayoutAttributeRight
											  relatedBy:NSLayoutRelationEqual
												 toItem:self.viewContainer
											  attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1.f];
	
	[self.viewContainer addConstraint:constraint];
	
	

}

#pragma mark -
#pragma mark - Grafica de Pie

- (void)createPieChart{
	
	CGRect plotChart = [_chart chartFrame];
	
	///label for titles
    self.labelBottomDonut = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, plotChart.size.height-20, plotChart.size.width/2, 10)];
	self.labelBottomDonut.font = [UIFont fontWithName:fontName size:8.f];
	self.labelBottomDonut.textColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	self.labelBottomDonut.backgroundColor = [UIColor clearColor];
	self.labelBottomDonut.textAlignment=NSTextAlignmentLeft;
	self.labelBottomDonut.text = @"";
	self.labelBottomDonut.adjustsFontSizeToFitWidth = YES;
	self.labelBottomDonut.tag = 1;
	self.labelBottomDonut.translatesAutoresizingMaskIntoConstraints=NO;
	[_chart addSubview:self.labelBottomDonut];
	
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.labelBottomDonut
									attribute:NSLayoutAttributeBottom
									relatedBy:NSLayoutRelationEqual
									toItem:_chart
									attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-10.f];
	
	[_chart addConstraint:constraint];

	constraint = [NSLayoutConstraint constraintWithItem:self.labelBottomDonut
											  attribute:NSLayoutAttributeLeft
											  relatedBy:NSLayoutRelationEqual
												 toItem:_chart
											  attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.f];
	
	[_chart addConstraint:constraint];

	///label for numbers
	self.labelCenterDonut = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, plotChart.size.height-30, plotChart.size.width/2, 10)];
	self.labelCenterDonut.font = [UIFont fontWithName:fontName size:8.f];
	self.labelCenterDonut.textColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	self.labelCenterDonut.backgroundColor = [UIColor clearColor];
	self.labelCenterDonut.textAlignment=NSTextAlignmentLeft;
	self.labelCenterDonut.text = @"";
	self.labelCenterDonut.adjustsFontSizeToFitWidth = YES;
	self.labelCenterDonut.tag = 2;

	self.labelCenterDonut.translatesAutoresizingMaskIntoConstraints=NO;
	
//	[self.viewContainer addSubview:self.labelCenterDonut];
	[_chart addSubview:self.labelCenterDonut];
	
	
	constraint = [NSLayoutConstraint constraintWithItem:self.labelCenterDonut
											  attribute:NSLayoutAttributeBottom
											  relatedBy:NSLayoutRelationEqual
												 toItem:_chart
											  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20.f];
	
	[_chart addConstraint:constraint];
	
	constraint = [NSLayoutConstraint constraintWithItem:self.labelCenterDonut
											  attribute:NSLayoutAttributeLeft
											  relatedBy:NSLayoutRelationEqual
												 toItem:_chart
											  attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.f];
	
	[_chart addConstraint:constraint];
	
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(legendClick:)];
	[_chart.legend addGestureRecognizer:tap];

//	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	_chart.datasource = _pieChartDataSource;
}

- (void)legendClick:(UITapGestureRecognizer*)sender {
	
	CGPoint tapPoint = [sender locationInView:_chart.legend];
	SChartPieSeries *series = [_chart series][0];
	
	int selectedIndex = -1;
	
	// Find the item (if any) that we hit in the legend click
	for (int i=0; i < _chart.legend.symbols.count; i++) {
		
		CGRect symbolFrame = [_chart.legend.symbols[i] frame];
		CGRect legendFrame = [_chart.legend.labels[i] frame];
		
		if (CGRectContainsPoint(symbolFrame , tapPoint) || CGRectContainsPoint(legendFrame, tapPoint)) {
			selectedIndex = i;
			break;
		}
	}
	
	if (selectedIndex != -1) {
		// Find the datapoint corresponding to the selected legend item
		SChartDataPoint *dp = series.dataSeries.dataPoints[selectedIndex];
		BOOL selected = !dp.selected;
		
		// Animate the slice selection
		[series setSlice:selectedIndex asSelected:selected];
	}
}
#pragma mark -
#pragma mark - Grafica de columnas

-(void)createColumnChart {
	
	//SChartCategoryAxis* xAxis =[self setDataXSeries:self.xTitle interSeriesPadding:@0];
   //_chart.xAxis = xAxis;
	
	NSObject *xAxis;
	xAxis = [self getAxisDef];
	[self formatDataXSeries:(SChartAxis*)xAxis title:self.title interSeriesPadding: @0];
	_chart.xAxis = (SChartAxis*)xAxis;

	
	SChartAxis* yAxis = [self setDataYSeries:self.yTitle interSeriesPadding:@1.0];
	_chart.yAxis = yAxis;
	
	_chart.datasource = _columnChartDataSource;
	_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
	
}


#pragma mark -
#pragma mark - Grafica de lineas

- (void)createLineChart{
//	SChartDiscontinuousDateTimeAxis *xAxis = [[SChartDiscontinuousDateTimeAxis alloc] init];

	//SChartDateTimeAxis *xAxis =[[SChartDateTimeAxis alloc] init];
	/*
	// a time period that defines the weekends
	SChartRepeatedTimePeriod* weekends = [[SChartRepeatedTimePeriod alloc] initWithStart:[self dateFromString:@"01-11-2015"]
																			   andLength:[SChartDateFrequency dateFrequencyWithDay:1]
																			andFrequency:[SChartDateFrequency dateFrequencyWithWeekOfMonth:0]];
	

	
	[xAxis addExcludedRepeatedTimePeriod:weekends];*/
	//SChartAxis* xAxis = [self setDataXSeries:self.xTitle interSeriesPadding:@1.0];
	//xAxis = (SChartDateTimeAxis*)xAxis;

    NSObject *xAxis;
	xAxis = [self getAxisDef];
	[self formatDataXSeries:(SChartAxis*)xAxis title:self.title interSeriesPadding: @0];
	_chart.xAxis = (SChartAxis*)xAxis;
	
	
	///Set Y Axis Properties
	SChartAxis* yAxis = [self setDataYSeries:self.yTitle interSeriesPadding:@1.0];
	yAxis = (SChartNumberAxis*)yAxis;  //Hacemos el doowncast
	_chart.yAxis = yAxis;
	
	_chart.datasource = _lineChartDataSource;

}

#pragma mark -
#pragma mark - Procedimientos que establecen los valores de los ejes
-(NSObject*) getAxisDef{
    NSObject *xAxis;
	if ([self.xFormatString isEqualToString:FORMAT_DATE]){
		
		xAxis = [[NSClassFromString(@"SChartDateTimeAxis") alloc] init];
		((SChartDateTimeAxis*)xAxis).labelFormatString =self.formatString;
		((SChartDateTimeAxis*)xAxis).majorTickFrequency = [[SChartDateFrequency alloc] initWithDay:3];
		
	}else if ([self.xFormatString isEqualToString:FORMAT_NUMBER]){
		
		xAxis = [[NSClassFromString(@"SChartNumberAxis") alloc] init];
		((SChartNumberAxis*)xAxis).labelFormatString =self.formatString;
		
	}else{
		xAxis = [[NSClassFromString(@"SChartCategoryAxis") alloc] init];
	}
 return xAxis;
}

#pragma mark -
#pragma mark - Procedimientos que formatean los valores de los ejes

-(void)formatDataXSeries:(SChartAxis*)xAxis  title:(NSString*) pTitle   interSeriesPadding:(NSNumber*)pinterSeriesPadding  {
	xAxis.style.titleStyle.font = [UIFont fontWithName:fontName size:10.f];
	xAxis.style.titleStyle.textColor = [UIColor blackColor];
	xAxis.style.interSeriesPadding = @0;
	xAxis.title = pTitle;
	xAxis.enableGesturePanning = YES;
	xAxis.enableGestureZooming = YES;
}

-(SChartCategoryAxis*)setDataXSeries:(NSString*) pTitle interSeriesPadding:(NSNumber*)pinterSeriesPadding  {
	SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
	xAxis.style.titleStyle.font = [UIFont fontWithName:fontName size:10.f];
	xAxis.style.titleStyle.textColor = [UIColor blackColor];
	xAxis.style.interSeriesPadding = @0;
	xAxis.title = pTitle;
	xAxis.enableGesturePanning = YES;
	xAxis.enableGestureZooming = YES;
	

    return xAxis;
}

-(SChartAxis*) setDataYSeries:(NSString*) pTitle interSeriesPadding:(NSNumber*)pinterSeriesPadding {
	SChartAxis *yAxis = [[SChartNumberAxis alloc] init];
	yAxis.title = pTitle;
	yAxis.rangePaddingHigh = pinterSeriesPadding;
	yAxis.style.majorGridLineStyle.showMajorGridLines =YES;
	yAxis.style.majorGridLineStyle.dashedMajorGridLines=YES;
	yAxis.style.majorGridLineStyle.lineWidth=@1.0;
	yAxis.style.majorGridLineStyle.lineColor = [UIColor grayColor];
	yAxis.style.majorGridLineStyle.dashStyle= [[NSArray alloc] initWithObjects:@1.5, nil];
	yAxis.style.titleStyle.font = [UIFont fontWithName:fontName size:10.f];
	yAxis.style.titleStyle.textColor = [UIColor blackColor];
	yAxis.style.majorTickStyle.labelFont = [UIFont fontWithName:fontName size:8.f];
	yAxis.style.minorTickStyle.labelFont= [UIFont fontWithName:fontName size:8.f];
	//yAxis.style.majorTickStyle.lineColor =  [UIColor redColor];
	yAxis.enableGesturePanning = YES;
	yAxis.enableGestureZooming = YES;
	return yAxis;
}


#pragma mark -
#pragma mark - Procedimiento que expande la gtrafica

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"ExpandGraph"]){
		ExpandGraphViewController *vc = [segue destinationViewController];
		vc.chart = self._chart.getChart;
		vc.data = [self.dataXLine copy];
		UIView *viewBtn = [vc.chart viewWithTag:1];
		viewBtn.hidden=YES;
	}
	
}

#pragma mark -
#pragma mark - Formateo de fecha a partir de un string
- (NSDate*) dateFromString:(NSString*)date {
	static NSDateFormatter *dateFormatter;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	}
	return [dateFormatter dateFromString:date];
}



@end
