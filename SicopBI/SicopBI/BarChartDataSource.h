//
//  BarChartDataSource.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>


@interface BarChartDataSource : NSObject<SChartDatasource>

- initWithSales:(NSDictionary*)sales;

@end
