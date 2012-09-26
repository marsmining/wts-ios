//
//  District+CD.h
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "District.h"

#define ENTITY_DISTRICT @"District"

@interface District (CD)

+ (District *) createOrUpdateWithDict:(NSDictionary *) dict
                           andContext:(NSManagedObjectContext *)ctx;

@end
