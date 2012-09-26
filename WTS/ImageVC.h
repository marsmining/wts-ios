//
//  ImageVC.h
//  WTS
//
//  Created by foo on 9/21/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ImageVC : UIViewController

@property (nonatomic, strong) ImageScrollView *scroller;

@property (nonatomic, strong) NSString *path;

@end
