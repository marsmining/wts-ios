//
//  Image+CD.m
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "Image+CD.h"

@implementation Image (CD)

//
// create new image entity
//
+ (Image *) createOrUpdateWithDict:(NSDictionary *) dict
                        andContext:(NSManagedObjectContext *) ctx {
    
    NSNumber *uid = dict[@"id"];
    NSString *path = dict[@"path"];
    
    dlog(@"image[id=%@. path=%@]", uid, path);
    
    if (!uid || !path) {
        dlog(@"error - missing attrs");
        return nil;
    }
    
    Image *found = [self findById:uid andContext:ctx];
    if (found) {
        found.path = path;
        return found;
    }
    
    Image *entity = (Image *)[NSEntityDescription
                              insertNewObjectForEntityForName:ENTITY_IMAGE
                              inManagedObjectContext:ctx];
    entity.ident = uid;
    entity.path = path;

    return entity;
}

//
// check existence
//
+ (Image *) findById:(NSNumber *) ident andContext:(NSManagedObjectContext *) ctx {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:ENTITY_IMAGE
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
