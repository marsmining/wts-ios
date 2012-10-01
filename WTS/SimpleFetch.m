//
//  SimpleFetch.m
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "SimpleFetch.h"

@interface SimpleFetch ()
@property (nonatomic) BOOL beganUpdates;
@end

@implementation SimpleFetch


#pragma mark - Properties

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize suspend = _suspend;
@synthesize debug = _debug;
@synthesize beganUpdates = _beganUpdates;


#pragma mark - Fetching

- (void)performFetch
{
    if (self.fetchedResultsController) {
        if (self.fetchedResultsController.fetchRequest.predicate) {
            if (self.debug) NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName, self.fetchedResultsController.fetchRequest.predicate);
        } else {
            if (self.debug) NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName);
        }
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
    } else {
        if (self.debug) NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
    [self.delegate reloadData];
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)newfrc
{
    NSFetchedResultsController *oldfrc = _fetchedResultsController;
    if (newfrc != oldfrc) {
        _fetchedResultsController = newfrc;
        newfrc.delegate = self;

        if (newfrc) {
            if (self.debug) NSLog(@"[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), oldfrc ? @"updated" : @"set");
            [self performFetch];
        } else {
            if (self.debug) NSLog(@"[%@ %@] reset to nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            [self.delegate reloadData];
        }
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (!self.suspend) {
        [self.delegate beginUpdates];
        self.beganUpdates = YES;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    if (!self.suspend)
    {
        switch(type)
        {
            case NSFetchedResultsChangeInsert:
                [self.delegate insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
                break;
                
            case NSFetchedResultsChangeDelete:
                [self.delegate deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
                break;
        }
    }
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    if (!self.suspend)
    {
        switch(type)
        {
            case NSFetchedResultsChangeInsert:
                [self.delegate insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
                break;
                
            case NSFetchedResultsChangeDelete:
                [self.delegate deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
                break;
                
            case NSFetchedResultsChangeUpdate:
                [self.delegate reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
                break;
                
            case NSFetchedResultsChangeMove:
                [self.delegate deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
                [self.delegate insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
                break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (self.beganUpdates) [self.delegate endUpdates];
}

- (void)endSuspensionOfUpdatesDueToContextChanges
{
    _suspend = NO;
}

- (void)setsuspend:(BOOL)suspend
{
    if (suspend) {
        _suspend = YES;
    } else {
        [self performSelector:@selector(endSuspensionOfUpdatesDueToContextChanges) withObject:0 afterDelay:0];
    }
}


@end
