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
@synthesize imagen;
@synthesize btnSicop;

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"la foto 2.PNG"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    [backgroundImage release];
    */
    
    btnSicop.hidden=YES;
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
    btnSicop.hidden=YES;
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"la foto 4.PNG"]];
    [self.view addSubview:backgroundImage];
    // [self.view sendSubviewToBack:backgroundImage];
    [self.view bringSubviewToFront:backgroundImage];
    [backgroundImage release];

}
-(IBAction) muestraCotizaciones:(id)sender{
 // [self muestraAlerta:@"Cotizar"];
  /*
    ViewControllerCotiza *menu= [[ViewControllerCotiza alloc]   initWithNibName:@"ViewControllerCotiza" bundle:nil];
    [[self navigationController] pushViewController:menu   animated:YES];
    [menu release];
*/
    btnSicop.hidden=NO;

    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"la foto 3.PNG"]];
    [self.view addSubview:backgroundImage];
   // [self.view sendSubviewToBack:backgroundImage];
    [self.view bringSubviewToFront:backgroundImage];
    [self.view bringSubviewToFront:btnSicop];
    [backgroundImage release];

//    imagen sendSubviewToBack:UI

    
}
-(IBAction) retornaSicop:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sicoprecepcion://"]];
}
-(IBAction) checklistEntrega:(id)sender{
    btnSicop.hidden=YES;
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"la foto 5.PNG"]];
    [self.view addSubview:backgroundImage];
    // [self.view sendSubviewToBack:backgroundImage];
    [self.view bringSubviewToFront:backgroundImage];
    [backgroundImage release];
    
}


-(void)muestraAlerta:(NSString*) mensaje{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NIPIK-Demo" message:mensaje
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    [alert release];

}

@end
