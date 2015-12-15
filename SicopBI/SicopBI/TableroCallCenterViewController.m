//
//  TableroCallCenter.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 08/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TableroCallCenterViewController.h"

@implementation TableroCallCenterViewController{
	NSDictionary* _sales;
	NSDictionary* _ejecutivos;
	
	ShinobiChart* _chart;
	BarChartDataSource* _barChartDataSource;
	
	ShinobiChart* _pieChart;
	PieChartDataSource* _pieChartDataSource;

}

-(void) viewDidLoad{
	
	_sales =  @{@"NOV": @{@"1" : @5.1, @"2" : @12.1, @"3" : @8.1, @"4" : @4.1, @"5" : @6.1, @"6" : @8.1}};
	//_ejecutivos = @{@"NOV":@{@"Juan" : @4.1, @"Ricardo" : @4.1}};
	_ejecutivos = @{@"NOV":@{@"Juan Carlos" : @4.0, @"Marilu" : @5.0, @"Ricardo" : @4.0, @"Yamil" : @1.0, @"German" : @1.0, @"Carlos" : @1.0}};
	
	//Creamos los datasource de los charts
//	_barChartDataSource = [[BarChartDataSource alloc] initWithSales:_sales];
//	_pieChartDataSource = [[PieChartDataSource alloc] initWithSales:_ejecutivos displayYear:@"NOV"];

	[self createBarChar:CGRectMake(1.0, 5.0, self.scrollView.bounds.size.width-1.0, 200.0)];
	[self createPieChart:CGRectMake(1.0, 208.0, self.scrollView.bounds.size.width-1.0, 200.0)];

}
- (void)createPieChart:(CGRect)frame {
		// Create the chart
		//CGFloat margin = 10.0;
		//	_pieChart = [[ShinobiChart alloc] initWithFrame:CGRectInset(frame, margin, margin)];
		_pieChart = [[ShinobiChart alloc] initWithFrame:frame];
		
		_pieChart.canvasAreaBackgroundColor = [UIColor whiteColor];
		_pieChart.backgroundColor = [UIColor whiteColor];
		_pieChart.autoresizingMask =  ~UIViewAutoresizingNone;
		
		_pieChart.licenseKey = [PropiedadesGraficas getLicence];
		
		// add to the view
		[self.scrollView addSubview:_pieChart];
		
		_pieChart.datasource = _pieChartDataSource;
		
		// show the legend
		_pieChart.legend.hidden = NO;
	}
	
	
	-(void)createBarChar:(CGRect)frame {
		//	CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 20.0 : 50.0;
		
		_chart = [[ShinobiChart alloc] initWithFrame:frame];
		_chart.canvasAreaBackgroundColor = [UIColor whiteColor];
		_chart.backgroundColor = [UIColor whiteColor];
		_chart.legend.backgroundColor =  [UIColor whiteColor];
		_chart.borderColor = [UIColor whiteColor];
		_chart.titlePosition = SChartTitlePositionBottomOrLeft;
		_chart.title = @"Callcenter";
		
		
		SChartTheme *chartTheme = [SChartLightTheme new];
		[_chart applyTheme: chartTheme];
		
		_chart.gestureManager.doubleTapEnabled=NO;
		_chart.autoresizingMask =  ~UIViewAutoresizingNone;
		
		_chart.licenseKey = [PropiedadesGraficas getLicence]; // TODO: add your trial licence key here!
		
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
		[self.scrollView addSubview:_chart];
		
		_chart.datasource = _barChartDataSource;
		_chart.delegate = self;
		
		// show the legend
		_chart.legend.hidden = YES;
		_chart.legend.placement = SChartLegendPlacementOnPlotAreaBorder;
		
	}
	
	
#pragma mark -
#pragma mark  maneno de la barra seleccionada
	-(void)sChart:(ShinobiChart *)chart toggledSelectionForSeries:(SChartSeries *)series nearPoint:(SChartDataPoint *)dataPoint atPixelCoordinate:(CGPoint)pixelPoint {
		// determine which year was tapped
		//NSString* tappedYear = (NSString*)dataPoint.xValue;
		_pieChartDataSource.displayYear = @"NOV";
		_pieChart.title = [NSString stringWithFormat:@"Ventas del día %@", dataPoint.xValue];
		//[self updatePieTitle];
		[_pieChart reloadData];
		[_pieChart redrawChart];
		
	}
	
	- (void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
	}

	

@end
