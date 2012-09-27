//
//  ImageVC.h - Given an array of NSURL's, display images.
//
//  Created by foo on 9/21/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ImageVC : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *paths;

@end
