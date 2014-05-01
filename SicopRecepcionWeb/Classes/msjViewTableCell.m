//
//  SMMessageViewTableCell.m
//  JabberClient
//
//  Created by cesarerocchi on 9/8/11.
//  Copyright 2011 studiomagnolia.com. All rights reserved.
//

#import "msjViewTableCell.h"


@implementation msjViewTableCell

@synthesize senderAndTimeLabel, messageContentView, bgImageView,sender;

- (void)dealloc {
	[sender release];
	[senderAndTimeLabel release];
	[messageContentView release];
	[bgImageView release];
   [super dealloc];
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

		senderAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 200, 20)];
		senderAndTimeLabel.textAlignment = UITextAlignmentCenter;
		senderAndTimeLabel.font = [UIFont systemFontOfSize:11.0];
		senderAndTimeLabel.textColor = [UIColor darkGrayColor];
		[self.contentView addSubview:senderAndTimeLabel];
		
		bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:bgImageView];
		
      
      sender = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 150, 20)];
		sender.textAlignment = UITextAlignmentLeft;
		sender.font = [UIFont italicSystemFontOfSize:11.0];
		sender.textColor = [UIColor whiteColor];
		[self.contentView addSubview:sender];
		
		messageContentView = [[UITextView alloc] init];
		messageContentView.backgroundColor = [UIColor clearColor];
		messageContentView.editable = NO;
		messageContentView.scrollEnabled = NO;
		[messageContentView sizeToFit];
		[self.contentView addSubview:messageContentView];

    }
	
    return self;
	
}








@end
