//
//  AppDelegate.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "DBManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DBManager *dbManager;


@end

