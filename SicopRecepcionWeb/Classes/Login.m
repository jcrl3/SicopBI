//
//  Login.m
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 02/12/11.
//  Copyright (c) 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import "Login.h"
#import "SicopRecepcionAppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"

@implementation Login
@synthesize txtCorreo;
@synthesize txtPassword;
@synthesize scrollView;

NSString * const kProcesoLoginNotificacion = @"kProcesoLoginNotificacion";

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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkProcesoLogin:) name:kProcesoLoginNotificacion object:nil];
    
    
    appDelegate = (SicopRecepcionAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.txtCorreo=nil;
    self.txtPassword=nil;
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    txtCorreo.text=appDelegate.mailActivo;
    
    if (appDelegate.usuarioEstabaLoggeado==TRUE && appDelegate.usuarioLoggeado==FALSE){;
        txtPassword.text= appDelegate.passwordUser;
    }
    
    self.title=@"Login";
    
}
- (void)viewDidAppear:(BOOL)animated{
    if (appDelegate.usuarioEstabaLoggeado==TRUE && appDelegate.usuarioLoggeado==FALSE){;
        [self login:self];
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //   return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)login:(id)sender{
    // sino mandamos el registros y esperamos repsuesta del servicio web
    [txtCorreo resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    NSString *mensajeError;
    mensajeError=@"";
    
    if ([txtCorreo.text isEqualToString:@""] || [txtCorreo.text length]==0){
        mensajeError=@"El correo esta vacío ";
    }
    if  ( [txtPassword.text isEqualToString:@""] || [txtPassword.text length]==0 ||  [txtPassword.text length]<3 ){
        mensajeError= [mensajeError stringByAppendingString:@"El password está vacio o menor a 8 caracteres"];
    }
    
    if (![mensajeError isEqual:@""]  ){
        [appDelegate muestraAlertNoConexion:mensajeError];
    }
    
    if (![mensajeError isEqual:@""]){
        return;
    }
    
    appDelegate.mailActivo=txtCorreo.text;
    appDelegate.passwordUser=txtPassword.text;
    
    if ([mensajeError isEqual:@""]){
        
        [self iniciaHud];
        [self performSelectorInBackground:@selector(enviaDatosEnDelegate) withObject:nil];
        [HUD show:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    //  appDelegate.usuarioLoggeado=TRUE;
    //   [self dismissModalViewControllerAnimated:YES];
}

#pragma -mark
#pragma fuciones para llamar a funciones de delegate pero  con soporte de UIViewProgress

-(void) enviaDatosEnDelegate{
    [appDelegate validarUsuario];
    [HUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) validaDatosEnDelegate{
    [appDelegate validarUsuario];
    [HUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma -mark
#pragma fuciones para ocultamiento del teclado
-(IBAction)doneEditing:(id)sender
{
    
    [sender resignFirstResponder];
}

-(IBAction)backgroundClick:(id)sender
{
    [txtCorreo resignFirstResponder];
    [txtPassword resignFirstResponder];
}


#pragma mark -
#pragma rutina de validacion del login
-(void) checkProcesoLogin:(NSNotification *)notice{
    if (appDelegate.usuarioLoggeado==FALSE){
        [appDelegate muestraAlertNoConexion:@"El usuario no existe o no ha confirmado su identidad"];
        appDelegate.mailActivo=@"";
        appDelegate.passwordUser=@"";
    }
    else{
        //    NSString *cadenaBienvenida=@"Bienvenido \n";
        //      cadenaBienvenida= [cadenaBienvenida stringByAppendingString:appDelegate.usuarioActivo.Prospecto];
        //Grabo que el usuario ya se loggeo
        
        [appDelegate muestraAlertNoConexion:@"Bienvenido"];
        [self dismissViewControllerAnimated:YES completion:NULL];
        [[NSNotificationCenter defaultCenter] postNotificationName:kProcesoLoginMuestraRecepcion object: nil];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
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
#pragma mark manejo del scroll del teclado


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //  [scrollView adjustOffsetToIdealIfNeeded];
}

-(void)resignTextView
{
    //	[txtCorreo resignFirstResponder];
    //  [txtPassword resignFirstResponder];
}

@end
