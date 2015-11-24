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
		_pieChartDataSource = [[PieChartDataSource alloc] initWithData:dataX displayYear:@"NOV"];
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
	//[self.view addSubview:_chart];
	[self.viewContainer addSubview:self._chart];
	_chart.delegate=self.viewDelegate;
	[self.spin stopAnimating];

}

#pragma mark -
#pragma mark - Configurador de las graficas

-(void) cofigureChart{
	//Set the font
	 fontName= [PropiedadesGraficas getFontName];
	
	_chart = [[ShinobiChart alloc] initWithFrame:[self getFrame]];
	_chart.licenseKey = [PropiedadesGraficas getLicence];
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	_chart.animateBoxGesture=YES;

	//Set area colors properties
	_chart.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.canvasAreaBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.borderColor = [UIColor whiteColor];
	_chart.plotAreaBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0]; //[UIColor whiteColor];
	_chart.plotAreaBorderColor = [UIColor redColor];
	_chart.borderThickness = @0.f;
	_chart.opaque=NO;
	
	//Configure legends properties
	_chart.legend.hidden = self.hideLegend;
	_chart.legend.backgroundColor =  [UIColor whiteColor];
	_chart.legend.style.font=[UIFont fontWithName:fontName size:10.f];
	_chart.legend.style.borderColor=[UIColor clearColor];
	_chart.titlePosition = SChartTitlePositionBottomOrLeft;
	
	
	//Set the title properties
	_chart.title = self.titleGraph;
	_chart.titleLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	_chart.titleLabel.font =  [UIFont fontWithName:fontName size:14.f];
	_chart.titleLabel.textColor = [UIColor blackColor];


	//Set the gestures
	_chart.gestureDoubleTapEnabled = self.gestDoubleTapEnabled;

}

-(CGRect) getFrame{
	//CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 20.0 : 50.0;
	//return CGRectMake(1.0, margin, self.viewContainer.bounds.size.width-3.0, self.view.bounds.size.height-margin);
	
	
	return CGRectMake(self.viewContainer.bounds.origin.x+10, self.viewContainer.bounds.origin.y+10, self.viewContainer.bounds.size.width-20, self.viewContainer.bounds.size.height-20);

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


#pragma mark -
#pragma mark - Grafica de Pie

- (void)createPieChart{
	
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	_chart.datasource = _pieChartDataSource;
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
- (void)expandGraph:(id)sender {
/*
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	ExpandGraphViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GraficaExpandida"];
	vc.chart = self._chart.getChart;
	UIView *viewBtn = [vc.chart viewWithTag:1];
	viewBtn.hidden=YES;
	[self  presentViewController:vc animated:YES completion:nil];
	*/
	
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"ExpandGraph"]){
//		NSString* titleNextView = [listaTableros objectAtIndex:[selectedRowIndex row]];
		ExpandGraphViewController *vc = [segue destinationViewController];
		vc.chart = self._chart.getChart;
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
