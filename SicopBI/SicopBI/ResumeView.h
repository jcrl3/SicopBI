//
//  ResumeView.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 23/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiGrids/ShinobiGrids.h>

@interface ResumeView : UIViewController <SDataGridDelegate>

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *columns;
@property (weak, nonatomic) IBOutlet UIView *viewGridContainer;
@property (weak, nonatomic) IBOutlet UILabel *resumenLabel;
@property (weak, nonatomic) IBOutlet UILabel *disciplinaLabel;

@end
