//
//  TablerosViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "TablerosViewController.h"

@interface TablerosViewController ()


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
	TableroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableroCell"];

	if (cell == nil) {
		cell = [[TableroTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableroCell"];
	}

	cell.imagenTablero.image=[UIImage imageNamed:@"ImagenTablero"];
	cell.tituloTablero.text=[listaTableros objectAtIndex:[indexPath row]];
	cell.descripcionTablero.text=[descripcionTableros objectAtIndex:[indexPath row]];


	return cell;
	
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
