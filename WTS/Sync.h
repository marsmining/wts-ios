//
//  Sync.h
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sync : NSObject

//
// helper for creation
//
+ (Sync *) createWithContext:(NSManagedObjectContext *)context;

//
// public api
//
- (void) syncDistricts;
- (void) syncImages;
- (void) syncAll;

@end
