//
//  Fetcher.h
//  WTS
//
//  Created by foo on 9/24/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onSuccess)(NSData *);

@interface Fetcher : NSObject

- (void) fetch:(NSString *) url withBlock:(onSuccess) block;

@end
