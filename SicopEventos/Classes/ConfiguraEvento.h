//
//  ConfiguraEvento.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 15/06/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Evento.h"
#import "SurveyAppDelegate.h"
#import "Error.h"
#import "MBProgressHUD.h"

@interface ConfiguraEvento : UIViewController <MBProgressHUDDelegate,UITextFieldDelegate>{
   Evento* idEventoActual;   
   UITextField* idEvento;

   MBProgressHUD *HUD;

}
@property (nonatomic,retain) IBOutlet UITextField* idEvento;
@property (nonatomic,retain) Evento* idEventoActual;


-(IBAction)cancelar:(id)sender;
-(IBAction)cargarEvento:(id)sender;
-(void) iniciaHud;

-(void) enviaProspectosEnDelegate;
@end
