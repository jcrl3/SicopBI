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
   [[NSUserDefaults standardUserDefaults] setObject:@"MuestraMensajes" forKey:kAppValorPantallaActual];
   [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   
   
   ///notificacion para el control de cancelaciones el timer de verificacion de mensajes en background
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCancelaTimerMensajesChat:) name:kCancelaTimerMensajesChat object:nil];
   
   ///notificacion para el control de cancelaciones el timer de verificacion de mensajes en background iniciar
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkIniciaTimerMensajesChat:) name:kIniciaTimerMensajesChat object:nil];
   
   //Cargamos los mensajes disponibles en la bd
   
   [self cargaMensajesGrabados];
   
   //Revisamos los nuevos mensajes recibidos
   enProcesoDelectura=FALSE;
   [self revisarChat];
   
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
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   static NSString *CellIdentifier = @"MessageCellIdentifier";
   msjViewTableCell *cell = (msjViewTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
   Mensaje* msj = [conversacion objectAtIndex:[indexPath row]];
   // msj.mensaje=[msj.mensaje stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   msj.fecha=[msj.fecha stringByReplacingOccurrencesOfString:@"\n" withString:@""];                 
   msj.idEnviado =[msj.idEnviado stringByReplacingOccurrencesOfString:@"\n" withString:@""];                 
   
   
   if (cell == nil) {
      //		cell = [[[msjViewTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
      cell = [[[msjViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
   
   if (msj.idEnviado==nil){
      return cell;
   }
   
   cell.accessoryType = UITableViewCellAccessoryNone;
	cell.userInteractionEnabled = NO;
   
   CGSize  size;
   CGSize  textSize = { 260.0, 10000.0 };
   size = [msj.mensaje sizeWithFont:[UIFont boldSystemFontOfSize:13]
                  constrainedToSize:textSize 
                      lineBreakMode:UILineBreakModeWordWrap];
   
	size.width += (padding/2);
	cell.messageContentView.text =	msj.mensaje;
   UIImage *bgImage = nil;
   
   if ([msj.idEnviado isEqualToString: appDelegate.usuarioActivo.IdProspecto] ){//Vendedor
      if ([msj.enviado isEqualToString:@"1"]){
         bgImage = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
      }else{
         bgImage = [[UIImage imageNamed:@"aquaDisabled.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
      }
		
		[cell.messageContentView setFrame:CGRectMake(320 - size.width - padding, 
                                                   padding*2, 
                                                   size.width, 
                                                   size.height)];
		
		[cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2, 
                                            cell.messageContentView.frame.origin.y - padding/2, 
                                            size.width+padding, 
                                            size.height+padding)];
   }else{
      
      bgImage = [[UIImage imageNamed:@"orange.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
		
		[cell.messageContentView setFrame:CGRectMake(padding, padding*2, size.width, size.height)];
		
		[cell.bgImageView setFrame:CGRectMake( cell.messageContentView.frame.origin.x - padding/2, 
                                            cell.messageContentView.frame.origin.y - padding/2, 
                                            size.width+padding, 
                                            size.height+padding)];
   }
   
   cell.bgImageView.image = bgImage;
	cell.senderAndTimeLabel.text = [NSString stringWithFormat:@"%@ ", msj.fecha];
   cell.senderAndTimeLabel.backgroundColor= self.tableView.backgroundColor;
   cell.senderAndTimeLabel.textColor = [UIColor whiteColor];
   cell.sender.text= msj.remitente;
   cell.sender.backgroundColor= self.tableView.backgroundColor;
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   
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
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   //   NSString* tipoMsj= appDelegate.getStringTipoMsj;
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaEnvioMensajes];
   NSURL *url = [NSURL URLWithString:urlString]; 
   
   //Si hay internet, el mensaje lo envio de forma directa por WS
   
   if (appDelegate.internetActive==TRUE && appDelegate.hostActive==TRUE){  
      ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: url]; 
      [request setPostValue:msjContexto.tipo forKey: @"Tipo"]; 
      [request setPostValue:msjContexto.idMensaje forKey:@"IdMensaje"];
      [request setPostValue:appDelegate.usuarioActivo.IdProspecto forKey: @"IdEnviado"]; 
      [request setPostValue:txtMensaje.text forKey: @"Mensaje"];
      [request setRequestMethod:@"POST"];
      [request startSynchronous]; 
      
      NSError *error = [request error]; 
      if(!error) { 
         NSLog(@"Sending data well!"); 
         txtMensaje.text=@"";
      }else { 
         NSLog(@"Sending data wrongly"); 
      } 
      
      if (enProcesoDelectura==FALSE){
         [self revisarChat];
      }
      
   }else{  //sino, lo guardo en la base de datos para su posterior envio
      
      NSString* fechaMSj = [[NSString alloc] init];
      Mensaje *nvoMsj = [[Mensaje alloc] init];
      
      NSDateFormatter *df = [[NSDateFormatter alloc ]init];
      [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
      fechaMSj = [df stringFromDate:[NSDate date]];
      
      
      nvoMsj.fecha=fechaMSj;
      nvoMsj.idEnviado= appDelegate.usuarioActivo.IdProspecto;
      nvoMsj.mensaje=txtMensaje.text;  
      nvoMsj.IdMensaje= msjContexto.idMensaje;
      nvoMsj.tipo=msjContexto.tipo;
      nvoMsj.leido=@"1";
      nvoMsj.idDistribuidor = appDelegate.usuarioActivo.IdDistribuidor; 
      //Inserto el nuevo mensaje fuera de liner
      [appDelegate.datosMensajes insertaMensaje:nvoMsj fueraDelinea:TRUE];
      
      //Liberamos el  puntero
      [df release];
      [nvoMsj release];
      [fechaMSj release];
      txtMensaje.text=@"";
      
      if (enProcesoDelectura==FALSE){
         [self revisarChat];
      }
   }
   
   [txtMensaje resignFirstResponder];
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   
}

-(void)revisarChatTimer:(NSTimer*)theTimer{
   [self revisarChat];  
}
- (void)revisarChat{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   opTipoMensaje tipoMsjs;
   if  ([msjContexto.tipo isEqualToString:@"P"]){
      tipoMsjs= opDeVentas;
   }else{
      tipoMsjs= opDeQuejas;
   }
   
   if (enProcesoDelectura==TRUE){
      return;
   }
   //genero un observador para cuando la carga de los mensajes se haya realizad
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCargaMensajes:) name:@"kProcesoCargaMensajestNotificacion" object:nil];
   
   enProcesoDelectura=TRUE;
   
   [self cancelarTimer];
   
   appDelegate.tipoMensajeRecuperar=tipoMsjs;
   
   fechaConsulta = [appDelegate.datosMensajes getUltimaFechaConsultaConversacion:msjContexto.idMensaje];
   [appDelegate verificaMensajes:fechaConsulta  idConversacion:msjContexto.idMensaje];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
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
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__); 
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   BOOL mandaSonido; 
   
   if (appDelegate.hostActive==TRUE && appDelegate.internetActive==TRUE){
      self.conversacion= [[NSMutableArray  alloc] init];
      self.conversacion= appDelegate.platica;
      
      mandaSonido=FALSE;   
      //por cada uno de los mensajes los grabo en la BD.
      for (Mensaje  *msj   in conversacion){
         if (msj.idMensaje!=nil){  
            msj.tipo=msjContexto.tipo;
            msj.leido=@"1";
            msj.idDistribuidor= appDelegate.usuarioActivo.IdDistribuidor; 
            [appDelegate.datosMensajes insertaMensaje:msj fueraDelinea:NO];
            
            if (msj.idEnviado != appDelegate.usuarioActivo.IdProspecto){
               mandaSonido=TRUE;
            }
            
         }
      }
      
      if (mandaSonido==TRUE && appDelegate.sonido_msj==TRUE){
         Sonido *sonido=[[[Sonido alloc] init] autorelease];
         [sonido reproduceSonido];
      }
      
      if (mandaSonido==TRUE && appDelegate.vibrar_msj==TRUE){
         Sonido *vibrar=[[[Sonido alloc] init] autorelease];
         [vibrar vibrar];
      }
      
      
      if (fechaConsulta==@"" || fechaConsulta==nil){
         fechaConsulta=@"2011-10-08 20:30:56.0";
      }
      
      //Cargo los mensajes de la base de datos
   }
   
   self.conversacion= [[NSMutableArray alloc]init ];
   self.conversacion=[appDelegate.datosMensajes getMensajes:msjContexto.idMensaje];
   
   [[self tableView] reloadData];
   NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([conversacion count]- 1) inSection:0];
   [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
   
   ///Creacion del timer
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(revisarChatTimer:) userInfo:nil repeats:YES];
   self.tiempoChecaSw = timer;
   
   [[NSNotificationCenter defaultCenter] addObserver:self 
                                            selector:@selector(keyboardWillShow:) 
                                                name:UIKeyboardWillShowNotification 
                                              object:nil];
   
   [[NSNotificationCenter defaultCenter] addObserver:self 
                                            selector:@selector(keyboardWillHide:) 
                                                name:UIKeyboardWillHideNotification 
                                              object:nil];		
   
   
   ///notificacion para el control de cancelaciones el timer de verificacion de mensajes en background
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCancelaTimerMensajesChat:) name:kCancelaTimerMensajesChat object:nil];
   
   ///notificacion para el control de cancelaciones el timer de verificacion de mensajes en background iniciar
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkIniciaTimerMensajesChat:) name:kIniciaTimerMensajesChat object:nil];
   
   enProcesoDelectura=FALSE;
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
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
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaParticipantes];
   NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL Participantes \n %@", url);
   
   //Si los participantes son iguale a cero entonces agregamos los participantes
   if (appDelegate.internetActive==TRUE && appDelegate.hostActive==TRUE){  
      if ([[appDelegate  datosParticipantes]existenParticipantes:msjContexto.idMensaje]!=TRUE  ){
         
         // [msjContexto.tipo isEqualToString:@"Q"]
         
         ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: url]; 
         [request setPostValue:msjContexto.idMensaje forKey: @"IdMensaje"]; 
         [request setRequestMethod:@"POST"];
         [request startSynchronous]; 
         
         NSError *error = [request error]; 
         
         if(!error) { 
            NSString *response = [request responseString];
            NSLog(@"RES %@" ,  response);
            
            if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
               [appDelegate muestraAlertNoConexion:@"Hubo un error en la transferencia de datos."];
               return;
            }
            
            [appDelegate parseoRequestExitoso:request nombreClase:@"Participantes"];
            NSMutableArray *participantes = [[NSMutableArray alloc]init] ;
            participantes= appDelegate.platica;
            
            //grabamos los nuevos mensajes en la base de datos
            for (Participantes *part in participantes) {
               if (part.IdEjecutivo!=nil ){
                  [[appDelegate datosParticipantes] insertaParticipante:part];
               }
            }
            [participantes release];
            
         }else{
            NSLog(@"Sending data wrongly"); 
         }
         
      }
   }
   
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   
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
