//
//  GridViewController.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 02/12/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiGrids/ShinobiGrids.h>
#import "PropiedadesGraficas.h"

@interface GridViewController : UIViewController <SDataGridDelegate>{

}
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *columns;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;

@end
