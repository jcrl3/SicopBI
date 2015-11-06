//
//  TableroTableViewCell.h
//  SicopBI
//
//  Created by JUAN RAMIREZ on 05/11/15.
//  Copyright © 2015 Sicop Consulting SA De CV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableroTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagenTablero;
@property (weak, nonatomic) IBOutlet UILabel *tituloTablero;
@property (weak, nonatomic) IBOutlet UILabel *descripcionTablero;

@end
