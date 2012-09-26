//
//  Image+CD.h
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "Image.h"

#define ENTITY_IMAGE @"Image"
#define THUMB_PREFIX @"thumb_"

@interface Image (CD)

+ (Image *) createOrUpdateWithDict:(NSDictionary *) dict
                        andContext:(NSManagedObjectContext *)ctx;

+ (NSURL *) getLocalUrlFromPathThumb:(NSString *) path;

+ (NSURL *) getRemoteUrlFromPathThumb:(NSString *) path;


@end
