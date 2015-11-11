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

extern NSString * const BAR_CHART;
extern NSString * const PIE_CHART;

@interface PanelGrafica : UIViewController <SChartDelegate>{
	
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spin;

@property (strong, nonatomic) NSDictionary* dataX;
@property (strong, nonatomic) NSString* typeOfChart;
@property (nonatomic) BOOL hideLegend;
@property (strong, nonatomic) NSString* titleGraph;
@property (nonatomic) BOOL  gestDoubleTapEnabled;
@property (strong, nonatomic) UIViewController* viewDelegate;
@property (strong, nonatomic) ShinobiChart* _chart;


@end
