//
//  TableroVentasViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TableroMasterViewController.h"

@interface TableroMasterViewController ()<SChartDelegate>

@end



@implementation TableroMasterViewController
{
	
	NSDictionary* _sales;
	NSDictionary* _ejecutivos;
	NSMutableArray* _timeSeries;
	
	UIViewController *childViewBar;
	UIViewController *childViewPie;
	UIViewController *childViewLine;
	UIViewController *childViewColumn;
	
	ShinobiChart* _localchart;
}

//esta variable va a controlar la clase que se tiene que cargar al story board
static NSString* classForStoryBoard;

@synthesize titleView;
@synthesize scrollView;

#pragma mark - 
#pragma mark - controlamos la clase que se va a utilizar para controlar el tablero que se va a mostrar
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = self.titleView;
	
	
	///Aqui se necesita obtener los daatos de los servicios web
	_sales =  @{@"NOV": @{@"1" : @5.1, @"2" : @12.1, @"3" : @8.1, @"4" : @4.1, @"5" : @6.1, @"6" : @8.1}};
	//_ejecutivos = @{@"NOV":@{@"Juan" : @4.1, @"Ricardo" : @4.1}};
	_ejecutivos = @{@"NOV":@{@"Juan Carlos" : @4.0, @"Marilu" : @5.0, @"Ricardo" : @4.0, @"Yamil" : @1.0, @"German" : @1.0, @"Carlos" : @1.0}};
	
	//Creamos los datos para la grafica de lineas
	_timeSeries = [NSMutableArray new];
	for (int a=1; (a<=14); a++) {
		
		NSString *dateData;
		
		dateData= [NSString stringWithFormat: @"%ld", (long)a];
		dateData =[NSString stringWithFormat: @"%ld/11//2015", (long)a];
		
		NSLog(@"Fecha %@", dateData);
		
		int value1;
		value1 = (arc4random() % 20) + 1;
		
		SChartDataPoint* dataPoint = [SChartDataPoint new];
		dataPoint.xValue = [self dateFromString:dateData];
		dataPoint.yValue = [NSNumber numberWithInt:value1];
		
		[_timeSeries addObject:dataPoint];
		
	}

	
	self.scrollView.backgroundColor = [UIColor blackColor];
	[self.scrollView setContentSize:CGSizeMake(320.0, 1000.0)];
	
	//Creamos el panel de grafica de barras
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	childViewBar = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewBar.view.frame = CGRectMake(1.0, 5.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewBar).dataX= _sales;
	((PanelGrafica*)childViewBar).typeOfChart= BAR_CHART;
	((PanelGrafica*)childViewBar).hideLegend= YES;
	((PanelGrafica*)childViewBar).titleGraph= @"Grafico 1";
	((PanelGrafica*)childViewBar).gestDoubleTapEnabled=NO;
	((PanelGrafica*)childViewBar).viewDelegate = self;
	
	[self addSubviewChart:childViewBar];
	
	//Integramos la grafica de PIE
	childViewPie = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewPie.view.frame = CGRectMake(1.0, 258.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewPie).dataX= _ejecutivos;
	((PanelGrafica*)childViewPie).typeOfChart=PIE_CHART;
	
	[self addSubviewChart:childViewPie];
	
	
	//Integramos una grafica de lineas
	
	//Integramos la grafica de Lineas
	childViewLine = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewLine.view.frame = CGRectMake(1.0, 509.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewLine).titleGraph= @"Prospectos";
	((PanelGrafica*)childViewLine).dataXLine= _timeSeries;
	((PanelGrafica*)childViewLine).hideLegend= YES;
	((PanelGrafica*)childViewLine).typeOfChart=LINE_CHART;

	[self addSubviewChart:childViewLine];
	
	
	//integramos la grafica de barras
	
	childViewColumn = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewColumn.view.frame = CGRectMake(1.0, 759.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewColumn).titleGraph= @"Prospectos";
	((PanelGrafica*)childViewColumn).dataXLine= _timeSeries;
	((PanelGrafica*)childViewColumn).hideLegend= YES;
	((PanelGrafica*)childViewColumn).typeOfChart=COLUMN_CHART;
	[self addSubviewChart:childViewColumn];


	
	self.navigationController.navigationBar.topItem.title = @"";
	[self.view addGestureRecognizer:self.leftSwipe];
}

#pragma mark -
#pragma mark - Procedimiento que agrega la grafica al viewcontroller

-(void) addSubviewChart: (UIViewController*) pUIChartView{
	[self addChildViewController:pUIChartView];
	[self.scrollView addSubview:pUIChartView.view];
}

#pragma mark -
#pragma mark  manejo de la barra seleccionada
-(void)sChart:(ShinobiChart *)chart toggledSelectionForSeries:(SChartSeries *)series nearPoint:(SChartDataPoint *)dataPoint atPixelCoordinate:(CGPoint)pixelPoint {
	// determine which year was tapped
	NSString* tappedYear = (NSString*)dataPoint.xValue;
	NSLog(@"Valor %@", tappedYear);
	
	_localchart = ((PanelGrafica*)childViewPie)._chart.getChart;
	
//	_localchart.displayYear = @"NOV";
	_localchart.title = [NSString stringWithFormat:@"Ventas del día %@", dataPoint.xValue];
	//[self updatePieTitle];
	[_localchart reloadData];
	[_localchart redrawChart];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)goBackSwipe:(id)sender {
	
	NSLog(@"Se activo el swipe");
	
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
