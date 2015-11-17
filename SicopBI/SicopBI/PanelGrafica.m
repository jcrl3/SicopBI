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
	
}

@synthesize dataX;
@synthesize dataXLine;
@synthesize typeOfChart;
@synthesize hideLegend;
@synthesize titleGraph;
@synthesize gestDoubleTapEnabled;
@synthesize _chart;
@synthesize viewDelegate;


NSString * const BAR_CHART = @"BAR_CHART";
NSString * const PIE_CHART = @"PIE_CHART";
NSString * const LINE_CHART = @"LINE_CHART";
NSString * const COLUMN_CHART = @"COLUMN_CHART";


- (instancetype)init
{
	self = [super init];
	if (self) {

	}
	return self;
}

-(void) viewDidAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	if (typeOfChart==nil) {
		typeOfChart=BAR_CHART;
	}
	
	[self cofigureChart];
	
	if ([typeOfChart isEqualToString:BAR_CHART]){
		_barChartDataSource = [[BarChartDataSource alloc] initWithData:dataX];
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
	_chart.delegate=self.viewDelegate;
	[self.spin stopAnimating];

}

#pragma mark -
#pragma mark - Configurador de las graficas

-(void) cofigureChart{
	_chart = [[ShinobiChart alloc] initWithFrame:[self getFrame]];
	_chart.licenseKey = [PropiedadesGraficas getLicence];
	_chart.legend.hidden = self.hideLegend;
	_chart.title = self.titleGraph;
	_chart.gestureDoubleTapEnabled = self.gestDoubleTapEnabled;
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;

	_chart.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.canvasAreaBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	_chart.borderColor = [UIColor whiteColor];
	_chart.plotAreaBackgroundColor = [UIColor whiteColor];
	_chart.plotAreaBorderColor = [UIColor blueColor];
	
	_chart.opaque=NO;
	
	_chart.legend.backgroundColor =  [UIColor whiteColor];

	_chart.titlePosition = SChartTitlePositionBottomOrLeft;

	
	//Controlamos el zoom
	/*
	_chart.xAxis.enableGestureZooming = YES;
	_chart.xAxis.enableGesturePanning = YES;
	_chart.gesturePinchAspectLock = YES;
	_chart.xAxis.enableMomentumPanning = YES;
	_chart.xAxis.enableMomentumZooming = YES;*/
	
	//agregramos el botón que expande el view
    UIButton* expandButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-27.0, 2.0, 24.0, 24.0)];
	[expandButton addTarget:self
			   action:@selector(expandGraph:)
	 forControlEvents:UIControlEventTouchUpInside];
	expandButton.tag  = 1;
	expandButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	expandButton.opaque=NO;
	[expandButton setTintColor:[UIColor blueColor]];
	[expandButton setImage:[UIImage imageNamed:@"Expand"] forState:UIControlStateNormal];
	[_chart addSubview:expandButton];
}

-(CGRect) getFrame{
	CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 20.0 : 50.0;
	return CGRectMake(1.0, margin, self.view.bounds.size.width-3.0, self.view.bounds.size.height-margin);
}

#pragma mark -
#pragma mark - Procedimientos que generan las graficas

-(void)createBarChart {
	
	    SChartCategoryAxis* xAxis =[self setDataXSeries:@"Fecha" interSeriesPadding:@0];
     	_chart.xAxis = xAxis;

     	SChartAxis* yAxis = [self setDataYSeries:@"" interSeriesPadding:@1.0];
		_chart.yAxis = yAxis;
	
		// enable gestures
		xAxis.enableGesturePanning = YES;
		xAxis.enableGestureZooming = YES;
		yAxis.enableGesturePanning = YES;
		yAxis.enableGestureZooming = YES;

	
		// add to the view
		[self.view addSubview:_chart];
		_chart.datasource = _barChartDataSource;
		_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
		
	}


#pragma mark -
#pragma mark - Grafica de Pie

- (void)createPieChart{
	
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	// add to the view
	[self.view addSubview:_chart];
	_chart.datasource = _pieChartDataSource;
}

#pragma mark -
#pragma mark - Grafica de columnas

-(void)createColumnChart {
	
	SChartCategoryAxis* xAxis =[self setDataXSeries:@"Fecha" interSeriesPadding:@0];
	_chart.xAxis = xAxis;
	
	SChartAxis* yAxis = [self setDataYSeries:@"" interSeriesPadding:@1.0];
	_chart.yAxis = yAxis;
	
	// enable gestures
	xAxis.enableGesturePanning = YES;
	xAxis.enableGestureZooming = YES;
	yAxis.enableGesturePanning = YES;
	yAxis.enableGestureZooming = YES;
	
	
	// add to the view
	[self.view addSubview:_chart];
	_chart.datasource = _columnChartDataSource;
	_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
	
}


#pragma mark -
#pragma mark - Grafica de lineas

- (void)createLineChart{
//	SChartDiscontinuousDateTimeAxis *xAxis = [[SChartDiscontinuousDateTimeAxis alloc] init];
	
	SChartDateTimeAxis *xAxis =[[SChartDateTimeAxis alloc] init];
	/*
	// a time period that defines the weekends
	SChartRepeatedTimePeriod* weekends = [[SChartRepeatedTimePeriod alloc] initWithStart:[self dateFromString:@"01-11-2015"]
																			   andLength:[SChartDateFrequency dateFrequencyWithDay:1]
																			andFrequency:[SChartDateFrequency dateFrequencyWithWeekOfMonth:0]];
	

	
	[xAxis addExcludedRepeatedTimePeriod:weekends];*/
	xAxis.title = @"Fecha";
	_chart.xAxis = xAxis;
	
	SChartAxis* yAxis = [self setDataYSeries:@"Registros" interSeriesPadding:@1.0];
	yAxis = (SChartNumberAxis*)yAxis;  //Hacemos el doowncast
	_chart.yAxis = yAxis;
	
	// enable gestures
	yAxis.enableGesturePanning = YES;
	yAxis.enableGestureZooming = YES;
	xAxis.enableGesturePanning = YES;
	xAxis.enableGestureZooming = YES;
	
	// add to the view
	[self.view addSubview:_chart];
	_chart.datasource = _lineChartDataSource;

}

#pragma mark -
#pragma mark - Procedimientos que establecen los valores de los ejes

-(SChartCategoryAxis*)setDataXSeries:(NSString*) pTitle interSeriesPadding:(NSNumber*)pinterSeriesPadding  {
	SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
	xAxis.style.interSeriesPadding = @0;
	xAxis.title = @"Fecha";
	
    return xAxis;
}

-(SChartAxis*) setDataYSeries:(NSString*) pTitle interSeriesPadding:(NSNumber*)pinterSeriesPadding {
	SChartAxis *yAxis = [[SChartNumberAxis alloc] init];
	yAxis.title = pTitle;
	yAxis.rangePaddingHigh = pinterSeriesPadding;
	return yAxis;


}


#pragma mark -
#pragma mark - Procedimiento que expande la gtrafica
- (void)expandGraph:(id)sender {
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	ExpandGraphViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GraficaExpandida"];
	vc.chart = self._chart.getChart;
	UIView *viewBtn = [vc.chart viewWithTag:1];
	viewBtn.hidden=YES;
	[self  presentViewController:vc animated:YES completion:nil];
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
