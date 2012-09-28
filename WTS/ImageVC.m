//
//  ImageVC.m
//
//  Created by foo on 9/21/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "ImageVC.h"
#import "ImageScrollViewController.h"

@implementation ImageVC

// grab image synchronously.. yuk
- (UIImage *) grab:(NSUInteger)index {
    UIImage *myimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.paths[index]]];
    dlog(@"myimg size: %f x %f", myimg.size.width, myimg.size.height);
    return myimg;
}

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
    dlog("image paths: %@", self.paths);
    
    ImageScrollViewController *seed = [ImageScrollViewController createWithImage:[self grab:0] andIndex:0];
    
    UIPageViewController *pvc =
        [[UIPageViewController alloc]
         initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
         options:nil];
    
    pvc.dataSource = self;
    
    [pvc setViewControllers:@[seed]
                  direction:UIPageViewControllerNavigationDirectionForward
                   animated:NO
                 completion:NULL];
    
    [self addChildViewController:pvc];
    [self.view addSubview:pvc.view];

}

#pragma mark UIPageViewControllerDataSource methods

// before
- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(ImageScrollViewController *)vc {
    dlog();
    NSUInteger idx = self.paths.count - 1; // reset index
    NSUInteger cur = [vc getIndex];
    if (cur > 0) idx = cur - 1;
    return [ImageScrollViewController createWithImage:[self grab:idx] andIndex:idx];
}

// after
- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(ImageScrollViewController *)vc {
    dlog();
    NSUInteger idx = 0; // reset index
    NSUInteger cur = [vc getIndex];
    if (cur < self.paths.count - 1) idx = cur + 1;
    return [ImageScrollViewController createWithImage:[self grab:idx] andIndex:idx];
}

@end



