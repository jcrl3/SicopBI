//
//  GridViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 02/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "GridViewController.h"

@interface GridViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewGridContainer;
@end

@implementation GridViewController{
  ShinobiDataGrid* _shinobiDataGrid;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[ShinobiGrids setLicenseKey:[PropiedadesGraficas getLicence]]; // TODO: add your trial licence key here!
	
	// create a grid - with a 40 point padding
	_shinobiDataGrid = [[ShinobiDataGrid alloc] initWithFrame:CGRectMake(self.viewGridContainer.bounds.origin.x+10, self.viewGridContainer.bounds.origin.y+10, self.viewGridContainer.bounds.size.width-20, self.viewGridContainer.bounds.size.height-20)];
	
	
	// add a name column
	SDataGridColumn* nameColumn = [[SDataGridColumn alloc] initWithTitle:@"Ejecutivo"];
	nameColumn.width = @250;
	nameColumn.sortMode=SDataGridColumnSortModeBiState;
	[_shinobiDataGrid addColumn:nameColumn];
	
	// add an age column
	SDataGridColumn* sellColumn = [[SDataGridColumn alloc] initWithTitle:@"Ventas"];
	sellColumn.width = @20;
	sellColumn.sortMode=SDataGridColumnSortModeBiState;
	[_shinobiDataGrid addColumn:sellColumn];
	
	// add to the view
	[self.viewGridContainer addSubview:_shinobiDataGrid];
	
	_shinobiDataGrid.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Delegate of Shinobigrid
-(NSUInteger)shinobiDataGrid:(ShinobiDataGrid *)grid numberOfRowsInSection:(NSInteger) sectionIndex
{
	return data.count;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid prepareCellForDisplay:(SDataGridCell *)cell
{
	// both columns use a SDataGridTextCell, so we are safe to perform this cast
	SDataGridTextCell* textCell = (SDataGridTextCell*)cell;
	NSArray* currentRecord = [data objectAtIndex:cell.coordinate.row.rowIndex];
	NSString *columnName = [currentRecord objectAtIndex:0];
	NSString *columnSell = [currentRecord objectAtIndex:1];

	// determine which column this cell belongs to
	if ([cell.coordinate.column.title isEqualToString:@"Ejecutivo"])
	 {
		// render the name in the 'name' column
		textCell.textField.text = columnName;
	 }
	if ([cell.coordinate.column.title isEqualToString:@"Ventas"])
	 {
		textCell.textField.text = columnSell;
	 }
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
