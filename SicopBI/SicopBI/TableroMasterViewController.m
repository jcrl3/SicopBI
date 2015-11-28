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
	NSArray* _datos;
	///Views de las graficas a mostrar
	UIViewController *childViewBar;
	UIViewController *childViewPie;
	UIViewController *childViewLine;
	UIViewController *childViewColumn;
	ShinobiChart* _localchart;
}

//This variables control dates
NSString* queryDate;
NSString* queryYear;
NSString* queryDay;
NSString* queryMonth;

//Manager of database
DateManager *dateManager;

//esta variable va a controlar la clase que se tiene que cargar al story board
static NSString* classForStoryBoard;
@synthesize titleView;
@synthesize scrollView;

#pragma mark -
#pragma mark - controlamos la clase que se va a utilizar para controlar el tablero que se va a mostrar
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = self.titleView;

	//open database
	self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"SicopBIDatabase.db"];
	//Set dates
	dateManager = [[DateManager alloc] init];
	
	NSLog(@"La fecha actual es %@", dateManager.getDate);
	NSLog(@"El mes actual es %@", dateManager.getMonth);
	NSLog(@"El dia actual es %@", dateManager.getDay);
	NSLog(@"El año actual es %@", dateManager.getYear);
	NSLog(@"La fecha de hace un mes %@", [dateManager addOrLessDaysToDate:-30]);
	
	
	NSString *querySn= [NSString stringWithFormat:@"SELECT \
						strftime(%s,Fecha) as Fecha, \
						SUM(PROSPECTOS) AS TOTAL \
						FROM \
						KPIS \
						WHERE \
						IdFecha BETWEEN  5692 and  5722 \
						GROUP BY \
						Fecha \
						ORDER BY  \
						Fecha", "'%d/%m/%Y'"];

	_datos = [self.dbManager loadDataFromDB:querySn];
	
	
	///Aqui se necesita obtener los daatos de los servicios web
	_sales =  @{@"NOV": @{@"1" : @5.1, @"2" : @12.1, @"3" : @8.1, @"4" : @4.1, @"5" : @6.1, @"6" : @8.1}};
	_ejecutivos = @{@"NOV":@{@"Juan Carlos" : @4.0, @"Marilu" : @5.0, @"Ricardo" : @4.0, @"Yamil" : @1.0, @"German" : @1.0, @"Carlos" : @1.0}};
	
	self.scrollView.backgroundColor = [UIColor whiteColor];
	[self.scrollView setContentSize:CGSizeMake(320.0, 1194.0)];
	
	//Creamos los datos para la grafica de lineas
	_timeSeries = [NSMutableArray new];
	for (NSArray* dato in _datos) {
		NSString *dateData= [dato objectAtIndex:0];
		NSString *value =[dato objectAtIndex:1];
		
		SChartDataPoint* dataPoint = [SChartDataPoint new];
		dataPoint.xValue = [self dateFromString:dateData];
		dataPoint.yValue = [NSNumber numberWithInt:[value intValue]];
		[_timeSeries addObject:dataPoint];
	}
	
	/*
	for (int a=0; (a<=_datos.count); a++) {
		
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
		
	}*/
	
	//Creamos el panel de grafica de barras
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	childViewBar = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewBar.view.frame = CGRectMake(0.0, 212.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewBar).dataXLine= _timeSeries;
	((PanelGrafica*)childViewBar).typeOfChart= BAR_CHART;
	((PanelGrafica*)childViewBar).xFormatString = FORMAT_DATE;
	((PanelGrafica*)childViewBar).formatString = @"dd MMM";
	((PanelGrafica*)childViewBar).hideLegend= YES;
	((PanelGrafica*)childViewBar).titleGraph= @"Captación";
	((PanelGrafica*)childViewBar).gestDoubleTapEnabled=NO;
	((PanelGrafica*)childViewBar).viewDelegate = self;
	
	[self addChartToView:childViewBar];
	
	
	//Integramos la grafica de PIE
	childViewPie = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewPie.view.frame = CGRectMake(0.0, 462.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewPie).dataX= _ejecutivos;
	((PanelGrafica*)childViewPie).typeOfChart=PIE_CHART;
	((PanelGrafica*)childViewPie).viewDelegate = self;
	
	[self addChartToView:childViewPie];
	
	
	//Integramos una grafica de lineas
	
	//Integramos la grafica de Lineas
	childViewLine = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewLine.view.frame = CGRectMake(0.0, 712.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewLine).titleGraph= @"Prospectos";
	((PanelGrafica*)childViewLine).dataXLine= _timeSeries;
	((PanelGrafica*)childViewLine).xFormatString = FORMAT_DATE;
	((PanelGrafica*)childViewLine).formatString = @"dd MMM";
	((PanelGrafica*)childViewLine).hideLegend= YES;
	((PanelGrafica*)childViewLine).typeOfChart=LINE_CHART;

	[self addChartToView:childViewLine];
	
	
	//integramos la grafica de barras
	
	childViewColumn = [mainStoryboard instantiateViewControllerWithIdentifier:@"PanelGrafica"];
	childViewColumn.view.frame = CGRectMake(0.0, 962.0, self.scrollView.bounds.size.width-1.0, 250.0);
	((PanelGrafica*)childViewColumn).titleGraph= @"Prospectos";
	((PanelGrafica*)childViewColumn).dataXLine= _timeSeries;
	((PanelGrafica*)childViewColumn).hideLegend= YES;
	((PanelGrafica*)childViewColumn).typeOfChart=COLUMN_CHART;
	[self addChartToView:childViewColumn];


	
	self.navigationController.navigationBar.topItem.title = @"";
	[self.view addGestureRecognizer:self.leftSwipe];
}

#pragma mark -
#pragma mark - Procedimiento que agrega la grafica al viewcontroller

-(void) addChartToView: (UIViewController*) pUIChartView{
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
	_localchart.title = [NSString stringWithFormat:@"Ventas del día %@", dataPoint.xValue];
	[_localchart reloadData];
	[_localchart redrawChart];

}


-(void)sChart:(ShinobiChart *)chart radialSeriesDidEndDecelerating:(SChartRadialSeries *)radialSeries {
	[self selectSliceOnSeries:(SChartDonutSeries *)radialSeries atAngle:0];
}

-(void)selectSliceOnSeries:(SChartDonutSeries *)donut atAngle:(CGFloat)angle {
	NSUInteger index = [donut indexOfSliceAtAngle:angle];
	
	for (int x=0; x<donut.dataSeries.dataPoints.count; x++) {
		[donut setSlice:x asSelected:(x == index)];
	}
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
