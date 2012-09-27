//
//  ImageScrollViewController.h
//  WTS
//
//  Created by foo on 9/27/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollViewController : UIViewController

+ (ImageScrollViewController *) createWithImage:(UIImage *) image
                                       andIndex:(NSUInteger) index;

- (NSUInteger) getIndex;

@end
