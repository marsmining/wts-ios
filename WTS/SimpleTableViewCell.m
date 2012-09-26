//
//  SimpleTableViewCell.m
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "SimpleTableViewCell.h"

@implementation SimpleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake( 10, 10, 50, 50 );
}

@end
