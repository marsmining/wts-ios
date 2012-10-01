//
//  MainViewController.m
//  WTS
//
//  Created by foo on 9/20/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "MainViewController.h"
#import "SimpleFetch.h"
#import "DistrictTVC.h"
#import "DistrictCVC.h"

@implementation MainViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    dlog(@"segue: %@", [segue identifier]);
    
    id dvc = [segue destinationViewController];
    
    if ([dvc isKindOfClass:[UINavigationController class]]) {
        
        dlog(@"setting dvc model");
        UINavigationController *uinc = (UINavigationController *) dvc;
        id vvc = [uinc visibleViewController];
        
        // set the model of the view control we are segue'ing to
        // for iPhone and iPad we create a SimpleFetch instance
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:self.mainDao.fetchRequestAllWithImages
                                           managedObjectContext:self.mainDao.context
                                           sectionNameKeyPath:@"parent"
                                           cacheName:nil];
        
        SimpleFetch *sfetch = [[SimpleFetch alloc] init];
        sfetch.fetchedResultsController = frc;
        sfetch.delegate = vvc;
        
        if ([vvc isKindOfClass:[DistrictTVC class]]) {
            DistrictTVC *tvc = (DistrictTVC *) vvc;
            tvc.fetchedResultsController = frc;
        } else if ([vvc isKindOfClass:[DistrictCVC class]]) {
            DistrictCVC *cvc = (DistrictCVC *) vvc;
            cvc.fetchedResultsController = frc;
        }
    }
}

@end
