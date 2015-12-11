//
//  TableroVentasViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TableroMasterViewController.h"
#import "AppDelegate.h"

@interface TableroMasterViewController ()<SChartDelegate>

@end


@implementation TableroMasterViewController
{
	NSDictionary* _sales;
	NSDictionary* _ejecutivos;
	NSMutableArray* _timeSeries;
	NSArray* _datos;
	
	//Nuevos
	NSMutableArray* _sellers;
	
	///Views de las graficas a mostrar
	UIViewController *childViewBar;
	UIViewController *childViewPie;
	UIViewController *childViewLine;
	UIViewController *childViewColumn;
	ShinobiChart* _localchart;
	SChartCrosshairTooltip *tooltip;
	SChartCrosshairStyle *style;
}

//This variables control dates
NSString* queryDate;
NSString* queryYear;
NSString* queryDay;
NSString* queryMonth;
//Database manager
DateManager *dateManager;
AppDelegate *SicopBIDelegate;

//esta variable va a controlar la clase que se tiene que cargar al story board
static NSString* classForStoryBoard;
@synthesize titleView;
@synthesize scrollView;
@synthesize tooltip;
@synthesize style;

#pragma mark -
#pragma mark - controlamos la clase que se va a utilizar para controlar el tablero que se va a mostrar
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = self.titleView;
   //get the appdelegate
    SicopBIDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//alloc DateManager
	dateManager = [[DateManager alloc] init];
	
	//quitar esto
	[dateManager setDate:[dateManager addOrLessDaysToDate:-101]]; //7 dic
	
	//Get today
	NSString *idDateTo = [DimDate getIdFecha:dateManager.getDay month:dateManager.getMonth year:dateManager.getYear];
	
	//Set Date firstDayOfMonth
	[dateManager setDate:[NSString stringWithFormat:@"%@-%@-01",  dateManager.getYear, dateManager.getMonth]];
	NSString *idDateFrom = [DimDate getIdFecha:dateManager.getDay month:dateManager.getMonth year:dateManager.getYear];

	NSLog(@"Id's dateFrom is %@  and until  %@", idDateFrom, idDateTo);

	//Create the sentence to retrieve data from KPIs Table
	NSString *querySn=[SqlSentenceManager
					   getSentenceForKpi:@"SUM(PROSPECTOS)"
					   fieldToGroup:[NSString stringWithFormat:@"strftime(%s,Fecha)","'%d/%m/%Y'"]
					   fromIdDate:idDateFrom
					   toIdDate:idDateTo
					   fieldToGroupAfterFrom:@"Fecha"
					   fieldToOrder:@"Fecha"
					   aditionalCondition:@""];
	NSLog(@"Query prospectos%@", querySn);

	//Get data from KPIs table Prospectos
	_datos = [SicopBIDelegate.dbManager loadDataFromDB:querySn];

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
	
	
	
	//Create the sentence to retrieve data from sales
	querySn=[SqlSentenceManager
					   getSentenceForKpi:@"SUM(VentasEntregadas)"
					   fieldToGroup:@"Ejecutivo"
					   fromIdDate:idDateFrom
					   toIdDate:idDateTo
					   fieldToGroupAfterFrom:@"Ejecutivo"
					   fieldToOrder:@"VentasEntregadas"
			           aditionalCondition:@" AND VentasEntregadas>0 "];
	NSLog(@"Query %@", querySn);
   _sellers =[[SicopBIDelegate.dbManager loadDataFromDB:querySn] copy];

	
	
	
	
	
	///Aqui se necesita obtener los daatos de los servicios web
	_sales =  @{@"NOV": @{@"1" : @5.1, @"2" : @12.1, @"3" : @8.1, @"4" : @4.1, @"5" : @6.1, @"6" : @8.1}};
	_ejecutivos = @{@"NOV":@{@"Juan Carlos" : @4.0, @"Marilu" : @5.0, @"Ricardo" : @4.0, @"Yamil" : @1.0, @"German" : @1.0, @"Carlos" : @1.0}};
	
	self.scrollView.backgroundColor = [UIColor whiteColor];
	[self.scrollView setContentSize:CGSizeMake(320.0, 1194.0)];
	
	
	
	
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
	((PanelGrafica*)childViewPie).titleGraph =@"Ventas por ejecutivo";
	((PanelGrafica*)childViewPie).dataXLine = _sellers;
	((PanelGrafica*)childViewPie).hideLegend= NO;
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

-(void) viewDidAppear:(BOOL)animated{
	[[NSUserDefaults standardUserDefaults] setObject:@"TableroMasterViewController" forKey:@"vcActive"];
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


- (void)sChart:(ShinobiChart *)chart toggledSelectionForRadialPoint:(SChartRadialDataPoint *)dataPoint inSeries:(SChartRadialSeries *)series atPixelCoordinate:(CGPoint)pixelPoint {
	int total = 0;
	
	//If we select an element on the pie we need to update the donut
	SChartPieSeries *pieSeries = (SChartPieSeries*)series;
	
	for (int i=0; i<pieSeries.dataSeries.dataPoints.count; i++) {
		SChartDataPoint *dp = pieSeries.dataSeries.dataPoints[i];
		total += [dataPoint.value intValue];
		if (![[dp sChartXValue] isEqualToString:dataPoint.name]) {
			if (dataPoint.selected) {
				[pieSeries setSlice:i asSelected:NO];
			}
		}
	}
	
	for (UILabel *lbl in chart.legend.labels) {
		if ([lbl.text isEqualToString:dataPoint.name]) {
		 lbl.textColor =[UIColor redColor];
		}
	}
	//series.selected=YES;
	((PanelGrafica*)childViewPie).labelBottomDonut.text = [NSString stringWithFormat:@"%@", dataPoint.name];
	((PanelGrafica*)childViewPie).labelCenterDonut.text = [NSString stringWithFormat:@"%@ de 58  %d%@", dataPoint.value, ([dataPoint.value intValue]/58*100),@"%"];

	
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
#pragma mark Crosshair delegate
- (void)moveToPoint:(CGPoint)pointInChart inChart:(ShinobiChart *)chart{
   NSLog(@"Entre a crosshair moveponint");
}

- (void)showAtPoint:(CGPoint)pointInChart inChart:(ShinobiChart *)chart{
  NSLog(@"Entre a crosshair showAtPoint");
}

- (void)hide{
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
