//
//  Image.h
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class District;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) District *district;

@end
