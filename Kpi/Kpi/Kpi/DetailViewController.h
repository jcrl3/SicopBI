//
//  DetailViewController.h
//  Kpi
//
//  Created by JUAN RAMIREZ on 01/05/14.
//  Copyright (c) 2014 JUAN RAMIREZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
