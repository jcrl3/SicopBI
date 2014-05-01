//
//  ThirdViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//
#import <UIKit/UIKit.h>
//#import "RedactarMsj.h"
#import "Mensaje.h"
//#import "Parser.h"
#import "msjViewTableCell.h"
#import "Sonido.h"
#import "HPGrowingTextView.h"
#import "DatParticipantes.h"
#import "Participantes.h"
//#import "DatosPerfil.h"

@class SicopRecepcionAppDelegate;
@class ASIHTTPRequest;

#define kRemitenteTag             1
#define kObservacionesValueTag    2
#define kFechaTag                 3

@interface ThirdViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate,   HPGrowingTextViewDelegate> {
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    UIBarButtonItem *barButton;
    
    id detailItem;
    UILabel *detailDescriptionLabel;
   
   NSTimer *tiempoChecaSw;
   UITableView *tableView;
   
   UIView *containerView;
   UIView *containerTableView;
   
   NSMutableArray* conversacion; 
   HPGrowingTextView *txtMensaje;
   Mensaje *msjContexto;
   
@private 
   NSString* fechaConsulta;

}

@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc;
- (void)removeBarButtonItem;

-(void) cancelarTimer;
-(void)revisarChatTimer:(NSTimer*)theTimer;
-(void) verificaParticipantes;
-(void)resignTextView;
-(void)revisarChat;
-(void)checkCargaMensajes:(NSNotification *)notice;
-(void) cargaMensajesGrabados;
-(IBAction)backgroundClick:(id)sender;
-(IBAction) enviarMsj;
-(IBAction) muestraPerfil:(id)sender;
-(void) checkCancelaTimerMensajesChat:(NSNotification *)notice;
-(void) checkIniciaTimerMensajesChat:(NSNotification *)notice;
@property (nonatomic,retain) UITableView  *tableView;
@property (nonatomic,retain) Mensaje *msjContexto;
@property (nonatomic,retain) IBOutlet HPGrowingTextView *txtMensaje;
@property (nonatomic,retain) NSMutableArray* conversacion;
@property (assign) NSTimer *tiempoChecaSw;

@end
