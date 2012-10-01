//
//  CoreDataCVC.h
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleFetch.h"

@interface CoreDataCVC : UICollectionViewController <SimpleFetchDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void) reloadData;

- (void) beginUpdates;

- (void) endUpdates;

- (void) insertRowsAtIndexPaths:(NSArray *)rows;

- (void) deleteRowsAtIndexPaths:(NSArray *)rows;

- (void) reloadRowsAtIndexPaths:(NSArray *)rows;

- (void) insertSections:(NSIndexSet *) sections;

- (void) deleteSections:(NSIndexSet *) sections;

@end
