//
//  TableroVentasViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TableroVentasViewController.h"
#import <ShinobiCharts/ShinobiCharts.h>
#import "PieChartDataSource.h"
#import "BarChartDataSource.h"

@interface TableroVentasViewController () <SChartDelegate>

@end

@implementation TableroVentasViewController
{
	NSDictionary* _sales;
	NSDictionary* _ejecutivos;
	
	ShinobiChart* _chart;
	BarChartDataSource* _barChartDataSource;
	
	ShinobiChart* _pieChart;
	PieChartDataSource* _pieChartDataSource;

}
- (void)viewDidLoad {
    [super viewDidLoad];
	

	_sales =  @{@"NOV": @{@"1" : @5.1, @"2" : @12.1, @"3" : @8.1, @"4" : @4.1, @"5" : @6.1, @"6" : @8.1}};
	//_ejecutivos = @{@"NOV":@{@"Juan" : @4.1, @"Ricardo" : @4.1}};
	_ejecutivos = @{@"NOV":@{@"Juan Carlos" : @4.0, @"Marilu" : @5.0, @"Ricardo" : @4.0, @"Yamil" : @1.0, @"German" : @1.0, @"Carlos" : @1.0}};

	//Creamos los datasource de los charts
	_barChartDataSource = [[BarChartDataSource alloc] initWithSales:_sales];
	_pieChartDataSource = [[PieChartDataSource alloc] initWithSales:_ejecutivos displayYear:@"NOV"];

	//Pintamos los graficos
	[self createBarChar:CGRectMake(10.0, 65.0, self.view.bounds.size.width-20.0, 200.0)];
    [self createPieChart:CGRectMake(15.0, 270.0, self.view.bounds.size.width-20.0, 300.0)];
	
	
	
}

- (void)createPieChart:(CGRect)frame {
	
	// Create the chart
	//CGFloat margin = 10.0;
//	_pieChart = [[ShinobiChart alloc] initWithFrame:CGRectInset(frame, margin, margin)];
	_pieChart = [[ShinobiChart alloc] initWithFrame:frame];
//	[self updatePieTitle];
	
	_pieChart.canvasAreaBackgroundColor = [UIColor whiteColor];
	_pieChart.backgroundColor = [UIColor whiteColor];

	_pieChart.autoresizingMask =  ~UIViewAutoresizingNone;
	
	_pieChart.licenseKey = @"l9A71q3bgUhnNJ7MjAxNTEyMDNqY3JsM0Bob3RtYWlsLmNvbQ==yhzxBlaTl8JzSEcaQf+naqScFcq0efB3QGCSVz7jzHTczHxbehikZT0Pjb1JYqHAwNHujptBy6d51aTkZHQoseFAzuea2ISXLsrdR0DHEi4p/xUH1HQFlbsEKdllvHXDjwkLQf3nktJ6Au0TWk6yZgvLEvkk=AXR/y+mxbZFM+Bz4HYAHkrZ/ekxdI/4Aa6DClSrE4o73czce7pcia/eHXffSfX9gssIRwBWEPX9e+kKts4mY6zZWsReM+aaVF0BL6G9Vj2249wYEThll6JQdqaKda41AwAbZXwcssavcgnaHc3rxWNBjJDOk6Cd78fr/LwdW8q7gmlj4risUXPJV0h7d21jO1gzaaFCPlp5G8l05UUe2qe7rKbarpjoddMoXrpErC9j8Lm5Oj7XKbmciqAKap+71+9DGNE2sBC+sY4V/arvEthfhk52vzLe3kmSOsvg5q+DQG/W9WbgZTmlMdWHY2B2nbgm3yZB7jFCiXH/KfzyE1A==PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"; // TODO: add your trial licence key here!

	// add to the view
	[self.view addSubview:_pieChart];
	
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
	_chart.title = @"Ventas Nov";
	
	
	SChartTheme *chartTheme = [SChartLightTheme new];
	[_chart applyTheme: chartTheme];
	
	_chart.gestureDoubleTapEnabled = NO;
	_chart.autoresizingMask =  ~UIViewAutoresizingNone;
	
	_chart.licenseKey = @"l9A71q3bgUhnNJ7MjAxNTEyMDNqY3JsM0Bob3RtYWlsLmNvbQ==yhzxBlaTl8JzSEcaQf+naqScFcq0efB3QGCSVz7jzHTczHxbehikZT0Pjb1JYqHAwNHujptBy6d51aTkZHQoseFAzuea2ISXLsrdR0DHEi4p/xUH1HQFlbsEKdllvHXDjwkLQf3nktJ6Au0TWk6yZgvLEvkk=AXR/y+mxbZFM+Bz4HYAHkrZ/ekxdI/4Aa6DClSrE4o73czce7pcia/eHXffSfX9gssIRwBWEPX9e+kKts4mY6zZWsReM+aaVF0BL6G9Vj2249wYEThll6JQdqaKda41AwAbZXwcssavcgnaHc3rxWNBjJDOk6Cd78fr/LwdW8q7gmlj4risUXPJV0h7d21jO1gzaaFCPlp5G8l05UUe2qe7rKbarpjoddMoXrpErC9j8Lm5Oj7XKbmciqAKap+71+9DGNE2sBC+sY4V/arvEthfhk52vzLe3kmSOsvg5q+DQG/W9WbgZTmlMdWHY2B2nbgm3yZB7jFCiXH/KfzyE1A==PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"; // TODO: add your trial licence key here!
	
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
