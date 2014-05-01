//
//  RootViewController.m
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"


@implementation RootViewController
@synthesize detailViewController;
@synthesize surveyDataArray;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(420.0, 600.0);
    detailViewController.title=@"Prospectos capturados";
    self.title=@"Prospectos capturados";
	
    NSArray *documentDirectoryPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	 NSString *docDir =[NSString stringWithFormat:@"%@/prospectos.xml", [documentDirectoryPath objectAtIndex:0]];
    NSData* serializedData =[NSData dataWithContentsOfFile:docDir];
	
		
	if (serializedData==nil){
		 NSMutableArray* array =[[NSMutableArray alloc] init];
		 self.surveyDataArray= array;
		 [array release];
     }else{
	  	 NSString *error;
		 
		 self.surveyDataArray = (NSMutableArray*)[NSPropertyListSerialization
							   propertyListFromData:serializedData mutabilityOption:kCFPropertyListMutableContainers
							  format:NULL errorDescription:&error];
	 }

}


-(void)addSurveyToDataArray: (NSDictionary*) sd
{
	NSLog(@"AgregandoItemArraySurvey");
	
	[self.surveyDataArray addObject:sd];
	[self.tableView reloadData];
	
}
// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.surveyDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
	}
    
    // Configure the cell.
   	NSDictionary* sd= [self.surveyDataArray objectAtIndex:[indexPath row]];
   cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@" , [sd objectForKey:@"primerNombre"], [sd objectForKey:@"segundoNombre"] , [sd objectForKey:@"tercerNombre"]];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
    [aTableView deselectRowAtIndexPath:indexPath animated:NO];
	  NSDictionary* sd =[self.surveyDataArray objectAtIndex:[indexPath row]];
	  detailViewController.detailItem = sd;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.surveyDataArray=nil;
	
}


- (void)dealloc {
    [detailViewController release];
    [surveyDataArray release];
	[super dealloc];
}


@end

