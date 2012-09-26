//
//  District+CD.m
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "District+CD.h"
#import <CoreData/CoreData.h>

@implementation District (CD)

//
// create new district entity
//
+ (District *) createOrUpdateWithDict:(NSDictionary *) dict
                           andContext:(NSManagedObjectContext *) ctx {
    
    NSNumber *uid = dict[@"id"];
    NSString *name = dict[@"name"];
    NSString *parent = dict[@"parent"];
    
    dlog(@"district[id=%@. name=%@]", uid, name);
    
    if (!uid || !name) {
        dlog(@"error - missing attrs");
        return nil;
    }

    District *found = [self findById:uid andContext:ctx];
    if (found) {
        found.name = name;
        return found;
    }
    
    District *entity = (District *)[NSEntityDescription
                                    insertNewObjectForEntityForName:ENTITY_DISTRICT
                                    inManagedObjectContext:ctx];
    entity.ident = uid;
    entity.name = name;
    entity.parent = parent;
    
    return entity;
}

//
// check existence
//
+ (District *) findById:(NSNumber *) ident andContext:(NSManagedObjectContext *) ctx {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:ENTITY_DISTRICT
                                 inManagedObjectContext:ctx];
    request.predicate = [NSPredicate predicateWithFormat:@"ident = %@", ident];
    NSError *executeFetchError= nil;
    NSArray *results = [ctx executeFetchRequest:request error:&executeFetchError];
    
    if (executeFetchError) {
        dlog("error");
    }

    if (results && results.count > 0) {
        return [results lastObject];
    }
    return nil;
}

@end
