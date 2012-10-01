//
//  DistrictTableCell.h
//  WTS
//
//  Created by foo on 9/27/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumb;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
