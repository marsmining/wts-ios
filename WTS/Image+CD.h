//
//  Image+CD.h
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "Image.h"

#define ENTITY_IMAGE @"Image"

@interface Image (CD)

+ (Image *) createOrUpdateWithDict:(NSDictionary *) dict
                        andContext:(NSManagedObjectContext *)ctx;

@end
