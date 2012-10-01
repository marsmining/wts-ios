//
//  CoreDataCVC.m
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "CoreDataCVC.h"

@implementation CoreDataCVC

#pragma mark - SimpleFetchDelegate

- (void) reloadData {
    dlog();
}

- (void) beginUpdates {
    dlog();
}

- (void) endUpdates {
    dlog();
}

- (void) insertRowsAtIndexPaths:(NSArray *)rows {
    dlog();
}

- (void) deleteRowsAtIndexPaths:(NSArray *)rows {
    dlog();
}

- (void) reloadRowsAtIndexPaths:(NSArray *)rows {
    dlog();
}

- (void) insertSections:(NSIndexSet *) sections {
    dlog();
}

- (void) deleteSections:(NSIndexSet *) sections {
    dlog();
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    dlog();
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    dlog();
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

@end
