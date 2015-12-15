//
//  PanelGrafica.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "PieChartDataSource.h"
#import "BarChartDataSource.h"
#import "PropiedadesGraficas.h"
#import "ExpandGraphViewController.h"
#import "LineChartDataSource.h"
#import "ColumnChartDataSource.h"

extern NSString * const BAR_CHART;
extern NSString * const PIE_CHART;
extern NSString * const LINE_CHART;
extern NSString * const COLUMN_CHART;

//Costants to control format in ylabels
extern NSString * const FORMAT_DATE;
extern NSString * const FORMAT_NUMBER;
extern NSString * const FORMAT_STRING;



@interface PanelGrafica : UIViewController <SChartDelegate>{
	
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spin;
@property (weak, nonatomic)	IBOutlet UIView *viewContainer;
@property (strong, nonatomic) UILabel *labelBottomDonut;
@property (strong, nonatomic) UILabel *labelCenterDonut;
@property (strong, nonatomic) NSDictionary* dataX;
@property (strong, nonatomic) NSMutableArray* dataXLine;
@property (strong, nonatomic) NSString* typeOfChart;
@property (nonatomic) BOOL hideLegend;
@property (strong, nonatomic) NSString* titleGraph;
@property (strong, nonatomic) NSString* yTitle;
@property (strong, nonatomic) NSString* xTitle;
@property (strong, nonatomic) NSString* yFormatString;
@property (strong, nonatomic) NSString* xFormatString;
@property (strong, nonatomic) NSString* formatString;
@property (nonatomic) BOOL  gestDoubleTapEnabled;
@property (weak, nonatomic) id viewDelegate;
@property (strong, nonatomic) ShinobiChart* _chart;

@end
