//
//  TabBarWithSplitViewAppDelegate.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FuncionesExtendidas.h"
#import "XMLParser.h"
#import "InfoDispositivo.h"
#import "Urls.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "MBProgressHUD.h"
#import "UserApp.h"
//#import "FirstViewController.h"


@class Reachability;
//@class EnhancedSplitViewController;
//@class RootViewController;
//@class ThirdViewController;


@interface SicopRecepcionAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIAlertViewDelegate, MBProgressHUDDelegate, ASIHTTPRequestDelegate> {
    
    UIWindow *window;
    
    ASIFormDataRequest *request;
    UserApp  *usuarioActivo;
    MBProgressHUD *HUD;
    
    NSMutableArray *elementosXml;

    
    NSString *mailActivo;
    NSString* passwordUser;
    NSString* uiddDevice;
    
    BOOL internetActive;
    BOOL hostActive;
    BOOL usuarioLoggeado;
    BOOL usuarioEstabaLoggeado;
    BOOL recibirAirPush;
    BOOL sonido_msj;
    BOOL vibrar_msj;

    
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain)  ASIFormDataRequest *request;
@property (nonatomic,retain)  NSMutableArray *elementosXml;
@property (nonatomic) BOOL    internetActive;
@property (nonatomic) BOOL    hostActive;
@property (nonatomic) BOOL    usuarioLoggeado;
@property (nonatomic) BOOL    usuarioEstabaLoggeado;

@property (nonatomic, retain)  NSString *mailActivo;
@property (nonatomic,retain)   NSString* passwordUser;
@property (nonatomic,retain)   NSString* uiddDevice;

@property (nonatomic)   BOOL   recibirAirPush;
@property (nonatomic)   BOOL   sonido_msj;
@property (nonatomic)   BOOL   vibrar_msj;
@property (nonatomic,retain)   UserApp *usuarioActivo;

-(void) checkNetworkStatus:(NSNotification *)notice;
-(void) muestraAlertNoConexion:(NSString*) pMensaje;
-(void) validarUsuario;
-(void) iniciaHud;
-(BOOL) parseoRequestExitoso:(ASIFormDataRequest*) request nombreClase:(NSString*) pNombreClase;
-(void) cancelarRequest;


extern NSString *const kProcesoLoginMuestraRecepcion;
extern NSString * const  Ksonido_msj;
extern NSString * const  Kvibrar_msj;
extern NSString * const  Knotificaciones_air;
extern NSString * const kRecepcionMensajePush;



@end
