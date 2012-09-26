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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    dlog(@"segue: %@", [segue identifier]);
    
    id dvc = [segue destinationViewController];
    
    if ([dvc isKindOfClass:[UINavigationController class]]) {
        
        dlog(@"setting dvc model");
        UINavigationController *uinc = (UINavigationController *) dvc;
        id vvc = [uinc visibleViewController];
        DistrictTVC *dtvc = (DistrictTVC *) vvc;
        
        // set the model of the view control we are segue'ing to
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:self.mainDao.fetchRequestAllWithImages
                                           managedObjectContext:self.mainDao.context
                                           sectionNameKeyPath:@"parent"
                                           cacheName:nil];
        
        dtvc.fetchedResultsController = frc;
    }
}

@end
