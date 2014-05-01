//
//  FirstViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//
#import "FirstViewController.h"
#import "SicopRecepcionAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"


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
    webFrame.origin.y = 46.0;
    webFrame.origin.x = 1;
	webFrame.size.height -= 65.0;
    webFrame.size.width = self.view.bounds.size.width;
	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease];
	self.myWebView.backgroundColor = [UIColor blueColor];
	self.myWebView.scalesPageToFit = YES;
	self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.myWebView.delegate = self;
	[self.view addSubview:self.myWebView];
    
     NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:6];

    UIBarButtonItem *bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"37-circle-x"] style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    
    [buttons addObject:bi];
    [bi release];

     ///Espacio inicial para centrar los botones
      bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"36-circle-west"] style:UIBarButtonItemStylePlain target:self action:@selector(atras:)];
     
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
     bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"20-circle-east"] style:UIBarButtonItemStylePlain target:self action:@selector(adelante:)];
    [buttons addObject:bi];
    [bi release];
    
    //Espacio
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    bi.width=(self.view.bounds.size.width/2)-10;
    [buttons addObject:bi];
    [bi release];
    
    //titulo
    bi =[[UIBarButtonItem alloc] initWithTitle:@"SICOP" style:UIBarButtonItemStylePlain target:nil action:@selector(adelante:)];
    [buttons addObject:bi];
    [bi release];

    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil ];
    bi.width=(self.view.bounds.size.width/2)-20;
    [buttons addObject:bi];
    [bi release];
    
    //Salir
    bi =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"16-car"] style:UIBarButtonItemStylePlain target:self action:@selector(irOtraApp:)];
    
     [buttons addObject:bi];
     [bi release];
     
     //Customizo el toolbar
     
     toolBar = [[UIToolbar alloc] init];
     toolBar.barStyle = UIBarStyleDefault;
     //Meter diferrenciacion de ipad o iphone
     toolBar.frame = CGRectMake(0, 1, self.view.bounds.size.width, 50);
    
    
     toolBar.tintColor = self.navigationController.navigationBar.tintColor;
     [toolBar setItems:buttons animated:YES];
     
     // [toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
     
     toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
     
     [toolBar sizeToFit];
     [self.view addSubview:toolBar];
     [buttons release];
     [toolBar release];
     
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
      
         NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlFinal]];
         [requestObj setValue:@"Agente Mozilla/5.0 (iPad; CPU OS 6_0_1 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10A52" forHTTPHeaderField:@"User_Agent"];
        
       //  [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlFinal]]];
        
        [self.myWebView loadRequest:requestObj];
        
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
        return NO;
    }
}

#pragma mark -
#pragma mark -procedimientos de navegacion
-(IBAction) atras:(id)sender{
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

-(IBAction)logout:(id)sender{
    
    NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sicop" message:@"¿Deseas cerrar la sesión?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si",nil];
    [alert show];
    [alert release];
    
   
    
    NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

-(void) cerrarSesion{

    NSString *urlFinal= [kUrlServicios stringByAppendingString:kRamaLogout];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlFinal]]];
    [self.myWebView loadHTMLString:@"" baseURL:nil];
    appDelegate.usuarioLoggeado=FALSE;
    [[NSNotificationCenter defaultCenter] postNotificationName: kUsuarioLogeadoNotificacion object: nil];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Seleccion de NO.");
    }
    else if (buttonIndex == 1) {
        [self cerrarSesion];
    }
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
	return;
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
    NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"nipikdemo://"]];
    
 ///if ( appDelegate.internetActive==YES && appDelegate.hostActive==YES) {
    
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"nipikdemo://"]];
/*
    NSString *urlFinal= [kUrlServicios stringByAppendingString:kRamaEnvio];
    NSURL *url = [NSURL URLWithString:urlFinal];
    NSLog(@"Url Login %@",urlFinal);
    
    ASIFormDataRequest *request;
    request = [ASIFormDataRequest requestWithURL: url];
     
    NSLog(@" %@", [appDelegate.usuarioActivo.IdEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""] );
    [request setPostValue:[appDelegate.usuarioActivo.IdEjecutivo stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey: @"IdEjecutivo"];
    [request setPostValue:[appDelegate.usuarioActivo.BaseDeDatos stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey: @"BaseDeDatos"];
    [request setPostValue:[appDelegate.usuarioActivo.Servidor stringByReplacingOccurrencesOfString:@"\n" withString:@""]  forKey: @"Servidor"];

    [request setRequestMethod:@"POST"];
    [request startSynchronous];
     
    NSError *error = [request error];
    if (!error){
  
        NSString *response = [request responseString];
        NSLog(@" %@", response);
      
        if ([response ExistePalabraEnCadena:@"No existe ningún prospecto activo"]==TRUE    ){
              [appDelegate muestraAlertNoConexion:@"No existe ningún prospecto activo"];
            return;}
        else{
            //Si todo esta correcto, llamamos a la aplicación de nipik
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"nipikdemo://"]];
        }
    }
    else{
        [appDelegate muestraAlertNoConexion:@"No existe conexión a internet"];
    }
 }
  
  */
 //} NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}

@end
