//
//  ViewController.h
//  nipikDemo
//
//  Created by JUAN RAMIREZ on 05/09/13.
//  Copyright (c) 2013 JUAN RAMIREZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerCotiza.h"
@interface ViewController : UIViewController{
    IBOutlet  UIImageView *imagen;
    IBOutlet  UIButton *btnSicop;
}
-(IBAction) muestraFotos:(id)sender;
-(IBAction) muestraVideos:(id)sender;
-(IBAction) muestraCotizaciones:(id)sender;
-(IBAction) retornaSicop:(id)sender;
-(IBAction) checklistEntrega:(id)sender;
@property (nonatomic,retain ) IBOutlet  UIImageView *imagen;
@property (nonatomic,retain ) IBOutlet UIButton *btnSicop;
@end
