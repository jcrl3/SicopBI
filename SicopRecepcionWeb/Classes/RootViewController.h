//
//  RootViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SicopRecepcionAppDelegate.h"
#import "MBProgressHUD.h"
#define kRemitenteTag             1
#define kObservacionesValueTag    2
#define kFechaTag                 3

@class ThirdViewController;

@interface RootViewController : UITableViewController  <MBProgressHUDDelegate>{
    ThirdViewController *thirdViewController;
    NSString *titulo;
   
   //Objetos para representar las conversacione   
   SicopRecepcionAppDelegate* appDelegate;
//   opTipoMensaje TipoMensajesMostrar;
   UITableViewCell *tvCell;
   NSMutableArray* conversaciones; 
   MBProgressHUD *HUD;

}

@property (nonatomic, retain) IBOutlet ThirdViewController *thirdViewController;
@property (nonatomic, retain) IBOutlet UITableViewCell *tvCell;
@property (nonatomic,retain)  NSString *titulo;
//@property (nonatomic)         opTipoMensaje TipoMensajesMostrar;
@property (nonatomic, retain) NSMutableArray* conversaciones;

-(void) cargarEnzabezados;
-(void) cargarEncabezadosEnDelegate;
-(void) seActivoView:(NSDictionary*) tipoMsj;

@end
