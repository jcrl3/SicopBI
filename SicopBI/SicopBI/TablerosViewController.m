//
//  TablerosViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TablerosViewController.h"
#import "TableroVentasViewController.h"

@interface TablerosViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TablerosViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
	
	listaTableros= [[NSArray alloc] initWithObjects:
	 @"Indicadores de ventas",
	 @"Call center",	 nil];

	descripcionTableros= [[NSArray alloc] initWithObjects:
					@"Este tablero te permite visualizar los indicadores de prospección y ventas, permitiendote determinar si alcanzarás tus metas",
					@"Este tablero te permite visualizar la calidad de cartera registrada por los ejecutivos de venta",	 nil];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	[super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES];
	[super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Metodos deleagate del tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 return 95.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark -
#pragma mark Metodos datasource del tableview
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section
{
	return listaTableros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
	static NSString* cellIdenfier = @"TableroCell";
	
	TableroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];

	if (cell == nil) {
		cell = [[TableroTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdenfier];
	}

	cell.imagenTablero.image=[UIImage imageNamed:@"ImagenTablero"];
	cell.tituloTablero.text=[listaTableros objectAtIndex:[indexPath row]];
	cell.descripcionTablero.text=[descripcionTableros objectAtIndex:[indexPath row]];

	return cell;
	
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSIndexPath *selectedRowIndex=[self.tableView indexPathForCell:sender];

	if ([segue.identifier isEqualToString:@"MuestraTablero"]){
		NSString* titleNextView = [listaTableros objectAtIndex:[selectedRowIndex row]];
		//TableroVentasViewController *tablero = [segue destinationViewController];
		TableroVentasViewController *tablero = [segue destinationViewController];
		tablero.titleView = titleNextView;
	}

}


@end
