//
//  ExpandGraphViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "ExpandGraphViewController.h"

@interface ExpandGraphViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showGrid;

@end

@implementation ExpandGraphViewController
@synthesize chart;
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.chart.frame = CGRectMake(self.viewContainer.bounds.origin.x+10, self.viewContainer.bounds.origin.y+10, self.viewContainer.bounds.size.width-20, self.viewContainer.bounds.size.height-20);
	
   [self.viewContainer addSubview:self.chart];
	self.chart.hidden=YES;
}

-(void) viewDidAppear:(BOOL)animated{
	//[super viewDidAppear:YES];
	self.chart.hidden=NO;
	[self.chart reloadData];
	[self.chart redrawChart];
	
	
}
- (IBAction)CloseView:(id)sender {
	[self dismissViewControllerAnimated: YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendGraph:(id)sender {
	
	//NSArray *actions ={@"2",@"1",nil};
	
	NSString *textToShare = chart.title;
	UIImage *image = [self chartImage];
 
	NSArray *objectsToShare = @[textToShare, image];
 
	
	UIActivityViewController *ac =
	[[UIActivityViewController alloc] initWithActivityItems:objectsToShare
									  applicationActivities:nil];
	
	NSArray *activities = @[UIActivityTypeAirDrop,
							UIActivityTypeAssignToContact,
							UIActivityTypeOpenInIBooks,
							UIActivityTypePostToFacebook,
							UIActivityTypePostToFlickr,
							UIActivityTypePostToTencentWeibo,
							UIActivityTypePostToTwitter,
							UIActivityTypePrint];
	
	ac.excludedActivityTypes=activities;
	
	
	[self presentViewController:ac animated:YES
									 completion:nil];
}

- (id)activityViewController:(UIActivityViewController *)activityViewController
		 itemForActivityType:(NSString *)activityType
{
	if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
		return @"Like this!";
	} else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
		return @"Retweet this!";
	} else {
		return nil;
	}
}

-(UIImage *)chartImage {
	UIGraphicsBeginImageContextWithOptions(chart.bounds.size, NO, 0.0);
	[chart drawViewHierarchyInRect:chart.bounds afterScreenUpdates:NO];
	UIImage *chartImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return chartImage;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"ShowDataGrid"]){
		GridViewController *vc = [segue destinationViewController];
		vc.data = [data copy];
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
