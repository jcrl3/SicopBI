//
//  ViewController.m
//  nipikDemo
//
//  Created by JUAN RAMIREZ on 05/09/13.
//  Copyright (c) 2013 JUAN RAMIREZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) muestraFotos:(id)sender{
    [self muestraAlerta:@"Mostrando fotos"];
    return;
}
-(IBAction) muestraVideos:(id)sender{
      [self muestraAlerta:@"Mostrando videos"];
        return;
}
-(IBAction) muestraCotizaciones:(id)sender{
     [self muestraAlerta:@"Cotizar"];
        return;
}
-(IBAction) retornaSicop:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sicoprecepcion://"]];
}
-(IBAction) checklistEntrega:(id)sender{
     [self muestraAlerta:@"Checklist de entrega"];
        return;
}


-(void)muestraAlerta:(NSString*) mensaje{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NIPIK-Demo" message:mensaje
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    [alert release];

}

@end
