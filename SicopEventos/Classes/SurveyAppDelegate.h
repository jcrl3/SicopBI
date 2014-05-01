//
//  SurveyAppDelegate.h
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FuncionesExtendidas.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h" 
#import "ASIHTTPRequestDelegate.h" 
#import "MBProgressHUD.h"
#import "Urls.h"
#import "datProspecto.h"
#import "Prospecto.h"
#import "Autos.h"
#import "DatAutos.h"
#import "XMLParser.h"
#import "DatEvento.h"
#import "Evento.h"
#import "DatEjecutivos.h"
#import "Ejecutivo.h"
#import "EjecutivoComplemento.h"


@class RootViewController;
@class DetailViewController;

@interface SurveyAppDelegate : NSObject <UIApplicationDelegate,MBProgressHUDDelegate, ASIHTTPRequestDelegate> {
    
    UIWindow *window;
    NSString *urlServicios;
    UISplitViewController *splitViewController;
   
    ASIFormDataRequest *request;
    NSMutableArray *elementosParser;
   
    RootViewController *rootViewController;
    DetailViewController *detailViewController;
   BOOL internetActive;
   BOOL hostActive;
   BOOL enProcesoDeEnvio;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic) BOOL    internetActive;
@property (nonatomic) BOOL    hostActive;
@property (nonatomic) BOOL    enProcesoDeEnvio;
@property (nonatomic,retain)  ASIFormDataRequest *request;
@property (nonatomic, retain)    NSMutableArray *elementosParser;
@property (nonatomic,retain)     NSString *urlServicios;

-(BOOL) enviaProspectosPendientes:(Evento*) pEventoActual;
-(BOOL) parseoRequestExitoso:(ASIFormDataRequest*) requestParsear nombreClase:(NSString*) pNombreClase;
-(void) cancelarRequest;
-(void) checkCancelaRequest:(NSNotification *)notice;
-(void)requestFinished:(ASIFormDataRequest *)requestParsear;
-(void)requestFailed:(ASIFormDataRequest *)requestParsear;
-(void) muestraAlerta:(NSString*) pMensaje;
-(BOOL) validaLogin: (NSString*) idEvento;
-(void) cierraSesion;
-(NSMutableArray*) verificaEvento:(NSString*) pIdEvento;
-(NSMutableArray*) verificaVendedoresEvento:(NSString*) pIdEvento;
-(NSMutableArray*) verificaAutosEvento:(NSString*) pIdEvento;
-(NSMutableArray*) verificaDistribuidoresEvento:(NSString*) pIdEvento;
-(void) getNombreEjecutivo:(NSString*) pIdEjecutivo objEjecutivo:(Ejecutivo*) pObjEjecutivo;
-(NSString*) getCadenaEnOtraCadena:(NSString*) cadenaBusqueda  cadenaAbuscar:(NSString*) pcadenaAbuscar;
-(BOOL) validaTextField:(NSCharacterSet*) serie  textovalidar:(NSString*) pTexttoValidar;
@end
