//
//  EnhancedSplitViewController.h
//  SicopRecepcion
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 07/02/12.
//  Copyright (c) 2012 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EnhancedSplitViewController : UISplitViewController {
    UIBarButtonItem *barButton;
    UIPopoverController *pc;
}

@property (nonatomic, retain) UIBarButtonItem *barButton;
@property (nonatomic, retain) UIPopoverController *pc;

@end
