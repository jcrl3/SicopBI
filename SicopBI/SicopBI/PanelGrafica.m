//
//  PanelGrafica.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "PanelGrafica.h"

@implementation PanelGrafica{

	//NSDictionary* _ejecutivos;
	
	///ShinobiChart* _pieChart;

	BarChartDataSource* _barChartDataSource;
	PieChartDataSource* _pieChartDataSource;
}

@synthesize dataX;
@synthesize typeOfChart;
@synthesize hideLegend;
@synthesize titleGraph;
@synthesize gestDoubleTapEnabled;
@synthesize _chart;
@synthesize viewDelegate;


NSString * const BAR_CHART = @"BAR_CHART";
NSString * const PIE_CHART = @"PIE_CHART";

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
	   [self createBarChar];
	}

	if ([typeOfChart isEqualToString:PIE_CHART]){
		_pieChartDataSource = [[PieChartDataSource alloc] initWithData:dataX displayYear:@"NOV"];
		[self createPieChart];
	}
	
	_chart.delegate=(NSObject*)self.viewDelegate;
	[self.spin stopAnimating];

}

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
	_chart.xAxis.enableGestureZooming = YES;
	_chart.xAxis.enableGesturePanning = YES;
	_chart.gesturePinchAspectLock = YES;
	_chart.xAxis.enableMomentumPanning = YES;
	_chart.xAxis.enableMomentumZooming = YES;
	
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
	return CGRectMake(1.0, 5.0, self.view.bounds.size.width-3.0, self.view.bounds.size.height-10);
}

-(void)createBarChar {
		//	CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 20.0 : 50.0;

	   /*
		SChartTheme *chartTheme = [SChartLightTheme new];
		[_chart applyTheme: chartTheme];
		*/
	
	   // add a pair of axes
		SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
		xAxis.style.interSeriesPadding = @0;
		xAxis.title = @"Fecha";
		_chart.xAxis = xAxis;
		
		SChartAxis *yAxis = [[SChartNumberAxis alloc] init];
		yAxis.title = @"";
		yAxis.rangePaddingHigh = @1.0;
		_chart.yAxis = yAxis;
		
		
		// add to the view
		[self.view addSubview:_chart];
		_chart.datasource = _barChartDataSource;
		_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
		
	}

- (void)createPieChart{
	
	// Create the chart
	//CGFloat margin = 10.0;
	//	_pieChart = [[ShinobiChart alloc] initWithFrame:CGRectInset(frame, margin, margin)];

	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	// add to the view
	[self.view addSubview:_chart];
	_chart.datasource = _pieChartDataSource;
}

- (void)expandGraph:(id)sender {
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	ExpandGraphViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"GraficaExpandida"];
	vc.chart = self._chart.getChart;
	UIView *viewBtn = [vc.chart viewWithTag:1];
	viewBtn.hidden=YES;
	
	//[[self navigationController] presentViewController:vc animated:YES completion:nil];
//	vc.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
	[self  presentViewController:vc animated:YES completion:nil];
}


@end
