//
//  ThirdViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//
#import "ThirdViewController.h"
#import "RootViewController.h"
#import "XMLParser.h"
#import "SicopRecepcionAppDelegate.h"


@interface ThirdViewController ()
- (void)configureView;
@end

@implementation ThirdViewController

@synthesize toolbar, barButton, popoverController, detailItem, detailDescriptionLabel;
@synthesize tableView;
@synthesize txtMensaje;
@synthesize  msjContexto;
@synthesize conversacion;
@synthesize tiempoChecaSw;
bool enProcesoDelectura;

SicopRecepcionAppDelegate *appDelegate;

static CGFloat padding = 20.0;

-(id) init
{
   if (self == [super init])
   {
      [[NSNotificationCenter defaultCenter] addObserver:self 
                                               selector:@selector(keyboardWillShow:) 
                                                   name:UIKeyboardWillShowNotification 
                                                 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
                                               selector:@selector(keyboardWillHide:) 
                                                   name:UIKeyboardWillHideNotification 
                                                 object:nil];		
   }
	return self;
}


#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem {
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }               
}


- (void)configureView {
    // Update the user interface for the detail item.
    detailDescriptionLabel.text = [detailItem description];   
}

#pragma mark -
#pragma mark Split view support

- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    UIBarButtonItem *first = nil;
    if (toolbar.items.count > 0) {
        first = [toolbar.items objectAtIndex:0];
    }
    
    if (![first.title isEqual:barButtonItem.title])  {
        barButtonItem.title = @"Usuarios";
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items insertObject:barButtonItem atIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        
        self.popoverController = pc;
    }
}

- (void)removeBarButtonItem {
    if (toolbar.items.count > 0) {
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        
        // Next line removed to fix bug: popoverController 
        // not dismissed in specific situations
        // self.popoverController = nil;
    }
}

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
   barButtonItem.title = @"Conversaciones";    
   NSMutableArray *items = [[toolbar items] mutableCopy];
   [items insertObject:barButtonItem atIndex:0];
   [toolbar setItems:items animated:YES];
   [items release];
   self.popoverController = pc;

}

- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem {

   NSMutableArray *items = [[toolbar items] mutableCopy];
   [items removeObjectAtIndex:0];
   [toolbar setItems:items animated:YES];
   [items release];
   self.popoverController = nil;


}

#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark View lifecycle
-(void) loadView{
   /*
   [[NSNotificationCenter defaultCenter] addObserver:self 
                                            selector:@selector(keyboardWillShow:) 
                                                name:UIKeyboardWillShowNotification 
                                              object:nil];
   
   [[NSNotificationCenter defaultCenter] addObserver:self 
                                            selector:@selector(keyboardWillHide:) 
                                                name:UIKeyboardWillHideNotification 
                                              object:nil];		
   
   
   self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
   //self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
   self.view.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
	
   containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -40, 750, 40)];
   
   containerTableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 750, 361)];
   containerTableView.backgroundColor=[UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
   
   txtMensaje = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 658, 40)];
   txtMensaje.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
   
	txtMensaje.minNumberOfLines = 1;
	txtMensaje.maxNumberOfLines = 6;
	txtMensaje.font = [UIFont systemFontOfSize:15.0f];
	txtMensaje.delegate = self;
   txtMensaje.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
   txtMensaje.backgroundColor = [UIColor whiteColor];
   txtMensaje.returnKeyType=UIReturnKeyDefault;
   
   self.tableView= [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, 660, 360)];
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   self.tableView.backgroundColor= self.view.backgroundColor ;
   self.tableView.delegate=self;
   self.tableView.dataSource=self;
   self.tableView.autoresizingMask=  UIViewAutoresizingFlexibleWidth ;
   
	// textView.animateHeightChange = NO; //turns off animation
   [self.view addSubview:containerTableView];
   [self.view addSubview:containerView];
   
   UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
   UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
   UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
   entryImageView.frame = CGRectMake(5, 0, 660, 40);
   entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   
   UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
   UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
   UIImageView *imageView = [[[UIImageView alloc] initWithImage:background] autorelease];
   imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
   imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   
   txtMensaje.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   
   // view hierachy
   [containerView addSubview:imageView];
   [containerView addSubview:txtMensaje];
   [containerView addSubview:entryImageView];
   
   [containerTableView addSubview:tableView];
   
   UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
   UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
   
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
   doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[doneBtn setTitle:@"Enviar" forState:UIControlStateNormal];
   
   [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
   doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
   doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
   
   [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(enviarMsj) forControlEvents:UIControlEventTouchUpInside];
   [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
   [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:doneBtn];
   
   containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
   containerTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   */ 

}

- (void)viewDidUnload {
    self.popoverController = nil;
    self.toolbar = nil;
    
    self.detailItem = nil;
    self.detailDescriptionLabel = nil;
    
    [super viewDidUnload];
}

-(void) viewDidLoad{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   
   
   appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
   //   txtMensaje.returnKeyType = UIReturnKeyDone;
   
   
   UIBarButtonItem* btnSalir=
   [[UIBarButtonItem alloc] 
    initWithTitle:@"Salir" style:UIBarButtonItemStyleBordered target:self action:@selector(salir:)];
   self.navigationItem.backBarButtonItem=btnSalir;
   [btnSalir release];
   
   
   if([msjContexto.tipo isEqualToString:@"P"]){  
      UIBarButtonItem* profileButton=
      [[UIBarButtonItem alloc] 
       initWithImage:[UIImage imageNamed:@"24-person.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(muestraPerfil:)];
      self.navigationItem.rightBarButtonItem=profileButton;
      [profileButton release];
   }
   
   //Verificamos integrantes
   //[self verificaParticipantes];  
   
   [super viewDidLoad]; 
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
 
   
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   
   
   
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [popoverController release];
    [toolbar release];
    
    [detailItem release];
    [detailDescriptionLabel release];
	

   
   [[self msjContexto] release];
   fechaConsulta=nil;
   [containerView release];
   [containerTableView release];
   [[self conversacion] release];
   [tableView release];
   [txtMensaje release];
   [appDelegate cancelarRequest];
   [self cancelarTimer];
   [super dealloc];
   [super dealloc];
}


#pragma mark -
#pragma mark - Manejo del tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [conversacion count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{   
   
   static NSString *CellIdentifier = @"MessageCellIdentifier";
   msjViewTableCell *cell = (msjViewTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
   Mensaje* msj = [self.conversacion objectAtIndex:[indexPath row]];
   
	CGSize  textSize = { 260.0, 10000.0 };
   CGSize size;
   size = [msj.mensaje sizeWithFont:[UIFont boldSystemFontOfSize:13]
                  constrainedToSize:textSize 
                      lineBreakMode:UILineBreakModeWordWrap];
	
	size.height += padding*2;
	
	CGFloat height = size.height < 65 ? 65 : size.height;
	return height;
	
}

#pragma mark-
#pragma mark procedimientos de envio y recepción de mensajes

- (IBAction) enviarMsj{
   
   
}

-(void)revisarChatTimer:(NSTimer*)theTimer{
   [self revisarChat];  
}
- (void)revisarChat{
}
//Cargar los mensajes de la base de datos, este proceso solo se ejecutara al cargar la forma
-(void) cargaMensajesGrabados{
   
   //self.conversacion= [[NSMutableArray alloc]init ];
   //self.conversacion=[appDelegate.datosMensajes getMensajes:msjContexto.idMensaje];
   //NSMutableArray *datos = [[NSMutableArray alloc] init];
   //datos=[appDelegate.datosMensajes getMensajes:msjContexto.idMensaje];
   
   //self.conversacion= [[NSMutableArray  alloc] init];
   //[self.conversacion addObjectsFromArray:datos];      
   //[datos release];
   
   //[[self tableView] reloadData];
  // NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([conversacion count]- 1) inSection:0];
   //[[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//Esta senctencia se ejecuta cuando la sentencia de parseo regresa que el proceso se termino
-(void) checkCargaMensajes:(NSNotification *)notice{
  
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   [textField resignFirstResponder];
   return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   //      [scrollView adjustOffsetToIdealIfNeeded];
}

-(void)resignTextView
{
	[txtMensaje resignFirstResponder];
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
   float diff = (growingTextView.frame.size.height - height);
   
	CGRect r = containerView.frame;
   r.size.height -= diff;
   r.origin.y += diff;
	containerView.frame = r;
}

-(IBAction)backgroundClick:(id)sender
{
   [txtMensaje resignFirstResponder];
   
}

#pragma mark -
#pragma mark validación de participantes

-(void) verificaParticipantes{
   
   // [self revisarChat];
}

#pragma mark -
#pragma mark -mostrar perfil

-(IBAction) muestraPerfil:(id)sender{
/*
   [appDelegate cancelarRequest];
   enProcesoDelectura=TRUE;
   DatosPerfil *datosPerfil = [[DatosPerfil alloc]   initWithNibName:@"DatosPerfil" bundle:nil];
   datosPerfil.title=@"Información";
   datosPerfil.perfil= [[appDelegate datosUsuario] getPerfilUsuario: msjContexto.remitente];
   [[self navigationController] pushViewController:datosPerfil animated:YES];  
   [datosPerfil release];	 
 */
}

#pragma mark -
#pragma mark -Salir de la pantalla
-(IBAction)salir:(id)sender{
   [self cancelarTimer];
   [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark -Manejo del teclado

-(void) keyboardWillShow:(NSNotification *)note{
   // get keyboard size and loctaion
	CGRect keyboardBounds;
   [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
   NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
   NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
   
   // Need to translate the bounds to account for rotation.
   keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
   
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
   containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
   [UIView setAnimationDuration:[duration doubleValue]];
   [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
   NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
   NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
   containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
   [UIView setAnimationDuration:[duration doubleValue]];
   [UIView setAnimationCurve:[curve intValue]];
   
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark cancelacion de timer desde el delegate
-(void) checkCancelaTimerMensajesChat:(NSNotification *)notice{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   
   [self cancelarTimer];
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
}

-(void) checkIniciaTimerMensajesChat:(NSNotification *)notice{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__); 
   enProcesoDelectura=FALSE;
   [self  revisarChat];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
}

-(void) cancelarTimer{
   if (tiempoChecaSw.isValid==TRUE){
      [tiempoChecaSw  invalidate];
      self.tiempoChecaSw=nil;
   }
   
}

@end
