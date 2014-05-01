//
//  DetailViewController.m
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "SurveyAppDelegate.h"
#import "InfoViewController.h"

NSString * const kCargaDeEventoNotificacion = @"kCargaDeEventoNotificacion";
NSString *const mensajeNoConfigurado=@"Atención, no existe evento configurado";
NSString* lineaInteresSel;
NSString* ejecutivoSel;
bool nuevoRegistro;

SurveyAppDelegate *appDelegate;


@interface DetailViewController ()

@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController
@synthesize evento;
@synthesize toolbar, popoverController, detailItem;
@synthesize primerNombreTextField, segundoNombreTextField;
@synthesize tercerNombreTextField, telefonoTextField, correoTextField, observaciones, pickerView;
@synthesize ejecutivoAsignado, hizoPrueba, deseaPrueba, deseaCotizacion, interesadoAccesorios, codigoPostal;
@synthesize infoButton;
@synthesize infoPopover;
@synthesize mensajeMailLabel;
@synthesize numeroRegistros;
@synthesize arrayLineas;
@synthesize arrayEjecutivos;
@synthesize mensajeEventoNoConfigurado;
@synthesize idRegistroActual;
@synthesize disclaimer;
@synthesize botonDisclaimer;
@synthesize imagenStatusRed;
@synthesize urlLabel;
@synthesize telefonoMovilTextField;
@synthesize deseaSerContactado;
#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 010DRFTGKDS
 */
- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
         detailItem = [newDetailItem retain];
        [self configureView];
    }
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
}


- (void)configureView {
   //Se colocan los datos del diccionario en las cajas de texto
    self.urlLabel.text=appDelegate.urlServicios;
 	NSString *idlinea					=[detailItem objectForKey:@"renglonLinea"];
	NSString *idEjecutivo				=[detailItem objectForKey:@"renglonEjecutivo"];
	NSString *indexDeseaPrueba			=[detailItem objectForKey:@"deseaPruebaDeManejo"];
    NSString *indexHizoPrueba			=[detailItem objectForKey:@"hizoPruebaDeManejo"];
	NSString *indexDeseaCotizacion		=[detailItem objectForKey:@"deseaCotizacion"];
	NSString *indexInteresadoAccesorios	=[detailItem objectForKey:@"interesadoAccesorios"];
    NSString *indexDeseaSerContactado	=[detailItem objectForKey:@"autorizaContacto"];

	
	self.primerNombreTextField.text					= [detailItem objectForKey:@"primerNombre"];
	self.segundoNombreTextField.text				= [detailItem objectForKey:@"segundoNombre"];
	self.tercerNombreTextField.text					= [detailItem objectForKey:@"tercerNombre"];
	self.telefonoTextField.text						= [detailItem objectForKey:@"telefono"];
	self.telefonoMovilTextField.text				= [detailItem objectForKey:@"telefonoMovil"];
	self.correoTextField.text						= [detailItem objectForKey:@"correo"];
	self.observaciones.text							= [detailItem objectForKey:@"observaciones"];
	self.deseaPrueba.selectedSegmentIndex			= [indexDeseaPrueba intValue];
	self.hizoPrueba.selectedSegmentIndex			= [indexHizoPrueba intValue];
	self.deseaCotizacion.selectedSegmentIndex		= [indexDeseaCotizacion intValue];
    self.interesadoAccesorios.selectedSegmentIndex	= [indexInteresadoAccesorios intValue];
    self.deseaSerContactado.selectedSegmentIndex	= [indexDeseaSerContactado intValue];
	self.codigoPostal.text							= [detailItem objectForKey:@"codigoPostal"];
	self.idRegistroActual.text						= [detailItem objectForKey:@"idRegistro"];
   
	[self.pickerView selectRow:[idlinea intValue] inComponent:0 animated:NO];
	[self.ejecutivoAsignado selectRow:[idEjecutivo intValue] inComponent:0 animated:NO];
   
   lineaInteresSel=[self.arrayLineas objectAtIndex:[idlinea intValue]];
   ejecutivoSel= [self.arrayEjecutivos objectAtIndex:[idEjecutivo intValue]];
   nuevoRegistro=FALSE;
    
   [self.ejecutivoAsignado setUserInteractionEnabled:FALSE];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Prospectos capturados";    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
	 self.title=@"SICOP: Registro de prospectos";
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void) viewWillAppear:(BOOL)animated{
    self.urlLabel.text=appDelegate.urlServicios;
   [super viewWillAppear:YES];
}

- (void)viewDidLoad {
   [super viewDidLoad];
      self.disclaimer.text= @"";
   //Control de notificaciones para habilitar o deshabilitar el icono que muetstra el status en la red   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checaStatusRed:) name:@"NotificaCambiaStatusRed" object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(checkCargaEvento:)
                                                name:kCargaDeEventoNotificacion
                                              object:nil];



   appDelegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];

   [self cargaConfiguracionEvento];
   
    self.pickerView.showsSelectionIndicator			=TRUE;
    self.ejecutivoAsignado.showsSelectionIndicator	=TRUE;
	self.primerNombreTextField.placeholder			=@"Nombre";
	self.segundoNombreTextField.placeholder			=@"Apellido paterno";
	self.tercerNombreTextField.placeholder			=@"Apellido Materno";
	self.telefonoTextField.placeholder				=@"Teléfono";
	self.telefonoMovilTextField.placeholder			=@"Teléfono móvil";
	self.correoTextField.placeholder				=@"Correo electrónico";
	self.codigoPostal.placeholder					=@"Código postal";
    self.observaciones.editable						=TRUE;
	
	[self limpiaCampos];
   
    appDelegate.rootViewController.title=@"Prospectos capturados";
    self.urlLabel.text=appDelegate.urlServicios;
	baseDeCps = [[DatCodigoPostal alloc] init];

	

}


- (void)viewDidUnload {
   [super viewDidUnload];
	self.toolbar =nil;
	self.primerNombreTextField=nil;
	self.segundoNombreTextField=nil;
	self.tercerNombreTextField=nil;
	self.telefonoTextField=nil;
	self.correoTextField=nil;
	self.observaciones=nil;
	self.pickerView=nil;
	self.ejecutivoAsignado=nil;
	self.hizoPrueba=nil;
	self.deseaPrueba=nil;
	self.deseaCotizacion=nil;
	self.interesadoAccesorios=nil;
	self.infoButton=nil;
	self.infoPopover=nil;
	self.codigoPostal=nil;
	self.mensajeMailLabel=nil;
	self.numeroRegistros=nil;
	self.mensajeEventoNoConfigurado=nil;
	self.disclaimer=nil;
	self.botonDisclaimer=nil;
	self.imagenStatusRed=nil;
	self.telefonoMovilTextField=nil;
	self.deseaSerContactado=nil;
	
}

- (void)dealloc {
   [baseDeCps release];
   [appDelegate cancelarRequest];
   //[self.evento release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];   
}

#pragma mark -
#pragma mark Memory management

- (void)handleSegmentClick:(id)sender {

   UISegmentedControl *sc = (UISegmentedControl *)sender;
   NSInteger index = sc.selectedSegmentIndex;
	
	//cuando Index =0, significa SI
	//cuando Index=1 significa NO
	
    if (sc==hizoPrueba){
        if (index==1){		 
            self.deseaPrueba.selectedSegmentIndex=0;	 
            self.deseaPrueba.hidden=YES;
         }
        
        if (index == 0 ){
            self.deseaPrueba.selectedSegmentIndex=1;
            self.deseaPrueba.hidden=NO;
         }
    }
}

-(IBAction)hizoPruebaDemo:(id)sender
{
    // NSLog(@"valor de hizo prueba &d",self.hizoPrueba.value );
}

-(IBAction)clearSurvey:(id)sender{
	NSLog(@"Se oprimio el boton limpiar survey");
	[self limpiaCampos];
}

-(void) limpiaCampos{
    self.urlLabel.text=appDelegate.urlServicios;
    self.idRegistroActual.text=@"";
	self.primerNombreTextField.text=@"";
	self.segundoNombreTextField.text=@"";
	self.tercerNombreTextField.text=@"";
	self.telefonoTextField.text=@"";
	self.telefonoMovilTextField.text=@"";
	self.correoTextField.text=@"";
	self.deseaPrueba.selectedSegmentIndex=0;
	self.hizoPrueba.selectedSegmentIndex=0;
	self.deseaCotizacion.selectedSegmentIndex=0;
	self.interesadoAccesorios.selectedSegmentIndex=0;
	self.deseaSerContactado.selectedSegmentIndex=1;
	self.observaciones.text=@"";
	self.codigoPostal.text=@"";
    lineaInteresSel=[self.arrayLineas objectAtIndex:0];
    ejecutivoSel=[self.arrayEjecutivos objectAtIndex:0];
	[self.pickerView selectRow:0 inComponent:0 animated:YES];
	[self.ejecutivoAsignado selectRow:0 inComponent:0 animated:YES];
	[self.ejecutivoAsignado setUserInteractionEnabled:TRUE];
	nuevoRegistro=TRUE;
	self.codigoPostal.textColor=[UIColor blackColor];
	self.codigoPostal.backgroundColor=[UIColor whiteColor];
	self.correoTextField.textColor=[UIColor blackColor];
	self.correoTextField.backgroundColor=[UIColor whiteColor];

}



-(IBAction)addSurvey:(id)sender
{
	NSLog(@"Se oprimio el boton grabar survey");  
/*
   if ( [self.mensajeEventoNoConfigurado.text isEqualToString: mensajeNoConfigurado] || self.evento.activo!=TRUE){
       [self showVentanaConfigEvento];
       return;
    }*/
  
   NSString* mensajeError; //=[[NSString alloc] initWithString:@""];
     datProspecto* insertaPros= [[datProspecto alloc] init];     
      Prospecto* prosNvo= [[Prospecto alloc] init]; 
   
		prosNvo.idRegistro=self.idRegistroActual.text;
		prosNvo.primerNombre=[self.primerNombreTextField.text uppercaseString];
		prosNvo.segundoNombre=[self.segundoNombreTextField.text uppercaseString];
		prosNvo.tercerNombre=[self.tercerNombreTextField.text uppercaseString];
		prosNvo.correo= self.correoTextField.text ;
		prosNvo.telefono=self.telefonoTextField.text;
		prosNvo.telefonoMovil=self.telefonoMovilTextField.text;
		prosNvo.hizoPruebaDeManejo=[NSString stringWithFormat:@"%d", hizoPrueba.selectedSegmentIndex];
		prosNvo.deseaPruebaDeManejo=[NSString stringWithFormat:@"%d", deseaPrueba.selectedSegmentIndex];
		prosNvo.deseaCotizacion=[NSString stringWithFormat:@"%d", deseaCotizacion.selectedSegmentIndex];
		prosNvo.interesadoAccesorios=[NSString stringWithFormat:@"%d", interesadoAccesorios.selectedSegmentIndex];
		prosNvo.renglonEjecutivo=[NSString stringWithFormat:@"%d", [ejecutivoAsignado selectedRowInComponent:0]];
		prosNvo.renglonLinea=[NSString stringWithFormat:@"%d", [self.pickerView selectedRowInComponent:0]];
		prosNvo.observaciones=[self.observaciones.text uppercaseString];
		prosNvo.cp=self.codigoPostal.text;
    	prosNvo.autorizaContacto= [NSString stringWithFormat:@"%d", self.deseaSerContactado.selectedSegmentIndex];
		prosNvo.lineaInteres= lineaInteresSel;
		prosNvo.ejecutivoAsignado= ejecutivoSel;
   
      //Si el prospecto se pudo grabar de forma correcta
	
      if ([prosNvo.idRegistro isEqualToString:@""]){
            mensajeError=[insertaPros insertaProspecto:prosNvo];
         }else{
            mensajeError=[insertaPros actualizaProspecto:prosNvo];
      }
	
     if ([mensajeError isEqualToString: @""]) {
      RootViewController* rvc=appDelegate.rootViewController;
      
         if ([prosNvo.idRegistro isEqualToString:@""]){
           prosNvo.idRegistro= [insertaPros getIdUltimoRegistroCapturado];
           rvc.title=@"Prospectos capturados";
           [rvc addSurveyToDataArray:[insertaPros obtenerDatosDiccionario:prosNvo]];
           [insertaPros grabarDatosEnXml:rvc.surveyDataArray];
         }else{
            //recargamos nuevamente todos los prospectos capturados en el arreglo de pricipal
            [rvc.surveyDataArray removeAllObjects];
           
			 
            NSMutableArray* prospectos=[insertaPros getListaProspectos];
            for(Prospecto *registro in prospectos){
               [rvc addSurveyToDataArray:[insertaPros obtenerDatosDiccionario:registro]];
               [insertaPros grabarDatosEnXml:rvc.surveyDataArray];
            }
            
         }
         
               
         if (appDelegate.internetActive && appDelegate.hostActive && appDelegate.enProcesoDeEnvio!=TRUE ) {
            [appDelegate enviaProspectosPendientes:self.evento];
         }
 
        [appDelegate muestraAlerta:@"Prospecto guardado de forma correcta."];
        [self limpiaCampos];

      
      }else{  
      
        [appDelegate muestraAlerta:insertaPros.mensajeError];
      
   }
   
   self.numeroRegistros.text= [insertaPros getNumeroRegistrosCapturados];   
  // [mensajeError release];
   [prosNvo release];    
   [insertaPros release];   

}

#pragma mark -
#pragma mark muestra pantalla disclaimer

-(IBAction) showDisclaimer:(id)sender{
   Disclaimer *disclm = [[Disclaimer alloc] initWithNibName:@"Disclaimer" bundle:nil];
   disclm.nombreMarca=self.evento.idMarca;
   UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:disclm];
   navigationController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
   navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//   [self presentModalViewController:navigationController animated:YES];
	[self presentViewController:navigationController animated:YES completion:nil];
	
   [disclm release];	    
}


#pragma mark -
#pragma mark configurador de eventos

-(void) showVentanaConfigEvento{
   //Agregamos un control de notificaciones para cuando haya cambio en el catálogo de eventos

   ConfiguraEvento *configuraEvento = [[ConfiguraEvento alloc] initWithNibName:@"ConfiguraEvento" bundle:nil];
      configuraEvento.idEventoActual=self.evento;
      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:configuraEvento];
      navigationController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
      navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
	  [self presentViewController:navigationController animated:YES completion:nil];
      [configuraEvento release];	    
}
-(IBAction)configuraEvento:(id)sender{

   [self showVentanaConfigEvento];

}



-(void)showInfo:(id)sender{
	ConfiguraEvento *configuraEvento = [[ConfiguraEvento alloc] initWithNibName:@"ConfiguraEvento" bundle:nil];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:configuraEvento];
[configuraEvento release];
	
	
	self.infoPopover = popover;
	[popover release];
	
	[self.infoPopover presentPopoverFromRect:self.infoButton.frame
									  inView:self.view
					permittedArrowDirections: UIPopoverArrowDirectionRight animated:YES];
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	if (thePickerView==pickerView){
        return [self.arrayLineas count];
	  }else{
        return [self.arrayEjecutivos count];	 
    }
}



#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
	if (thePickerView==pickerView){
        return [self.arrayLineas objectAtIndex:row];
      }else{
		  return [self.arrayEjecutivos objectAtIndex:row];
    }
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

      if (thePickerView==pickerView){	   
             lineaInteresSel=[self.arrayLineas objectAtIndex:row];
         }else{
            if (nuevoRegistro){ 
              ejecutivoSel=[self.arrayEjecutivos objectAtIndex:row];
            }
      }
   
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}


#pragma mark -
#pragma mark - rutina de validacion de eventos
-(void) checkCargaEvento:(NSNotification *)notice{
   NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);
    //desactivo las notificaione una vez que se entra en el procedimeinto
   
  // [[NSNotificationCenter defaultCenter] removeObserver:self];   
  
   BOOL integroEvento;
   BOOL actualizoEvento;
   BOOL existeEvento;
   //objeto que controla los mensajes de error
   Error* infoError= [[[Error alloc]init] autorelease];
   Evento* infoEvento = [notice.userInfo objectForKey:@"eventoKey"];
   
   actualizoEvento=FALSE;
   if ([infoEvento.idEvento isEqualToString: self.evento.idEvento]){
      actualizoEvento=TRUE;

   }
   
   datProspecto* tblProspecto = [[datProspecto alloc]init];
   DatAutos* tblAutos = [[DatAutos alloc] init]; 
   DatEjecutivos* tblEjecutivos= [[DatEjecutivos alloc] init];
   DatEvento* tblEventos = [[DatEvento alloc] init];
   DatDistribuidor *tblDistribuidores =[[DatDistribuidor alloc] init];
   

/*
   NSMutableArray* eventoDefinicion = [[NSMutableArray alloc]init];
   NSMutableArray* autosEvento =  [[NSMutableArray alloc]init];
   NSMutableArray* ejecutivosEvento = [[NSMutableArray alloc]init];
   NSMutableArray* distribuidoresEvento = [[NSMutableArray alloc]init];
*/
   
   //2.-Consultar datos del evento tecleado
   NSLog(@"idEvento %@", infoEvento.idEvento);
   NSLog(@"password %@", infoEvento.passwordEvento);

   existeEvento=TRUE;
   integroEvento=FALSE;
   
   if ([appDelegate validaLogin:  infoEvento.idEvento ]==FALSE ){
      infoError.numeroError=1;
      infoError.mensajeDeError=@"No existe el id de Evento o existe \n un problema con su conexión de internet";
       existeEvento=FALSE;
   }
   
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
   
   if (existeEvento){  
         NSMutableArray* eventoDefinicion=[appDelegate verificaEvento:infoEvento.idEvento];
         NSMutableArray* ejecutivosEvento=[appDelegate verificaVendedoresEvento:infoEvento.idEvento];
         NSMutableArray* autosEvento=[appDelegate verificaAutosEvento:infoEvento.idEvento];
         NSMutableArray* distribuidoresEvento=[appDelegate verificaDistribuidoresEvento:infoEvento.idEvento];


         
         //si se cumplen los tres parametros del evento entonces indicamos el evnto se puede cargar
         if([eventoDefinicion count]>0 && [autosEvento count]>0 && [distribuidoresEvento count]>0){
              integroEvento=TRUE;
            }else{
            self.mensajeEventoNoConfigurado.text=mensajeNoConfigurado;  
             infoError.numeroError=1;  
             infoError.mensajeDeError=@"El evento no se encuentra configurado correctamente en SICOP-Web.";
           }
         
         
         //si el evento cumple con los requisitos para su integración entonces
         // Si el evento existe, 
         if (integroEvento) {
            //se borran los prospectos solo en caso de ser un evento nuevo, 
                  if (actualizoEvento!=TRUE){
                     [tblProspecto borraTablaProspectos];
                     NSMutableArray* array =[[NSMutableArray alloc] init];
                     appDelegate.rootViewController.surveyDataArray= array;
                     [tblProspecto grabarDatosEnXml:appDelegate.rootViewController.surveyDataArray];
                     [array release];
                     [appDelegate.rootViewController.tableView reloadData];
                  }
                  //a) Borramos los datos de la BD actual       
                   [tblAutos borraTablaAutos]; 
                   [tblEjecutivos borraTablaEjecutivos];
                   [tblEventos borraTablaEventos];

                    //b)  cargamos la configuración del evento y la integramos en la base de datos

                    //integramos configuracion
                    for (Evento *event in eventoDefinicion) {
                      if (event.idEvento!=nil ){
                        [tblEventos insertaEvento:event];
                      }
                    }
                  
                  //integramos distribuidores
                  for (Distribuidor *dist in distribuidoresEvento) {
                     if (dist.idDistribuidor!=nil ){
                        [tblDistribuidores insertaDistribuidor:dist];
                     }
                  }
               
                  
                  //integramos ejecutivos del evento
                     for (Ejecutivo *ejctvo in ejecutivosEvento) {
                        if (ejctvo.idEjecutivo!=nil ){
                           [tblEjecutivos insertaEjecutivo:ejctvo];
                        }
                     }
                  
                BOOL parametroQueIndicaSoloDistribuidores;
               parametroQueIndicaSoloDistribuidores=TRUE;
            
                   ///actualizamos los nombres de cada ejecutivo
                  for (Ejecutivo *ejctvo in ejecutivosEvento) {
                     if (ejctvo.idEjecutivo!=nil ){
                        EjecutivoComplemento* ejecutivoNombre= [[EjecutivoComplemento alloc] init];
                        [appDelegate getNombreEjecutivo:ejctvo.idEjecutivo objEjecutivo:ejecutivoNombre];
                        [tblEjecutivos actualizaEjecutivo:ejctvo.idEjecutivo objEjecutivo:ejecutivoNombre];
                        [ejecutivoNombre release];
                        parametroQueIndicaSoloDistribuidores=FALSE;
                     }
                  }
                
                  //insertamos a los distribuidores como ejecutivos
                  if (parametroQueIndicaSoloDistribuidores==TRUE){
                     //Integrlo los distrbuidores como ejecutivos de venta
                     for (Distribuidor *dist in distribuidoresEvento) {
                        if (dist.idDistribuidor!=nil ){
                           [tblEjecutivos insertaDistribuidorComoEjecutivo:dist];
                        }
                     }
                  }

                  //integramos autos
                     for (Autos *autoevent in autosEvento) {
                        if (autoevent.idAuto!=nil ){
                           [tblAutos  insertaAuto:autoevent];
                        }
                     }
            
                  infoError.numeroError=0;
                  infoError.mensajeDeError=@"El evento se encuentra configurado de manera correcta.";
                  
               if (actualizoEvento) {
                    infoError.mensajeDeError=@"Los parámetros del evento se guardaron de forma correcta";
                  }
                 
               self.mensajeEventoNoConfigurado.text=@"";
         }
        
            //liberamos los objetos utilizados como arreglos
        /* 
         [eventoDefinicion release];
         [autosEvento release];
         [ejecutivosEvento release];
         [distribuidoresEvento release];    
         */
         //liberamos los objetos de datos
         [tblProspecto release];
         [tblAutos release];
         [tblEjecutivos release];
         [tblEventos release];
         [tblDistribuidores release];
      
         if (infoError.numeroError==0){

             [self cargaConfiguracionEvento];
             [self.pickerView reloadAllComponents];
             [self.ejecutivoAsignado reloadAllComponents];
//             [self limpiaCampos];
          }
      
  }//Fin del if siexisteEvento 
       
         
   [pool drain];
   //Mandar objeto con el resultado del proces, meter un objeto que controle el error
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:infoError forKey:@"eventoMensaje"];
   [[NSNotificationCenter defaultCenter] postNotificationName: @"finalDeCargaDeEventoNotificacion" object: nil userInfo:userInfo];       
   
   NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__);
    
}

-(void) cargaConfiguracionEvento{
NSLog(@">>> Entrando %s <<<", __PRETTY_FUNCTION__);

   BOOL fechaInicioEnRango;
   BOOL fechaFinEnRango;

   datProspecto *bdSicop= [[datProspecto alloc] init]; 
   self.arrayLineas=bdSicop.getListaLineasParaPicker;
   self.arrayEjecutivos=bdSicop.getListaEjecutivosParaPicker;
   self.numeroRegistros.text= bdSicop.getNumeroRegistrosCapturados;
   
   DatEvento *datosEvento= [DatEvento alloc] ;
   Fechas* mngrFechas= [[Fechas alloc] init];
   
   //Iniciamos el objeto que contendra la informaciòn del evento configurado
//   self.evento=  [[Evento alloc] init];
   self.evento= [datosEvento getInfoEvento]; 

    if (self.evento.idEvento!=nil || [self.evento.idEvento isEqualToString:@" "] ){
            self.evento.activo=TRUE;
            ///detectamos las fechas del evento
            NSDate *hoy = [mngrFechas getFechaDeHoy];
            NSDate* fechaInicio= [mngrFechas getFechaDeString:self.evento.inicioEvento];
            NSDate* fechaFin = [mngrFechas getFechaDeString: self.evento.finEvento];
            

            if ([hoy compare:fechaInicio] == NSOrderedDescending) {
               fechaInicioEnRango=FALSE;
                NSLog(@"Hoy is later than FechaInicio");        
               
                } else if ([hoy compare:fechaInicio] == NSOrderedAscending) {
                 NSLog(@"Hoy is antes than fechaInicio");
                 fechaInicioEnRango=TRUE;      
                } else {
                 NSLog(@"dates are the same");
                 fechaInicioEnRango=TRUE;            
             }

            
            if ([hoy compare:fechaFin] == NSOrderedDescending) {
               fechaFinEnRango=FALSE;
               NSLog(@"Hoy is later than FechaInicio");        
              } else if ([hoy compare:fechaFin] == NSOrderedAscending) {
               NSLog(@"Hoy is antes than fechaInicio");
               fechaFinEnRango=TRUE;      
              } else {
               NSLog(@"dates are the same");
               fechaFinEnRango=TRUE;            
            }

            if (fechaInicioEnRango==TRUE || fechaFinEnRango==FALSE){
               self.evento.activo=FALSE; 
               //self.evento.activo=TRUE;  //cambiar por false al momento de produccciòn
            }
        }



      if (self.evento.idEvento!=nil) {
          self.mensajeEventoNoConfigurado.text=self.evento.nombreEvento;
          self.mensajeEventoNoConfigurado.textColor=[UIColor whiteColor];
         
          if (self.evento.activo!=TRUE){
            self.mensajeEventoNoConfigurado.text=@"El evento ha caducado.";
          }
         
        }else{
           self.mensajeEventoNoConfigurado.textColor=[UIColor redColor];
           self.mensajeEventoNoConfigurado.text=mensajeNoConfigurado;
      }

   
   
   [mngrFechas release];
   [datosEvento release];
	[bdSicop cierraBaseDeDatos];
   [bdSicop release];    
NSLog(@">>> Saliendo %s <<<", __PRETTY_FUNCTION__); 
}

#pragma -mark
#pragma fuciones para ocultamiento del teclado
-(IBAction)doneEditing:(id)sender{   
   [sender resignFirstResponder];
}

-(IBAction)backgroundClick:(id)sender{   
	[self.primerNombreTextField resignFirstResponder];
	[self.segundoNombreTextField resignFirstResponder];
	[self.tercerNombreTextField resignFirstResponder];
	[self.telefonoTextField resignFirstResponder];
	[self.correoTextField resignFirstResponder];
	[self.observaciones resignFirstResponder];
	[self.pickerView resignFirstResponder];
	[self.codigoPostal resignFirstResponder];
	[self.ejecutivoAsignado resignFirstResponder];
	[self.telefonoMovilTextField resignFirstResponder];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
   
   NSLog(@"NUMERO DE TAG %d", textField.tag);
   
   NSCharacterSet *unacceptedInput = nil;
   switch (textField.tag) {
         // Assuming EMAIL_TextField.tag == 1001
      
      case 1001:
      case 1002:
      case 1003:
         if (textField.text.length >= 30 && range.length == 0){
            return NO;
         }   
         unacceptedInput = [NSCharacterSet characterSetWithCharactersInString:[NUMERIC stringByAppendingString:@".!#$%&'*+-/=?^_`{|}~@"]]  ;
         break; 
         
      case 1006:
         if ( textField.text.length >= 5 && range.length == 0)  {
            return NO;
         }   
        unacceptedInput = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
		   
	    break;
      case 1005:
         if  (textField.text.length >= 60 && range.length == 0) {
            return NO;
         }   

         if ([[textField.text componentsSeparatedByString:@"@"] count] > 1){
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingString:@".-_"]] invertedSet] ;
            }else{
            unacceptedInput = [NSCharacterSet characterSetWithCharactersInString:@"!#$%&'*+/=?^`{|}~"] ;
         }
         break;

      case 1004:
         if (textField.text.length + string.length >= 13) {
            return NO;
         }
         unacceptedInput = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
         break;
		   
	   case 1007:
		   if (textField.text.length + string.length >= 13) {
			   return NO;
		   }
		   unacceptedInput = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
		   break;
		   
		   
         
      default:
         unacceptedInput = [[NSCharacterSet illegalCharacterSet] invertedSet];
         break;
         
   }

   return ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);

   
   //return YES;
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   NSCharacterSet *unacceptedInput = nil;
   
   unacceptedInput = [NSCharacterSet characterSetWithCharactersInString:@".!#$%&'*+-/=?^_`{|}~@"];

   if ( textView.text.length >= 100 && range.length == 0)  {
      return NO;
   }   
   return ([[text componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);
   
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
	NSString *existeCp;

	switch (textField.tag) {
		case 1005:
			if(![textField.text esCorrectoEmail:textField.text]){
			      textField.textColor=[UIColor whiteColor];
				  textField.backgroundColor=[UIColor redColor];
        		}else{
		        	textField.textColor=[UIColor blackColor];
					textField.backgroundColor=[UIColor whiteColor];
		        }
			break;
		case 1006:
			existeCp=[baseDeCps existeCodigoPostal:textField.text];
			if ([existeCp isEqualToString:@"NO"]){
					textField.textColor=[UIColor whiteColor];
					textField.backgroundColor=[UIColor redColor];
				}else{
		        	textField.textColor=[UIColor blackColor];
					textField.backgroundColor=[UIColor whiteColor];
			 }
			
			break;
	  }
}


#pragma mark -Rutina que habilita o deshabilita ela imágen del wireless
-(void) checaStatusRed:(NSNotification *)notice{
   NSString *pathAcceso;
   UIImage *imagenConexion;
   NSString* mensajeOriginal = mensajeEventoNoConfigurado.text;
    self.urlLabel.text=appDelegate.urlServicios;

   //&& appDelegate.hostActive
   datProspecto* prospectosPendientes= [[datProspecto alloc] init];     
  
   
   if (appDelegate.internetActive && appDelegate.hostActive){
         self.mensajeEventoNoConfigurado.text=@"Enviando prospectos..";
        pathAcceso =[[NSBundle mainBundle] pathForResource:@"WirelessOn" ofType:@"png"];
         imagenConexion = [UIImage imageWithContentsOfFile:pathAcceso];

      if ([prospectosPendientes getNumeroRegistrosPendientesPorEnviar]> 0){

         [appDelegate enviaProspectosPendientes:self.evento];
      }
      
   }else{
      
      pathAcceso =[[NSBundle mainBundle] pathForResource:@"WirelessOff2" ofType:@"png"];
      imagenConexion = [UIImage imageWithContentsOfFile:pathAcceso];
   }
    
   self.mensajeEventoNoConfigurado.text=mensajeOriginal; 
   self.imagenStatusRed.image=imagenConexion;

   [prospectosPendientes release];
   
}
      
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
   return YES;
}


@end
