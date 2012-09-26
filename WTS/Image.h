//
//  Image.h
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class District;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSNumber * ident;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSNumber * idx;
@property (nonatomic, retain) District *district;

@end
