//
//  TablerosViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TablerosViewController.h"
#import "TableroMasterViewController.h"
#import "TableroCallCenterViewController.h"
#import "TableroIndicadoresViewController.h"

@interface TablerosViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingTableView;

@property (weak, nonatomic) IBOutlet UIView *UViewMenu;
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
	
	CGRect frm = _UViewMenu.frame;
	frm.size.width = 400;
	_UViewMenu.frame = frm;
	

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 53.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// 3. Add a label
	UILabel* headerLabel = [[UILabel alloc] init];
	headerLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 53);
	headerLabel.backgroundColor = [UIColor orangeColor];
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.font = [UIFont fontWithName:@"Arial" size:23.0];
	headerLabel.text = @"Snapshots";
	headerLabel.textAlignment = NSTextAlignmentLeft;
	
	// 5. Finally return
	return headerLabel;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	NSIndexPath *selectedRowIndex=[self.tableView indexPathForSelectedRow];
   /*
	//	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	TableroIndicadoresViewController *tableroIndicadores;
	TableroCallCenterViewController *tableroCallCenter;
	*/
	
	if ([segue.identifier isEqualToString:@"MuestraTablero"]){
		NSString* titleNextView = [listaTableros objectAtIndex:[selectedRowIndex row]];
		TableroMasterViewController *tablero = [segue destinationViewController];

      /*
		switch ([selectedRowIndex row]){
			case 0:
				[TableroMasterViewController setClassForStoryBoard:@"TableroIndicadoresViewController"];
				 tableroIndicadores = (TableroIndicadoresViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"TableroMaster"];
				tableroIndicadores.titleView = titleNextView;
				//[self presentViewController:tableroIndicadores animated:NO completion:^{}];
			    [[self navigationController] presentViewController:tableroIndicadores animated:YES completion:nil];
				break;
			
			case 1:
			
				[TableroMasterViewController setClassForStoryBoard:@"TableroCallCenterViewController"];
				 tableroCallCenter = (TableroCallCenterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"TableroMaster"];
				tableroCallCenter.titleView = titleNextView;
				
				[[self navigationController] presentViewController:tableroCallCenter animated:YES completion:nil];
				break;
		}*/
	
		tablero.titleView = titleNextView;
	}

}


@end
