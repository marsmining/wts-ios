//
//  ImageScrollViewController.m
//  WTS
//
//  Created by foo on 9/27/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "ImageScrollViewController.h"
#import "ImageScrollView.h"

@interface ImageScrollViewController () {
    NSUInteger _index;
}

@property (nonatomic, strong) UIImage *image;

@end

@implementation ImageScrollViewController

+ (ImageScrollViewController *) createWithImage:(UIImage *) image
                                       andIndex:(NSUInteger) index {
    dlog();

    ImageScrollViewController *myvc = [[ImageScrollViewController alloc] init];
    myvc.image = image;
    myvc->_index = index;
    return myvc;
}

- (NSUInteger) getIndex {
    return _index;
}

- (void)loadView {
    dlog();
    
    ImageScrollView *scrollView = [[ImageScrollView alloc] init];
    scrollView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [scrollView displayImage:self.image];
    self.view = scrollView;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
