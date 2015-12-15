//
//  ResumeView.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 23/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "ResumeView.h"
#import "ResultDataObject.h"
#import "GridDataSource.h"
#import "PropiedadesGraficas.h"

@implementation ResumeView{
	GridDataSource  *_dataGridSource;
	ShinobiDataGrid *_shinobiDataGrid;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize data;
@synthesize columns;
@synthesize viewGridContainer;
@synthesize resumenLabel;
@synthesize disciplinaLabel;
- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (self.columns == nil){
		return;
	}
	resumenLabel.textColor =[UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];

	disciplinaLabel.textColor=[UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
	
	self.viewGridContainer.bounds = self.view.bounds;
	
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (NSArray *record in self.data) {
		ResultDataObject *result = [[ResultDataObject alloc]init];
		result.fieldtoGroup=[record objectAtIndex:0];
		result.fieldtoCount=[record objectAtIndex:1];
		[results addObject:result];
	}
	
	self.data = [NSArray arrayWithArray:results];
	
	_dataGridSource =[[GridDataSource alloc] initWithColumsAndData:[self.columns objectAtIndex: 0] data:self.data];
	
	_shinobiDataGrid = [[ShinobiDataGrid alloc] initWithFrame:CGRectMake(self.viewGridContainer.bounds.origin.x+1.0,
																		 self.viewGridContainer.bounds.origin.y+1.0,
																		 self.viewGridContainer.bounds.size.width-15.0,
																		 self.viewGridContainer.bounds.size.height-40.0)];
	
	///Create columns accord to colums NSArray.
	for (int a=0; a<=self.columns.count-1; a++) {
		SDataGridColumn* nameColumn = [[SDataGridColumn alloc] initWithTitle: [[self.columns objectAtIndex: 0] objectAtIndex: a]];
		nameColumn.width = [[self.columns objectAtIndex: 1] objectAtIndex: a];
		nameColumn.headerCellStyle.font = [UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
		[_shinobiDataGrid addColumn:nameColumn];
	}
	
	[self setGridProperties];
	
	//Add grid to viewer
	[self.viewGridContainer addSubview:_shinobiDataGrid];
	
	//Set delegate and datasoruce
	_shinobiDataGrid.dataSource= _dataGridSource;
	_shinobiDataGrid.delegate = self;
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


-(void) setGridProperties{
	_shinobiDataGrid.singleTapEventMask = SDataGridEventNone;
	_shinobiDataGrid.doubleTapEventMask = SDataGridEventNone;

	_shinobiDataGrid.defaultGridLineStyle.width = 1.0f;
	//Interlineada
	_shinobiDataGrid.defaultGridLineStyle.color=[UIColor clearColor];
	
	_shinobiDataGrid.defaultSectionHeaderStyle.textColor = [UIColor orangeColor];
	_shinobiDataGrid.defaultSectionHeaderStyle.backgroundColor = [UIColor clearColor];

/*	_shinobiDataGrid.defaultSectionHeaderStyle.backgroundColor=[UIColor colorWithRed:189/255
																			   green:188/255
																				blue:194/255
 alpha:1.0 ];*/
	
	_shinobiDataGrid.selectionMode = SDataGridSelectionModeNone;
	_shinobiDataGrid.defaultRowHeight = @(15.0);
	_shinobiDataGrid.defaultHeaderRowHeight=@(15.0);
	
	
	
}




@end
