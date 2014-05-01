//
//  SurveyAppDelegate.m
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "SurveyAppDelegate.h"
#import "Reachability.h"
#import "RootViewController.h"
#import "DetailViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h" 
#import "ASIHTTPRequestDelegate.h" 


@implementation SurveyAppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;
@synthesize internetActive;
@synthesize hostActive;
@synthesize request;
@synthesize elementosParser;
@synthesize enProcesoDeEnvio;
@synthesize urlServicios;
Reachability* internetReachable;
Reachability* hostReachable;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
   // checamos la conexión a internet
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];

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

    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)defaultsChanged:(NSNotification *)notification {
    // Get the user defaults
    //Validamos la URL para probar los servicios web
    
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    
    //Validamos si el acuerdo legal ya fue aceptado
    kUrlServicios=[defaults stringForKey:@"url_servicios"];
    self.urlServicios=kUrlServicios;
    self.urlServicios=@"https://www.sicopweb.com/web/services/mobile";
    
    NSLog(@"URL %@", kUrlServicios);
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
 kUrlServicios=[[NSUserDefaults standardUserDefaults] stringForKey:@"url_servicios"];
    kUrlServicios=@"https://www.sicopweb.com/web/services/mobile";
    NSLog(@"URL %@", kUrlServicios);
    
    self.urlServicios=kUrlServicios;

}
- (void)applicationWillTerminate:(UIApplication *)application {
    NSData *serializedData;
	NSString *error;
	
	serializedData= [NSPropertyListSerialization
					 dataFromPropertyList:rootViewController.surveyDataArray 
					 format:NSPropertyListXMLFormat_v1_0 
					 errorDescription:&error];
	
	
	if (serializedData)
	{
		NSArray *documentDirectoryPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docDir =[NSString stringWithFormat:@"%@/prospectos.xml", [documentDirectoryPath objectAtIndex:0]];
		
		[serializedData writeToFile:docDir atomically:YES];
	}
	else 
	
	{
		NSLog(@"Error: %@", error);
	}

self.enProcesoDeEnvio = FALSE;
self.rootViewController=nil;
self.detailViewController=nil;

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
   
   
//   if( self.internetActive==YES && self.hostActive==YES) {
     //enviamos notificación para cambio de estatus en la red
    [[NSNotificationCenter defaultCenter] postNotificationName: @"NotificaCambiaStatusRed" object:nil userInfo:nil];        
  // }

   
}

#pragma mark -
#pragma mark Rutina para mensajes de alerta
-(void) muestraAlerta:(NSString*) pMensaje{
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SICOP Eventos" message:pMensaje
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
   
   [alert show];
   [alert release];

}
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   [request setDelegate:nil]; // CLEAR REQUEST 
   [request cancel]; 
   [request release]; 
   [splitViewController release];
   [window release];
   [super dealloc];
}

#pragma mark -
#pragma mark Rutina para envio de prospectos a servicio web

-(BOOL) enviaProspectosPendientes:(Evento*) pEventoActual{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

   BOOL codigoError=FALSE;

   if ( pEventoActual.idEvento == nil || [pEventoActual.idEvento isEqualToString:@""]) {
      //return TRUE;
      codigoError=TRUE;

   }

   //   BOOL codigoError=FALSE;
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaEnvioProspecto];
   NSURL *url = [NSURL URLWithString:urlString]; 
   datProspecto* registrosPendientes= [[datProspecto alloc]init];
   NSMutableArray * prospectosPendientes= registrosPendientes.getListaProspectosPorEnviar;
   codigoError=TRUE;
  
   
   if ([prospectosPendientes count]>0){  
         if ([self validaLogin:pEventoActual.idEvento]==FALSE ){
         //    [self  muestraAlerta:@"No existe el id de Evento."];
         // return FALSE;
            codigoError=FALSE;
         }
         

         //if ([prospectosPendientes count]==0) {
          //  codigoError=TRUE;
        // }

         self.enProcesoDeEnvio=true;
       
       NSLog(@" %@", url);

       
         for (Prospecto *prosPendiente in prospectosPendientes){
            if (self.internetActive==TRUE && self.hostActive==TRUE ){  
               //Si hay internet, el mensaje lo envio de forma directa por WS
               request = [ASIFormDataRequest requestWithURL: url]; 
               if (prosPendiente.idSicop!=nil && [prosPendiente.idSicop isEqualToString:@""]==FALSE ){
                 [request setPostValue:prosPendiente.idSicop forKey: @"IdRegistro"]; 
               }   
               [request setPostValue:prosPendiente.lineaInteres forKey:@"IdAuto"];
               [request setPostValue:prosPendiente.ejecutivoAsignado forKey:@"IdEjecutivo"];
               [request setPostValue:prosPendiente.primerNombre forKey:@"Nombre"];
               [request setPostValue:prosPendiente.segundoNombre forKey:@"ApellidoPaterno"];
               [request setPostValue:prosPendiente.tercerNombre forKey:@"ApellidoMaterno"];
               [request setPostValue:prosPendiente.telefono forKey:@"Telefono"];
			   [request setPostValue:prosPendiente.telefonoMovil forKey:@"Celular"];
               [request setPostValue:prosPendiente.correo forKey:@"Mail"];
               [request setPostValue:prosPendiente.cp forKey:@"CP"];
               [request setPostValue:prosPendiente.observaciones forKey:@"Observaciones"];
               [request setPostValue:prosPendiente.deseaCotizacion forKey:@"DeseaCotización"];
               [request setPostValue:prosPendiente.hizoPruebaDeManejo forKey:@"HizoPrueba"];
               [request setPostValue:prosPendiente.deseaPruebaDeManejo forKey:@"DeseaPrueba"];
               [request setPostValue:prosPendiente.interesadoAccesorios forKey: @"Accesorios"];
               [request setPostValue:prosPendiente.idDistribuidor forKey:@"IdDistribuidor"];
               [request setPostValue:pEventoActual.idFuente forKey:@"IdFuente"];
               [request setPostValue:pEventoActual.idSubcampana forKey:	@"IdSubcampana"];
               [request setPostValue:pEventoActual.idEvento forKey:	@"IdEvento"];
               [request setRequestMethod:@"POST"];
               [request startSynchronous]; 

              // [request startAsynchronous];
              
               NSError *error = [request error]; 
               codigoError=FALSE;

               if(!error) { 
                     //BOrramos el mensaje enviado
                     NSString *response = [request responseString];
                     NSLog(@" %@", response); 

                     //Extraemmo el id del prospecto
                     NSString* idprospecto= [self getCadenaEnOtraCadena:response cadenaAbuscar:@"IdProspecto"];  
                     
                     if ([idprospecto isEqualToString:@"NO_ECONTRADO"]==FALSE ||  [response ExistePalabraEnCadena:@"editado"]==TRUE){
                          [registrosPendientes marcaProspectoComoEnviado:prosPendiente.idRegistro];
                          [registrosPendientes estableceIdSicop:prosPendiente.idRegistro idSicop:idprospecto];
                          codigoError=TRUE;
                     }            
               
                 }else { 
                     NSLog(@"Sending data wrongly");

                     break;
               }
               
            }
            
         }

   [self cierraSesion];   
}
   
   self.enProcesoDeEnvio=false;
   [registrosPendientes release];

   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   [pool drain];

   return codigoError;
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
}   

#pragma mark -
#pragma mark - Rutina que extrae el id del prospecto
-(NSString*) getCadenaEnOtraCadena:(NSString*) cadenaBusqueda  cadenaAbuscar:(NSString*) pcadenaAbuscar {
   
   NSString* cadenaRetorno= [[[NSString alloc] init]autorelease];
   
   NSRange rangoBusqueda = NSMakeRange(0, [cadenaBusqueda length]); 
   BOOL mantenerBusqueda = YES;
   cadenaRetorno=@"NO_ECONTRADO";   
   
   while (mantenerBusqueda) {
      NSRange idProspectoSicop = [cadenaBusqueda rangeOfString:pcadenaAbuscar options:NSCaseInsensitiveSearch range:rangoBusqueda];
      
      if (idProspectoSicop.location != NSNotFound) {
         int posicion = idProspectoSicop.location + 12;
         cadenaRetorno = [cadenaBusqueda substringWithRange:NSMakeRange(posicion, 15)];
         NSLog(@"Valor cadena: %@", cadenaRetorno);
         rangoBusqueda = NSMakeRange(0, 1);
      } else {
         mantenerBusqueda = NO;
      }
   }

   return cadenaRetorno;
}

#pragma mark -
#pragma mark Rutina de apertura de sesiòn

-(BOOL) validaLogin: (NSString*) idEvento{

      NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);     
      NSString *urlString= [kUrlServicios stringByAppendingString: kRamaLogin];
      
//      if ([self internetActive]==YES && [self hostActive]==YES) {
         
         NSURL *url = [NSURL URLWithString:urlString]; 
         
         NSLog(@"Url Login %@",url  );
         NSLog(@"ID evento  %@", idEvento);
         
         request = [ASIFormDataRequest requestWithURL: url]; 
         [request setPostValue:idEvento forKey: @"IdEvento"]; 
         [request setRequestMethod:@"POST"];
         
         [request startSynchronous];
         
         NSError *error = [request error]; 
         if (!error) { 
            NSString *response = [request responseString];
            NSLog(@" %@", response); 
            
              if ([response ExistePalabraEnCadena:@"correctamente"]==TRUE){
                  return TRUE;
                }
          }else { 
            NSLog(@"Sending data wrongly"); 
      } 
      
      
NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);     
 return FALSE;
}

#pragma mark -
#pragma mark Rutina cierre sesion
-(void) cierraSesion{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);     
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaCierraLogin];
   
   if ([self internetActive]==YES && [self hostActive]==YES) {
      
      NSURL *url = [NSURL URLWithString:urlString]; 
      
      
      request = [ASIFormDataRequest requestWithURL: url]; 
      [request setRequestMethod:@"POST"];
      
      [request startSynchronous];
      
      NSError *error = [request error]; 
      if (!error) { 
         NSString *response = [request responseString];
         NSLog(@" %@", response); 
         
      }else { 
         NSLog(@"Sending data wrongly"); 
      } 
   }
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);     
}


-(NSMutableArray*) verificaEvento:(NSString*) pIdEvento {
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaInfoEvento];
   NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL de definición del evento \n %@", url);
   NSMutableArray *Eventos = [[[NSMutableArray alloc]init] autorelease]; 
   
   //Si los participantes son iguale a cero entonces agregamos los participantes
   if (self.internetActive==TRUE && self.hostActive==TRUE){  

        request = [ASIFormDataRequest requestWithURL: url]; 
         [request setPostValue:pIdEvento forKey: @"IdEvento"]; 
         [request setRequestMethod:@"POST"];
         [request startSynchronous]; 
         
         NSError *error = [request error]; 
         
         if(!error) { 
            NSString *response = [request responseString];
            NSLog(@"RES %@" , response);
            
            if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
               [self muestraAlerta:@"Hubo un error en la transferencia de datos."];
              // return ;
            }
  
            [self parseoRequestExitoso:request nombreClase:@"Evento"];
              Eventos= self.elementosParser;
            
         }else{
            NSLog(@"Sending data wrongly"); 
         }
         
      }
   
   return Eventos;
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   

}


///Rutina que obtiene la lista de vendedores del evento
-(NSMutableArray*) verificaVendedoresEvento:(NSString*) pIdEvento{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaEjecutivosEvento];
   NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL Participantes \n %@", url);
   NSMutableArray *ejecutivos = [[[NSMutableArray alloc]init] autorelease]; 

   //Si los participantes son iguale a cero entonces agregamos los participantes
   if (self.internetActive==TRUE && self.hostActive==TRUE){  
      
      request = [ASIFormDataRequest requestWithURL: url]; 
      [request setPostValue:pIdEvento forKey: @"IdEvento"]; 
      [request setRequestMethod:@"POST"];
      [request startSynchronous]; 
      
      NSError *error = [request error]; 
      
      if(!error) { 
         NSString *response = [request responseString];
         NSLog(@"RES %@" , response);
         
         if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
            [self muestraAlerta:@"Hubo un error en la transferencia de datos."];
//            return;
         }
         
         [self parseoRequestExitoso:request nombreClase:@"Ejecutivo"];
          ejecutivos= self.elementosParser;
         
      }else{
         NSLog(@"Sending data wrongly"); 
      }
      
   }
   
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   return ejecutivos;
}
-(NSMutableArray*) verificaAutosEvento:(NSString*) pIdEvento{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaAutosEvento];
   NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL Autos \n %@", url);
   NSMutableArray *autos = [[[NSMutableArray alloc]init] autorelease];  

   //Si los participantes son iguale a cero entonces agregamos los participantes
   if (self.internetActive==TRUE && self.hostActive==TRUE){  
      
      request = [ASIFormDataRequest requestWithURL: url]; 
      [request setPostValue:pIdEvento forKey: @"IdEvento"]; 
      [request setRequestMethod:@"POST"];
      [request startSynchronous]; 
      
      NSError *error = [request error]; 
      
      if(!error) { 
         NSString *response = [request responseString];
         NSLog(@"RES %@" , response);
         
         if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
            [self muestraAlerta:@"Hubo un error en la transferencia de datos."];
            //return;
         }

           [self parseoRequestExitoso:request nombreClase:@"Autos"];
           autos= self.elementosParser;
      
       }else{
         NSLog(@"Sending data wrongly"); 
      }
      
   }
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   return autos;
}


-(NSMutableArray*) verificaDistribuidoresEvento:(NSString*) pIdEvento{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaDistribuidoresEvento];
                         NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL Autos \n %@", url);
   NSMutableArray *distribuidores = [[[NSMutableArray alloc]init] autorelease];  
   
   //Si los participantes son iguale a cero entonces agregamos los participantes
   if (self.internetActive==TRUE && self.hostActive==TRUE){  
      
      request = [ASIFormDataRequest requestWithURL: url]; 
      [request setPostValue:pIdEvento forKey: @"IdEvento"]; 
      [request setRequestMethod:@"POST"];
      [request startSynchronous]; 
      
      NSError *error = [request error]; 
      
      if(!error) { 
         NSString *response = [request responseString];
         NSLog(@"RES %@" , response);
         
         if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
            [self muestraAlerta:@"Hubo un error en la transferencia de datos."];
            //return;
         }
         
         [self parseoRequestExitoso:request nombreClase:@"Distribuidor"];
         distribuidores= self.elementosParser;
         
      }else{
         NSLog(@"Sending data wrongly"); 
      }
      
   }
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
   return distribuidores;
}


-(void) getNombreEjecutivo:(NSString*) pIdEjecutivo objEjecutivo:(EjecutivoComplemento*) pObjEjecutivo{
   
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
   
   NSString *urlString= [kUrlServicios stringByAppendingString: kRamaNombreEjecutivo];
   NSURL *url = [NSURL URLWithString:urlString]; 
   NSLog(@"URL Autos \n %@", url);
   
   
   if (self.internetActive==TRUE && self.hostActive==TRUE){  
      
      request = [ASIFormDataRequest requestWithURL: url]; 
      [request setPostValue:pIdEjecutivo forKey: @"IdEjecutivo"]; 
      [request setRequestMethod:@"POST"];
      [request startSynchronous]; 
      
      NSError *error = [request error]; 
      
      if(!error) { 
         NSString *response = [request responseString];
         NSLog(@"RES %@" , response);
         
         if ([response ExistePalabraEnCadena:@"<state>1</state>"]==TRUE){
            [self muestraAlerta:@"Hubo un error en la transferencia de datos."];
            //return;
         }
         
         [self parseoRequestExitoso:request nombreClase:@"EjecutivoComplemento"];
         NSMutableArray *nombresEjecutivos = self.elementosParser;
         
          for (EjecutivoComplemento *ejctvo in nombresEjecutivos) {
               pObjEjecutivo.nombre= ejctvo.nombre;
               pObjEjecutivo.idDistribuidor= ejctvo.idDistribuidor;
           }
            
         
      }else{
         NSLog(@"Sending data wrongly"); 
      }
      
   }
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);

   
   
   
   
}


#pragma mark-
#pragma mark rutinas de parseo y cancelacón del proceso de request
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

-(void) checkCancelaRequest:(NSNotification *)notice{
   if (request.inProgress==TRUE) {
      [request clearDelegatesAndCancel];
   }  
   
}
- (void)requestFinished:(ASIFormDataRequest *)requestParsear{
   BOOL finExistoso;
   NSData *xmlData = [[NSMutableData alloc] init];
   xmlData= [requestParsear responseData];
   NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
   XMLParser *parser = [[XMLParser alloc] initXMLParser];
   
   //Establezco el delegate
   parser.nmClaseDatos=@"Mensaje";
   [xmlParser setDelegate:parser];
   finExistoso= [xmlParser parse];
   
   
   if(finExistoso){
      //notificar
		NSLog(@"No hubo errores en el parser del resultado de %@", parser.nmClaseDatos);
      
   }else{
      NSLog(@"Error Error Error!!!");
   }
   
   [xmlData release];
   [xmlParser release];
   [parser release];
   
}

- (void)requestFailed:(ASIFormDataRequest *)requestParsear{
   NSError *error = [requestParsear error];
   [self muestraAlerta:@"Error al momento de recuperar datos del servidor."];
   NSLog(@"Descripcion del error en el request %@", error.description);
}

#pragma mark -
#pragma mark Rutina de validación de entrada de datos

-(BOOL) validaTextField:(NSCharacterSet*) serie  textovalidar:(NSString*) pTexttoValidar{
   
   for (int i = 0; i < [pTexttoValidar length]; i++) {
      unichar c = [pTexttoValidar characterAtIndex:i];
      if (![serie characterIsMember:c]) {
         return NO;
      }
   }
   
   return YES;
}


@end

