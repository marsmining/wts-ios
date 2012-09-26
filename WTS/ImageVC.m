//
//  ImageVC.m
//  WTS
//
//  Created by foo on 9/21/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC ()
@end

@implementation ImageVC

@synthesize scroller = _scroller;

- (IBAction)back:(id)sender {
    dlog();
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dlog();
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dlog("image path: %@", self.path);
    
    NSURL *myurl = [NSURL URLWithString:[[BASE_IMAGE_URL stringByAppendingString:@"/"] stringByAppendingString:self.path]];
    UIImage *myimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:myurl]];
    
    dlog(@"myimg size: %f x %f", myimg.size.width, myimg.size.height);
    
    self.scroller = [[ImageScrollView alloc] initWithFrame:self.view.frame];
    self.scroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scroller];
    
    [self.scroller displayImage:myimg];
    [self.scroller setNeedsDisplay];
}

@end