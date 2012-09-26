//
//  Sync.h
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sync : NSObject

+ (Sync *) createWithContext:(NSManagedObjectContext *)context;

- (void) syncDistricts;

@end
