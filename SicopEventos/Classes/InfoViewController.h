//
//  InfoViewController.h
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController {
	UILabel* infoLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* infoLabel;
-(void) setText: (NSString*) text;
@end
