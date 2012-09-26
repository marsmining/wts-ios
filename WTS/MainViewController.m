//
//  MainViewController.m
//  WTS
//
//  Created by foo on 9/20/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "MainViewController.h"
#import "DistrictTVC.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dlog();
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    dlog(@"segue: %@", [segue identifier]);
    
    id dvc = [segue destinationViewController];
    
    dlog(@"dvc class: %@", [dvc class]);
    
    if ([dvc isKindOfClass:[UINavigationController class]]) {
        
        dlog(@"setting dvc model");
        UINavigationController *uinc = (UINavigationController *) dvc;
        id vvc = [uinc visibleViewController];
        DistrictTVC *dtvc = (DistrictTVC *) vvc;
        dtvc.districts = [self.mainDao findAll];
    }
}

@end
