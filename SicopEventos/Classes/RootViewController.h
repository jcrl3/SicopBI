//
//  RootViewController.h
//  Survey
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 11/01/11.
//  Copyright 2011 SICOP CONSULTING S.A. DE C.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
  	NSMutableArray* surveyDataArray;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic,retain) NSMutableArray* surveyDataArray;

-(void)addSurveyToDataArray: (NSDictionary*) sd;
@end
