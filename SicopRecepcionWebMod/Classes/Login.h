//
//  Login.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 09/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class SicopRecepcionAppDelegate;
@class TPKeyboardAvoidingScrollView;

@interface Login : UIViewController <MBProgressHUDDelegate, UITextFieldDelegate >{
   SicopRecepcionAppDelegate *appDelegate;  
   TPKeyboardAvoidingScrollView *scrollView;
   
   UITextField  IBOutlet *txtCorreo;
   UITextField  IBOutlet  *txtPassword;
   
   MBProgressHUD *HUD;
}

@property (nonatomic,retain)  UITextField  IBOutlet *txtCorreo;
@property (nonatomic,retain)  UITextField  IBOutlet  *txtPassword;
@property (nonatomic,retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
-(IBAction)backgroundClick:(id)sender;
-(IBAction)doneEditing:(id)sender;
-(IBAction)login:(id)sender;
-(void) enviaDatosEnDelegate;
-(void) validaDatosEnDelegate;
-(void) iniciaHud;
@end