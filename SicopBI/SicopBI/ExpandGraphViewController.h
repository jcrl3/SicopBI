//
//  ExpandGraphViewController.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "TakePhoto.h"
#import "GridViewController.h"

@interface ExpandGraphViewController : UIViewController {
	
}
@property ShinobiChart* chart;
@property (nonatomic,strong) NSArray* data;
@end
