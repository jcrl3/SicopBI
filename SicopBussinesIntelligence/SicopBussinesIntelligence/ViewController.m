//
//  ViewController.m
//  SicopBussinesIntelligence
//
//  Created by JUAN RAMIREZ on 03/02/14.
//  Copyright (c) 2014 JUAN RAMIREZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ShinobiGauges setLicenseKey:@"VfwtMeC3u6/0QO1MjAxNDAzMDVpbmZvQHNoaW5vYmljb250cm9scy5jb20=uAiWu981DnhtDckiA/9NPpIDR7AG9/RrH5xsxXqd8jSTHx4wHx6YMkHG4gspZn4VvG2EswgAlw4YZmNvAB8L3aO0mTadkPUX6wi6P9wbqPgOBMuJNEzBPaW3CWq4PDXqmvgwXubM/e2Z8DZekqSBlwtIlG+E=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"]; // Add trial key here.
    
    gauge = [[SGaugeRadial alloc] initWithFrame:CGRectMake(0, 0, 400, 400) fromMinimum:@0 toMaximum:@1000];
    gauge.center = self.view.center;
    [self.view addSubview:gauge];

    gauge.style = [SGaugeDashboardStyle new];
    gauge.arcAngleStart = -M_PI_4 * 3.0;
    gauge.arcAngleEnd = M_PI_4 * 3.0;
    gauge.style.bevelWidth = 30;
    gauge.value = 375;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
