//
//  GridManager.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <ShinobiGrids/ShinobiGrids.h>

@interface GridDataSource : NSObject <SDataGridDataSource>{
	
}

-(id)initWithColumsAndData:(NSArray*)titleColumns data:(NSArray*)data;
-(void) setData:(NSArray*)data;
@end
