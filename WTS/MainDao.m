//
//  MainDao.m
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "MainDao.h"
#import "Image+CD.h"
#import "District+CD.h"

@implementation MainDao

+ (MainDao *) createWithContext:(NSManagedObjectContext *)context {
    MainDao *mainDao = [[MainDao alloc] init];
    mainDao.context = context;
    return mainDao;
}

- (NSArray *) execute:(NSFetchRequest *) request {
    dlog();
    
    // execute
    NSError *error = nil;
    NSArray *fetchResults = [self.context executeFetchRequest:request error:&error];
    if (fetchResults == nil) {
        dlog("error executing fetch request");
    }
    
    return fetchResults;
}

- (NSArray *) findAll {
    dlog();
    return [self execute:self.fetchRequestAll];
}

- (NSArray *) findAllWithImages {
    dlog();
    return [self execute:self.fetchRequestAllWithImages];
}

- (NSFetchRequest *) fetchRequestAll {
    dlog();
    
    // fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_DISTRICT
                                              inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    // sorted by
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ident" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    return request;
}

- (NSFetchRequest *) fetchRequestAllWithImages {
    dlog();

    NSFetchRequest *request = self.fetchRequestAll;
    request.predicate = [NSPredicate predicateWithFormat:@"images.@count > 0"];
    return request;
}

@end
