//
//  FirstViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//
#import "FirstViewController.h"
#import "SicopRecepcionAppDelegate.h"

@implementation FirstViewController
@synthesize myWebView;
NSString * const kUsuarioLogeadoNotificacion = @"kUsuarioLogeadoNotificacion";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);       
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      self.title = @"Recepción";
      self.tabBarItem.image = [UIImage imageNamed:@"112-group"];
   }
   return self;
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);        
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);        
   [super viewDidLoad];

   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkProcesoLogin:) name:kProcesoLoginMuestraRecepcion object:nil];

   appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
   
   
   //Cofiguraciòn y comprobaciòn del login.
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(checkLoginUsuario:)
                                                name:kUsuarioLogeadoNotificacion
                                              object:nil];

   
   
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
//	webFrame.origin.y = 00.0;  //kTopMargin; leave from the URL input field and its label
 webFrame.origin.y = 48.0;  //kTopMargin; leave from the URL input field and its label
	webFrame.size.height -= 56.0;
	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease];
	self.myWebView.backgroundColor = [UIColor blueColor];
	self.myWebView.scalesPageToFit = YES;
	self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.myWebView.delegate = self;
	[self.view addSubview:self.myWebView];
   /*
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    ///Espacio inicial para centrar los botones
    UIBarButtonItem *bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"09-arrow-west"] style:UIBarButtonItemStylePlain target:self action:@selector(atras:)];
    
    [buttons addObject:bi];
    [bi release];
    
    //espacio
    bi = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    [bi release];
    
    //Refrescar
    bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"01-refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refrescar:)];
    
    [buttons addObject:bi];
    [bi release];
    
    //Espacio
    bi = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    [bi release];
    
    //Adelante
    bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"02-arrow-east"] style:UIBarButtonItemStylePlain target:self action:@selector(adelante:)];
    
    [buttons addObject:bi];
    [bi release];
    
    //Customizo el toolbar
    
    toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = 1;
    //Meter diferrenciacion de ipad o iphone
    toolBar.frame = CGRectMake(0, 436, 320, 50);
    toolBar.tintColor = self.navigationController.navigationBar.tintColor;
    [toolBar setItems:buttons animated:NO];
    
    // [toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [toolBar sizeToFit];
    [self.navigationController.view addSubview:toolBar];
    [buttons release];  
    [toolBar release];
    */
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);        
}

- (void)viewDidUnload
{
   [super viewDidUnload];
   // Release any retained subviews of the main view.
   // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);        
  
   if (appDelegate.usuarioLoggeado==TRUE){ 
         [super viewWillAppear:animated];
         self.myWebView.delegate = self;	// setup the delegate as the web view is shown
         NSString *urlFinal= [kUrlServicios stringByAppendingString:kRamaWorkspace];
         [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlFinal]]];  
     }
              
   
}

- (void)viewDidAppear:(BOOL)animated
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   
   [super viewDidAppear:animated];
   
   [[NSNotificationCenter defaultCenter] postNotificationName: kUsuarioLogeadoNotificacion object: nil];    
   
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);  
   
}

- (void)viewWillDisappear:(BOOL)animated
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);  
   
	[super viewWillDisappear:animated];
   [self.myWebView stopLoading];	// in case the web view is still loading its content
	self.myWebView.delegate = nil;	// disconnect the delegate as the webview is hidden
   //   [toolBar removeFromSuperview];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
   
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)dealloc
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);     
   [[NSNotificationCenter defaultCenter] removeObserver:self];
	myWebView.delegate = nil;
	[super dealloc];
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // Return YES for supported orientations
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
   } else {
      return YES;
   }
}

#pragma mark - 
#pragma mark -procedimientos de navegacion
-(IBAction)atras:(id)sender{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);    
   
   [self.myWebView goBack];
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);  
}

-(IBAction)adelante:(id)sender{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);     
   
   [self.myWebView goForward ];
   
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);        
}

-(IBAction)refrescar:(id)sender{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);        
   [self.myWebView reload];
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);     
}

#pragma mark -
#pragma mark - metodos del delegate del webview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);        
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
                            @"<html><center><font size=+5 color='red'>Un error ocurrio:<br>%@</font></center></html>",
                            error.localizedDescription];
	[self.myWebView loadHTMLString:errorString baseURL:nil];
   NSLog(@">>> Saiendo %s <<<", __PRETTY_FUNCTION__);        
}




#pragma mark -
#pragma mark - rutina de validacion del login
-(void) checkLoginUsuario:(NSNotification *)notice{
   if(appDelegate.usuarioLoggeado==NO){
      Login *login= [[Login alloc] initWithNibName:@"Login" bundle:nil];
      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:login];
      navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self  presentViewController:navigationController animated:YES completion:NULL];
       [login release];
   }
}

#pragma mark -
#pragma rutina de validacion y muestra de la pantalla de recepcion
-(void) checkProcesoLogin:(NSNotification *)notice{

   if (appDelegate.usuarioLoggeado==TRUE){ 
      self.myWebView.delegate = self;	// setup the delegate as the web view is shown
       NSString *urlFinal= [kUrlServicios stringByAppendingString:kRamaWorkspace];
      [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlFinal]]];  
   }
}

#pragma mark-
#pragma mark Ejecucion de otra app.

-(IBAction)irOtraApp:(id)sender{
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"nipik://"]];
}

@end
