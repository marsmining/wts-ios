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

- (NSArray *) findAll {
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
    
    // execute
    NSError *error = nil;
    NSArray *fetchResults = [self.context executeFetchRequest:request error:&error];
    if (fetchResults == nil) {
        // handle the error
    }
    
    return fetchResults;
}

- (NSArray *) findAllWithImages {
    
    NSMutableArray *filtered = [NSMutableArray array];
    
    for (District *dist in [self findAll]) {
        if (dist.images.count > 0) [filtered addObject:dist];
    }
    
    return filtered;
}

@end
