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

@class ThirdViewController;

@interface RootViewController : UITableViewController  <MBProgressHUDDelegate>{
    ThirdViewController *thirdViewController;
    NSString *titulo;
   
   //Objetos para representar las conversacione   
   SicopRecepcionAppDelegate* appDelegate;

   UITableViewCell *tvCell;
   NSMutableArray* conversaciones; 
   MBProgressHUD *HUD;

}

@property (nonatomic, retain) IBOutlet ThirdViewController *thirdViewController;
@property (nonatomic, retain) IBOutlet UITableViewCell *tvCell;
@property (nonatomic,retain)  NSString *titulo;

@property (nonatomic, retain) NSMutableArray* conversaciones;


@end
