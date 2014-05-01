//
//  SMMessageViewTableCell.h
//  JabberClient
//
//  Created by cesarerocchi on 9/8/11.
//  Copyright 2011 studiomagnolia.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface msjViewTableCell : UITableViewCell {

	UILabel	*senderAndTimeLabel;
   UILabel	*sender;
	UITextView *messageContentView;
	UIImageView *bgImageView;
	
}

@property (nonatomic,assign) UILabel *senderAndTimeLabel;
@property (nonatomic,assign) UILabel *sender;
@property (nonatomic,assign) UITextView *messageContentView;
@property (nonatomic,assign) UIImageView *bgImageView;

@end
