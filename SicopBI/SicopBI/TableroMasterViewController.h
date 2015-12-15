//
//  TableroVentasViewController.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "PieChartDataSource.h"
#import "BarChartDataSource.h"
#import "PropiedadesGraficas.h"
#import "PanelGrafica.h"
#import "DateManager.h"
#import "DimDate.h"
#import "SqlSentenceManager.h"

@interface TableroMasterViewController : UIViewController<SChartCrosshair>{

}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property (strong, nonatomic) NSString* titleView;
@property (weak, nonatomic) IBOutlet UIView *conentView;

//+(void)setClassForStoryBoard:(NSString *)classString;

@end
