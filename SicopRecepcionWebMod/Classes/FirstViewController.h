//
//  FirstViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Login.h"
#import "SicopRecepcionAppDelegate.h"
#import "Urls.h"

@class SicopRecepcionAppDelegate;

@interface FirstViewController : UIViewController <UIWebViewDelegate>{
   SicopRecepcionAppDelegate *appDelegate;
   UIWebView *myWebView;
   
@private  
   UIToolbar *toolBar;
   NSInteger segundos;

}
@property (nonatomic, retain)  UIWebView *myWebView;
-(IBAction)atras:(id)sender;
-(IBAction)adelante:(id)sender;
-(IBAction)refrescar:(id)sender;
-(IBAction)irOtraApp:(id)sender;
-(void) checkProcesoLogin:(NSNotification *)notice;
@end
