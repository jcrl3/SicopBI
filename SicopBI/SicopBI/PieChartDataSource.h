//
//  PieChartDataSource.h
//  HandlingSelection
//
//  Created by Colin Eberhardt on 16/07/2013.
//  Copyright (c) 2013 ShinobiControls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface PieChartDataSource : NSObject <SChartDatasource>

- initWithData:(NSMutableArray*)ejecutivos displayYear:(NSString*)year;

@property NSString* displayYear;

@end
