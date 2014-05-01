//
//  AppDelegate.h
//  TabBarWithSplitViewAppDelegate
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "SicopRecepcionAppDelegate.h"
//#import "RootViewController.h"
//#import "EnhancedSplitViewController.h"
#import "Reachability.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import <unistd.h>
//#import "UAirship.h"
//#import "UAPush.h"
#import "Urls.h"
#import "FirstViewController.h"

NSString * const  Ksonido_msj=@"sonido_msj";
NSString * const  Kvibrar_msj=@"vibrar_msj";
NSString * const  Knotificaciones_air=@"notificaciones_air";
NSString * const kRecepcionMensajePush = @"kRecepcionMensajePush";
NSString * const kProcesoLoginMuestraRecepcion = @"kProcesoLoginMuestraRecepcion";


@implementation SicopRecepcionAppDelegate

@synthesize window;

// @synthesize tabBarController;
// @synthesize splitViewController;
// @synthesize rootViewController;
// @synthesize thirdViewController;
 
@synthesize elementosXml;

@synthesize internetActive;
@synthesize hostActive;
@synthesize usuarioLoggeado;
@synthesize usuarioEstabaLoggeado;
@synthesize uiddDevice;
@synthesize usuarioActivo;
@synthesize mailActivo;
@synthesize passwordUser;
@synthesize recibirAirPush;
@synthesize sonido_msj;
@synthesize vibrar_msj;
@synthesize request;

Reachability* internetReachable;
Reachability* hostReachable;
Urls *urlObj;
bool enProcesoDeEnvio;

#pragma mark -
#pragma mark Application lifecycle


+ (void) initialize {
    if ([self class] == [SicopRecepcionAppDelegate class]) {
        
    }
}

- (void)defaultsChanged:(NSNotification *)notification {
    // Get the user defaults
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    sonido_msj =[defaults boolForKey: Ksonido_msj];
    vibrar_msj= [defaults boolForKey: Kvibrar_msj];
    recibirAirPush=[defaults boolForKey: Knotificaciones_air];
    
    if (uiddDevice==nil){
        InfoDispositivo *dispositivo=[[InfoDispositivo alloc]init];
        uiddDevice= [dispositivo getIdDispositivo];
        //  [[NSUserDefaults standardUserDefaults] setObject:uiddDevice forKey:kAppValorUIDD];
        [dispositivo release];
    }
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    urlObj= [[Urls alloc] init];
    
    // checamos la conexión a internet
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    // integramos un observador para los cambios eb settings
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(defaultsChanged:)
                   name:NSUserDefaultsDidChangeNotification
                 object:nil];
    
    
    
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];
    
    // checamos si la pagina de answerspip esta disponible
    hostReachable = [[Reachability reachabilityWithHostName: @"www.sicopweb.com"] retain];
    [hostReachable startNotifier];
    
    
    //Iniciar las opciones de  lanzamiento de airship
   /*
    NSMutableDictionary *takeOffOptions = [[[NSMutableDictionary alloc] init] autorelease];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    
    //Se toman los datos del AirshipConfig.plist para la conexiòn con los servidores y se utilizan para obtener el token
    [UAirship takeOff:takeOffOptions];
    [[UAPush shared] resetBadge];//zero badge on startup
    [[UAPush shared] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert)];
    */
    
	// Set the tab bar controller as the window's root view controller and display.
    
    //self.window.rootViewController = self->mainView;
    //[self.window makeKeyAndVisible];
    
    
    FirstViewController *mainView = [[FirstViewController alloc] initWithNibName:@"FirstView" bundle:nil];
    self.window.rootViewController = mainView;
    [self.window makeKeyAndVisible];
    
    
    ///Controlar mensajes push
    if (launchOptions != nil)
	{
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
		}
	}
    
    return YES;
}



- (BOOL)isPortrait {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
 // Optional UITabBarControllerDelegate method
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
 }
 */

/*
 // Optional UITabBarControllerDelegate method
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
 }
 */

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
   [super dealloc];
}


#pragma mark -
#pragma mark procedimiento para validaciòn de estatus de la red
- (void) checkNetworkStatus:(NSNotification *)notice
{
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            NSLog(@"No hay conexión a internet.");
            
            self.internetActive = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"El internet esta disponible via WIFI.");
            self.internetActive = YES;
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"El internet esta disponible via WWAN.");
            self.internetActive = YES;
            
            break;
            
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            
            self.hostActive = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive = YES;
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive = YES;
            
            break;
            
        }
    }
}

#pragma mark -
#pragma mark utilidades

-(void) muestraAlertNoConexion:(NSString*) pMensaje{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sicop" message:pMensaje
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    [alert release];
}


#pragma mark -
#pragma mark procedimientos de validaciòn de usuarios

-(void) validarUsuario {
    NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
    NSString *urlString= [kUrlServicios stringByAppendingString: kRamaLogin];
    
    if ([self internetActive]==YES && [self hostActive]==YES) {
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSLog(@"Url Login %@",url  );
        
        request = [ASIFormDataRequest requestWithURL: url];
        [request setPostValue:self.mailActivo forKey: @"Login"];
        [request setPostValue:self.passwordUser forKey: @"Password"];
        [request setPostValue:@"1" forKey:@"isTablet"];
        [request setRequestMethod:@"POST"];
        
        [request startSynchronous];
        
        NSError *error = [request error];
        if (!error){
            NSString *response = [request responseString];
            NSLog(@" %@", response);
            if ([response ExistePalabraEnCadena:@"<state>0</state>"]==TRUE ){
                
                BOOL success =  [self parseoRequestExitoso: request nombreClase: @"UserApp"];
                
                if(success){
                    self->usuarioLoggeado=TRUE;
                    
                    
                    for (UserApp *user in elementosXml) {
                        if (user.IdEjecutivo!=nil){
                            self->usuarioActivo =user;
                        }
                    }
                    
                }
                
            }
            
            if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
                self->usuarioLoggeado =FALSE;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"kProcesoLoginNotificacion" object: nil];
            
        }
        
        else
        {
            NSLog(@"Sending data wrongly");
        }
        
        
        
    }else{
        [self  muestraAlertNoConexion:@"No existe conexión a internet"];
    }
    
    NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
    
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

-(void) iniciaHud{
    // HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // [self.navigationController.view addSubview:HUD];
    // HUD.delegate = self;
}


#pragma mark-
#pragma mark rutinas de parseo
-(BOOL) parseoRequestExitoso:(ASIFormDataRequest*) requestParsear nombreClase:(NSString*) pNombreClase{
    BOOL finExistoso;
    
    NSData *xmlData = [[NSMutableData alloc] init];
    xmlData= [requestParsear responseData];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData] ;
    XMLParser *parser = [[XMLParser alloc] initXMLParser] ;
    
    //Establezco el delegate
    parser.nmClaseDatos=pNombreClase;
    [xmlParser setDelegate:parser];
    finExistoso= [xmlParser parse];
    
    [xmlData release];
    // [parser release];
    // [xmlParser release];
    return  finExistoso;
}


-(void) cancelarRequest{
    NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
    [[self request] clearDelegatesAndCancel];
    NSLog(@">>> sSaliendo %s <<<", __PRETTY_FUNCTION__);
}


/*
 - (void)agregaMensajeDeNotificacionPush:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
 {
 NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
 
 Fecha = valorfecha;
 IdMensaje = "p-1234";
 IdEnviado = 809967655;
 Mensaje = "Hola te mande la cotizacion";
 Tipo = Q;
 "_" = "MqBywj1VEeGB+RT+tdMfCA";
 aps =     {
 alert = "Tienes un nuevo mensaje";
 badge = 1;
 sound = "default.caf";
 };
 
 
 
 NSString* idMensaje = [userInfo valueForKey:@"IdMensaje"];
 NSString* mensaje = [userInfo valueForKey:@"Mensaje"];
 NSString* tipo = [userInfo valueForKey:@"Tipo"];
 NSString* idEnviado = [userInfo valueForKey:@"IdEnviado"];
 NSString* fecha = [userInfo valueForKey:@"Fecha"];
 
 NSLog(@"IdMensaje %@", idMensaje);
 NSLog(@"mensaje %@", mensaje);
 NSLog(@"tipo %@", tipo);
 
 //Si el mensaje es diferente de nil, entonces lo vamos a agregar a la tabla de conversaciones
 if (idMensaje!=nil){
 
 Mensaje  *msjPush=[[Mensaje alloc] init];
 msjPush.idMensaje= idMensaje;
 msjPush.mensaje= mensaje;
 msjPush.idEnviado= idEnviado;
 msjPush.tipo= tipo;
 msjPush.fecha=fecha;
 msjPush.leido=@"0";
 //  msjPush.idDistribuidor= self.usuarioActivo.IdDistribuidor;
 //    [datosMensajes insertaMensaje: msjPush fueraDelinea:NO];
 [msjPush release];
 
 if (updateUI)
 if([tipo isEqualToString:@"P"]){
 NSLog(@"Cargar las pantalla de conversaciones normales");
 NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"P" forKey:@"tipo"];
 [[NSNotificationCenter defaultCenter] postNotificationName:kRecepcionMensajePush object:nil userInfo:userInfo];
 
 }else if ([tipo isEqualToString:@"Q"]) {
 NSLog(@"Cergar la pantalla de quejas");
 NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Q" forKey:@"tipo"];
 [[NSNotificationCenter defaultCenter] postNotificationName:kRecepcionMensajePush object:nil userInfo:userInfo];
 }
 
 }
 
 NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
 
 }
 
 */

@end

