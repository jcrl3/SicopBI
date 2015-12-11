//
//  GridViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 02/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "GridViewController.h"
#import "ResultDataObject.h"
@interface GridViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewGridContainer;
@property (nonatomic, strong) NSArray *sortedData;

@end

@implementation GridViewController{
	ShinobiDataGrid* _shinobiDataGrid;
	
}
@synthesize data;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (NSArray *record in self.data) {
		ResultDataObject *result = [[ResultDataObject alloc]init];
		result.fieldtoGroup=[record objectAtIndex:0];
		result.fieldtoCount=[record objectAtIndex:1];
		[results addObject:result];
	}
	
	self.data = [NSArray arrayWithArray:results];
	self.sortedData = [NSArray arrayWithArray:results];
	
	self.viewGridContainer.bounds = self.view.bounds;
	
	//[ShinobiGrids setLicenseKey:[PropiedadesGraficas getLicence]]; // TODO: add your trial licence key here!
	
	//Create the grid
	_shinobiDataGrid = [[ShinobiDataGrid alloc] initWithFrame:CGRectMake(self.viewGridContainer.bounds.origin.x+20.0,
																		 self.viewGridContainer.bounds.origin.y+25.0,
																		 self.viewGridContainer.bounds.size.width-35.0,
																		 self.viewGridContainer.bounds.size.height-35.0)];
	
	
	_shinobiDataGrid.singleTapEventMask = SDataGridEventNone;
	_shinobiDataGrid.doubleTapEventMask = SDataGridEventNone;
	
	
	_shinobiDataGrid.defaultGridLineStyle.width = 1.0f;
	//Interlineada
	_shinobiDataGrid.defaultGridLineStyle.color=[UIColor grayColor];  /*[UIColor colorWithRed:189/255
																	   green:188/255
																	   blue:194/255
																	   alpha:0.8];*/
	
	
	_shinobiDataGrid.defaultSectionHeaderStyle.backgroundColor=[UIColor colorWithRed:189/255
																			   green:188/255
																				blue:194/255
																			   alpha:1.0 ];
	
	// add a fieldtogroup column
	SDataGridColumn* nameColumn = [[SDataGridColumn alloc] initWithTitle:@"EJECUTIVO"];
	nameColumn.width = @210;
	nameColumn.sortMode=SDataGridColumnSortModeBiState;
	nameColumn.headerCellStyle.font = [UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
	
	[_shinobiDataGrid addColumn:nameColumn];
	
	// add fieledtocount column
	SDataGridColumn* sellColumn = [[SDataGridColumn alloc] initWithTitle:@"VENTAS"];
	sellColumn.width = @130;
	sellColumn.sortMode=SDataGridColumnSortModeBiState;
	sellColumn.headerCellStyle.font = [UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
	[_shinobiDataGrid addColumn:sellColumn];
	
	_shinobiDataGrid.selectionMode = SDataGridSelectionModeNone;
	_shinobiDataGrid.defaultRowHeight = @(28.0);
	_shinobiDataGrid.defaultHeaderRowHeight=@(28.0);
	
	// add to the view
	[self.viewGridContainer addSubview:_shinobiDataGrid];
	
	_shinobiDataGrid.delegate = self;
	_shinobiDataGrid.dataSource = self;
	
	
	[self.view addGestureRecognizer:self.leftSwipe];
}

-(void) viewDidAppear:(BOOL)animated{
	[[NSUserDefaults standardUserDefaults] setObject:@"GridViewController" forKey:@"vcActive"];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Delegate of Shinobigrid
-(NSUInteger)shinobiDataGrid:(ShinobiDataGrid *)grid numberOfRowsInSection:(NSInteger) sectionIndex
{
	return self.sortedData.count;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid prepareCellForDisplay:(SDataGridCell *)cell
{
	// both columns use a SDataGridTextCell, so we are safe to perform this cast
	SDataGridTextCell* textCell = (SDataGridTextCell*)cell;
	ResultDataObject* currentRecord = [self.sortedData objectAtIndex:cell.coordinate.row.rowIndex];
	NSString *fieldtoGroup = currentRecord.fieldtoGroup;
	NSString *fieldtoCount = currentRecord.fieldtoCount;
	
	textCell.textField.font=[UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
	textCell.backgroundColor = [UIColor clearColor];
	
	// determine which column this cell belongs to
	if ([cell.coordinate.column.title isEqualToString:@"EJECUTIVO"])
	 {
		// render the name in the 'name' column
		textCell.textField.text = fieldtoGroup;
		
		
	 }
	if ([cell.coordinate.column.title isEqualToString:@"VENTAS"])
	 {
		textCell.textField.text = fieldtoCount;
		textCell.textField.textAlignment = NSTextAlignmentRight;
	 }
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didChangeSortOrderForColumn:(SDataGridColumn *)column
				   from:(SDataGridColumnSortOrder)oldSortOrder {
	
	if (column.sortOrder == SDataGridColumnSortOrderNone) {
		// If there is no sorting, use the 'natural' order of the data
		self.sortedData = [NSArray arrayWithArray:self.data];
	}
	else {
		if ([column.title isEqualToString:@"EJECUTIVO"]) {
			// Sort by the EJECUTIVO property
			self.sortedData = [self.data sortedArrayUsingComparator:^NSComparisonResult(ResultDataObject *obj1,
																						ResultDataObject *obj2) {
				NSString *valueOne = obj1.fieldtoGroup;
				NSString *valueTwo = obj2.fieldtoGroup;
				NSComparisonResult result = [valueOne compare:valueTwo];
				return column.sortOrder == SDataGridColumnSortOrderAscending ? result : -result;
			}];
		}
		else if ([column.title isEqualToString:@"VENTAS"]) {
			// Sort by the VENTAS property
			self.sortedData = [self.data sortedArrayUsingComparator:^NSComparisonResult(ResultDataObject *obj1,
																						ResultDataObject *obj2) {
				NSNumber *valueOne =[NSNumber numberWithInt:[obj1.fieldtoCount intValue]];
				NSNumber *valueTwo = [NSNumber numberWithInt:[obj2.fieldtoCount intValue]];
				NSComparisonResult result = [valueOne compare:valueTwo];
				return column.sortOrder == SDataGridColumnSortOrderAscending ? result : -result;
			}];
		}
	}
	
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
