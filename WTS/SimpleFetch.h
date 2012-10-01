//
//  SimpleFetch.h
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol SimpleFetchDelegate <NSObject>

- (void) reloadData;

- (void) beginUpdates;

- (void) endUpdates;

- (void) insertRowsAtIndexPaths:(NSArray *)rows;

- (void) deleteRowsAtIndexPaths:(NSArray *)rows;

- (void) reloadRowsAtIndexPaths:(NSArray *)rows;

- (void) insertSections:(NSIndexSet *) sections;

- (void) deleteSections:(NSIndexSet *) sections;

@end


@interface SimpleFetch : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) id <SimpleFetchDelegate> delegate;

@property (nonatomic) BOOL suspend;

@property BOOL debug;

- (void) performFetch;

@end
