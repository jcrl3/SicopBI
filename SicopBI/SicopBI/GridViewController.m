//
//  GridViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 02/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "GridViewController.h"
#import "ResultDataObject.h"
#import "GridDataSource.h"

@interface GridViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewGridContainer;
@property (nonatomic, strong) NSArray *sortedData;

@end

@implementation GridViewController{
	GridDataSource  *_dataGridSource;
	ShinobiDataGrid *_shinobiDataGrid;
}
@synthesize data;
@synthesize columns;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.viewGridContainer.bounds = self.view.bounds;

	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (NSArray *record in self.data) {
		ResultDataObject *result = [[ResultDataObject alloc]init];
		result.fieldtoGroup=[record objectAtIndex:0];
		result.fieldtoCount=[record objectAtIndex:1];
		[results addObject:result];
	}
	
	self.data = [NSArray arrayWithArray:results];
	self.sortedData = [NSArray arrayWithArray:results];
	
	_dataGridSource =[[GridDataSource alloc] initWithColumsAndData:[self.columns objectAtIndex: 0] data:self.sortedData];
	
	_shinobiDataGrid = [[ShinobiDataGrid alloc] initWithFrame:CGRectMake(self.viewGridContainer.bounds.origin.x+20.0,
																		 self.viewGridContainer.bounds.origin.y+25.0,
																		 self.viewGridContainer.bounds.size.width-35.0,
																		 self.viewGridContainer.bounds.size.height-35.0)];
	
   ///Create columns accord to colums NSArray.
	for (int a=0; a<=self.columns.count-1; a++) {
		SDataGridColumn* nameColumn = [[SDataGridColumn alloc] initWithTitle: [[self.columns objectAtIndex: 0] objectAtIndex: a]];
		nameColumn.width = [[self.columns objectAtIndex: 1] objectAtIndex: a];
		nameColumn.sortMode=SDataGridColumnSortModeBiState;
		nameColumn.headerCellStyle.font = [UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
		[_shinobiDataGrid addColumn:nameColumn];
	}
	
	[self setGridProperties];
	
	//Add grid to viewer
	[self.viewGridContainer addSubview:_shinobiDataGrid];
	
	//Set delegate and datasoruce
	_shinobiDataGrid.dataSource= _dataGridSource;
	_shinobiDataGrid.delegate = self;

	
	[self.view addGestureRecognizer:self.leftSwipe];
}

-(void) viewDidAppear:(BOOL)animated{
	[[NSUserDefaults standardUserDefaults] setObject:@"GridViewController" forKey:@"vcActive"];
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
	
	_shinobiDataGrid.defaultSectionHeaderStyle.backgroundColor=[UIColor colorWithRed:189/255
																			   green:188/255
																				blue:194/255
																			   alpha:1.0 ];
	_shinobiDataGrid.selectionMode = SDataGridSelectionModeNone;
	_shinobiDataGrid.defaultRowHeight = @(28.0);
	_shinobiDataGrid.defaultHeaderRowHeight=@(28.0);
	
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didChangeSortOrderForColumn:(SDataGridColumn *)column
				   from:(SDataGridColumnSortOrder)oldSortOrder {
	
	if (column.sortOrder == SDataGridColumnSortOrderNone) {
		// If there is no sorting, use the 'natural' order of the data
		self.sortedData = [NSArray arrayWithArray:self.data];
	}
	else {
		
		NSString *columnName =[[self.columns objectAtIndex: 0] objectAtIndex: 0];

		if ([column.title isEqualToString:columnName]) {
			self.sortedData = [self.data sortedArrayUsingComparator:^NSComparisonResult(ResultDataObject *obj1,
																						ResultDataObject *obj2) {
				NSString *valueOne = obj1.fieldtoGroup;
				NSString *valueTwo = obj2.fieldtoGroup;
				NSComparisonResult result = [valueOne compare:valueTwo];
				return column.sortOrder == SDataGridColumnSortOrderAscending ? result : -result;
			}];
		}
		else if ([column.title isEqualToString:columnName]) {
			self.sortedData = [self.data sortedArrayUsingComparator:^NSComparisonResult(ResultDataObject *obj1,
																						ResultDataObject *obj2) {
				NSNumber *valueOne =[NSNumber numberWithInt:[obj1.fieldtoCount intValue]];
				NSNumber *valueTwo = [NSNumber numberWithInt:[obj2.fieldtoCount intValue]];
				NSComparisonResult result = [valueOne compare:valueTwo];
				return column.sortOrder == SDataGridColumnSortOrderAscending ? result : -result;
			}];
		}
	}
	[_dataGridSource setData:self.sortedData];
	// Inform the grid that it should re-load the data
	[_shinobiDataGrid reload];
	
	NSLog(@"Reordering");
}

- (IBAction)goBackSwipe:(id)sender {
	
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
