//
//  ConfiguraEvento.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 15/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "ConfiguraEvento.h"
NSString * const finalDeCargaDeEventoNotificacion = @"finalDeCargaDeEventoNotificacion";
SurveyAppDelegate *appDelegate;

@implementation ConfiguraEvento

@synthesize idEvento;
@synthesize idEventoActual;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   [super viewDidLoad];
   
 //  [self setContentSizeForViewInPopover:CGSizeMake(320, 800)];
   
   self.title=@"Configurar evento";
   
   UIBarButtonItem* aceptarButton= [[UIBarButtonItem alloc] initWithTitle:@"Aceptar" style:UIBarButtonItemStylePlain target:self action:@selector(cargarEvento:)];
   self.navigationItem.leftBarButtonItem=aceptarButton;
   [aceptarButton release];

   
   UIBarButtonItem* cancelarButton= [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:self action:@selector(cancelar:)];
   self.navigationItem.rightBarButtonItem=cancelarButton;
   [cancelarButton release];

   

   appDelegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
/*
   self.modalInPopover=TRUE;
   CGSize size;
	size.width=600;
	size.height=500;
	self.contentSizeForViewInPopover=size;
*/
   
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   self.idEvento=nil;

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   [appDelegate cancelarRequest];
   [super dealloc];
}




#pragma mark -
#pragma mark control de eventos de los botónes

-(IBAction)cancelar:(id)sender{
   self.idEvento=nil;
   [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self dismissViewControllerAnimated:NO completion:nil];
}
-(IBAction)cargarEvento:(id)sender{
  //Anexp los datos del user y pwd para que los procese la rutina de verificaciòn

   //1.-Validar si existen datos que no se han enviado al servidor
   //Si existen datos pendientes
   //Enviar al servidor
   //Enviamos los prospectos al servicio web
   if ([self.idEvento.text length]==0 || [self.idEvento.text ExistePalabraEnCadena:@" "]==TRUE ) {
      return;
   }  

   if ([appDelegate internetActive] && [appDelegate hostActive]) {
      
      //Agregamos un control de notificaciones para cuando haya cambio en el catálogo de eventos
      [[NSNotificationCenter defaultCenter] removeObserver:self];
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(finalizaCargaEvento:)
                                                   name:finalDeCargaDeEventoNotificacion
                                                 object:nil];


      
       HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
       [self.navigationController.view addSubview:HUD];
       HUD.delegate = self;
       HUD.labelText = @"Enviando información pendiente, espere...";
       sleep(1);
       [HUD showWhileExecuting:@selector(enviaProspectosEnDelegate) onTarget:self withObject:nil animated:YES];
    }else{
      [appDelegate muestraAlerta:@"No existe conexión a internet para configurar las encuestas"];
   }   
   
}

#pragma -mark
#pragma fuciones para llamar a funciones de delegate pero  con soporte de UIViewProgress

-(void) enviaProspectosEnDelegate{
   Evento* infoEvento= [[[Evento alloc]init] autorelease];
   infoEvento.idEvento=self.idEvento.text;
   
   if ([appDelegate enviaProspectosPendientes:self.idEventoActual]==TRUE){ // CABMBIAR EL FALSE POR EL TRUE EN CUANTO SE TENGA EL SW DE RECEPCION DE DATOS
      HUD.labelText = @"Cargando parámetros del evento...";
      sleep(1);
      NSDictionary *userInfo = [NSDictionary dictionaryWithObject:infoEvento forKey:@"eventoKey"];
      [[NSNotificationCenter defaultCenter] postNotificationName: @"kCargaDeEventoNotificacion" object:nil userInfo:userInfo];       
     }else{
      [appDelegate muestraAlerta:@"El evento no se puede configurar debido \n a que no se  han podido enviar los registros pendientes \n al servidor."];
   }
}
#pragma mark -
#pragma mark - rutina de validacion de eventos
-(void) finalizaCargaEvento:(NSNotification *)notice{
  //quitamos las notificaciones para evitar que el mensaje de alerta se muetsre en repetidas oaciones
      [[NSNotificationCenter defaultCenter] removeObserver:self];
  
   [appDelegate cierraSesion];
   Error* infoError = [notice.userInfo objectForKey:@"eventoMensaje"];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;

   HUD.labelText = @"Carga finalizada.";
   sleep(1);
   
    if (infoError.numeroError==0) {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SICOP Eventos" message:infoError.mensajeDeError
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
       [alert show];
       [alert release];
    }else{
       [appDelegate muestraAlerta:infoError.mensajeDeError];
    }
         

}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
   // Remove HUD from screen when the HUD was hidded
   [HUD removeFromSuperview];
   [HUD release];
	 HUD = nil;
}

-(void) iniciaHud{
   HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
   [self.view.window addSubview:HUD];
   HUD.delegate = self;
   HUD.labelText = @"Cargando";
   
}

#pragma mark -
#pragma mark manejo del alertview que se ejecuta cuando aparece el mensaje inidcando que todo esta ok
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self dismissViewControllerAnimated:NO completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
   return YES;
}

@end
