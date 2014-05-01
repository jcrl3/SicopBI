//
//  Disclaimer.h
//  SicopEventos
//
//  Created by JUAN CARLOS RAMIREZ LOZADA on 05/07/12.
//  Copyright (c) 2012 Sicop Consulting, SA de CV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatoLegal.h"

@interface Disclaimer : UIViewController{
	IBOutlet UITextView *textoLegal;
	NSString *nombreMarca;
}
@property (nonatomic, retain) IBOutlet UITextView* textoLegal;
@property (nonatomic, retain) NSString *nombreMarca;
-(void) cerrarDisclaimer:(id)sender;

@end
