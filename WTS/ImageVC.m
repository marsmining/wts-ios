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

// navigation controller back button
- (IBAction)back:(id)sender {
    dlog();
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    dlog();
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dlog(@"---------------------------");
    
    dlog("WINDOW: %@", self.view.window);
    
    dlog("ROOTVC VIEW: %@", self.view.window.rootViewController.view);
    for (UIView *v in self.view.window.rootViewController.view.subviews) {
        dlog("  subviews: %@", v);
    }

    dlog("NAVIGATIONCONTROLLER VIEW: %@", self.navigationController.view);
    for (UIView *v in self.navigationController.view.subviews) {
        dlog("  subviews: %@", v);
    }
    
    dlog("IMAGEVC VIEW: %@", self.view);
    for (UIView *v in self.view.subviews) {
        dlog("  subviews: %@", v);
    }
    dlog(@"---------------------------");
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dlog("image paths: %@", self.paths);
    
    self.title = @"Image Viewer";
    
    for (UIView *v in self.navigationController.view.subviews) {
        dlog("view=%@", v);
    }
    
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



