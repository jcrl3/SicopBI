//
//  Disclaimer.m
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 05/07/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import "Disclaimer.h"

@implementation Disclaimer
@synthesize textoLegal;
@synthesize nombreMarca;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Términos y condiciones";
     UIBarButtonItem* agregaSegButton= [[UIBarButtonItem alloc] initWithTitle:@"Cerrar" style:UIBarButtonItemStylePlain target:self action:@selector(cerrarDisclaimer:)];
    self.navigationItem.leftBarButtonItem=agregaSegButton;
   [agregaSegButton release];
	
	
   //Cargo el texto legal de acuerdo a la marca
	DatoLegal *objTextoLegal= [[DatoLegal alloc] init];
  	  textoLegal.text = [objTextoLegal getTextoLegal:self.nombreMarca];
    [objTextoLegal release];

}

- (void)viewDidUnload
{
	self.nombreMarca=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) cerrarDisclaimer:(id)sender{
  [self dismissViewControllerAnimated:NO completion:nil];
}

@end
