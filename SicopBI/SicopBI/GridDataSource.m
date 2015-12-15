//
//  GridManager.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 11/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "GridDataSource.h"
#import "ResultDataObject.h"
#import "PropiedadesGraficas.h"


@implementation GridDataSource{
	NSArray *results;
	NSArray *columns;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithColumsAndData:(NSArray*)titleColumns data:(NSArray*)data{
	self = [super init];
	if (self) {
		results=[data copy];
		columns = [titleColumns copy];
	}
	return self;
}

-(void) setData:(NSArray*)data{
	results=data;
}

/*
-(void) setProperties{
	self.singleTapEventMask = SDataGridEventNone;
	self.doubleTapEventMask = SDataGridEventNone;
	
	self.defaultGridLineStyle.width = 1.0f;
	//Interlineada
	self.defaultGridLineStyle.color=[UIColor grayColor];
	
	self.defaultSectionHeaderStyle.backgroundColor=[UIColor colorWithRed:189/255
																			   green:188/255
																				blue:194/255
																			   alpha:1.0 ];
	
}

-(void) addColumns{
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
	
	
}
*/


#pragma mark -
#pragma mark Delegate of Shinobigrid
-(NSUInteger)shinobiDataGrid:(ShinobiDataGrid *)grid numberOfRowsInSection:(NSInteger) sectionIndex
{
	return results.count;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid prepareCellForDisplay:(SDataGridCell *)cell
{
	// both columns use a SDataGridTextCell, so we are safe to perform this cast
	SDataGridTextCell* textCell = (SDataGridTextCell*)cell;
	ResultDataObject* currentRecord = [results objectAtIndex:cell.coordinate.row.rowIndex];
	NSString *fieldtoGroup = currentRecord.fieldtoGroup;
	NSString *fieldtoCount = currentRecord.fieldtoCount;
	
	textCell.textField.font=[UIFont fontWithName: [PropiedadesGraficas getFontName] size:10.f];
	textCell.backgroundColor = [UIColor clearColor];
	
	// determine which column this cell belongs to
	if ([cell.coordinate.column.title isEqualToString:[columns objectAtIndex:0]])
	 {
		// render the name in the 'name' column
		textCell.textField.text = fieldtoGroup;
		
		
	 }
	if ([cell.coordinate.column.title isEqualToString:[columns objectAtIndex:1]])
	 {
		textCell.textField.text = fieldtoCount;
		textCell.textField.textAlignment = NSTextAlignmentRight;
	 }
}

@end
