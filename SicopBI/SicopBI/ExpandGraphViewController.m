//
//  ExpandGraphViewController.m
//  SicopBI
//
//  Created by JUAN RAMIREZ on 10/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import "ExpandGraphViewController.h"

@interface ExpandGraphViewController ()

@end

@implementation ExpandGraphViewController
@synthesize chart;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.chart.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+50.0, self.view.bounds.size.width, self.view.bounds.size.height-30.0);
	
	//agregramos el botón que cierra el view
	/*UIButton* expandButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-27.0, 7.0, 24.0, 24.0)];
	[expandButton addTarget:self
			   action:@selector(closeView:)
		   forControlEvents:UIControlEventTouchUpInside];
	expandButton.tag  = 1;
	expandButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	expandButton.opaque=NO;
	[expandButton setTintColor:[UIColor blueColor]];
	[expandButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];

	[self.chart addSubview:expandButton];*/
	[self.view addSubview:self.chart];
	[chart redrawChart];
	
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
	UIImage *image = [TakePhoto TakePhotoFromUIView:(UIView*)chart];
 
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
	
	/*
	IActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
	
	
	activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
 
	[self presentViewController:activityViewController animated:YES completion:nil];
	
	*/
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
