//
//  CoreDataTVC.m
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "CoreDataTVC.h"

@implementation CoreDataTVC

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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    dlog();
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    dlog();
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    dlog();
	return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    dlog();
	return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    dlog();
    return [self.fetchedResultsController sectionIndexTitles];
}

@end

