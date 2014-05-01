//
//  RootViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "RootViewController.h"
#import "ThirdViewController.h"


@implementation RootViewController

@synthesize thirdViewController;
@synthesize titulo;
@synthesize  tvCell;
@synthesize conversaciones;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__); 
   [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
 
    appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
    conversaciones = [[NSMutableArray alloc] init ];
    self.title=@"Conversaciones";
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
}





// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
   aTableView.rowHeight = 63.5;
   return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   return [self.conversaciones count];
   
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   static NSString *CellIdentifier = @"Cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
   if (cell == nil) {
      
      NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InfoQueja"
                                                   owner:self options:nil];
      if ([nib count] > 0) {
         cell = self.tvCell;
      } else {
         NSLog(@"Fallo la carga del nib");
      }
   }
   cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
   cell.selectionStyle=UITableViewCellSelectionStyleGray;
   
   
   Mensaje *mensaje =[self.conversaciones objectAtIndex:[indexPath row]];
   
   UILabel *fechaLabel = (UILabel *)[cell viewWithTag:3];
   fechaLabel.text = mensaje.fecha;
   
   UITextView *comentario = (UITextView *)[cell viewWithTag:2];
   comentario.text =mensaje.mensaje;
   
   UILabel *remitente = (UILabel *)[cell viewWithTag:1];
   remitente.text =mensaje.remitente;
   
   if ([mensaje.enviado isEqualToString:@"0"]){
      comentario.font=[UIFont italicSystemFontOfSize:10];
   }
   
   UIImageView *imagen =(UIImageView *) [cell viewWithTag:0];   
   if ([mensaje.leido isEqualToString:@"0"]){
      [imagen setImage:[UIImage imageNamed:@"224-point_blue16.png"]];
      cell.backgroundColor= [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
   }else{
      [imagen setImage:[UIImage imageNamed:@"Conversacion.png"]]; 
      cell.backgroundColor= [UIColor yellowColor];
   }
   
   [imagen sizeToFit];
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);      
   return cell; 




}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   /*
   NSMutableString *tituloCell = [NSMutableString stringWithString: titulo];
   NSMutableString *renglon =[NSMutableString stringWithFormat: @" %d", indexPath.row];
   [tituloCell appendString: renglon];

   thirdViewController.detailItem = tituloCell;
   */
/*   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);    
   ThirdViewController *chat = [[ThirdViewController alloc]   initWithNibName:@"MuestraConversacion" bundle:nil];
   chat.title=@"Mensajes";
   Mensaje  *detalle= [[[Mensaje alloc] init] autorelease];;
   detalle=[conversaciones objectAtIndex:[indexPath row]];
   
   chat.msjContexto= detalle;
   [[appDelegate datosMensajes] marcaConversacionLeida: detalle.idMensaje]; 
   
   [self.navigationController pushViewController:chat   animated:YES];  
   [chat release];	
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);   
*/
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void) viewWillAppear:(BOOL)animated{
 NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   [super viewWillAppear:YES];
   thirdViewController.detailItem=@"Conversación";
 NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);     
}

-(void) viewDidAppear:(BOOL)animated{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
    [super viewDidAppear:animated];
    [self cargarEnzabezados]; 
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);   
}
- (void)viewDidUnload {
    self.thirdViewController = nil;
    self.tvCell=nil;
    [super viewDidUnload];
}

- (void)dealloc {
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   [conversaciones release];
   [super dealloc];
}


@end

