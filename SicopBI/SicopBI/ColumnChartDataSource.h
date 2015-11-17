//
//  ColumnChartDataSource.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface ColumnChartDataSource : NSObject<SChartDatasource>{
	
}

- (id)initWithData:(NSMutableArray *)dataX;
@end
