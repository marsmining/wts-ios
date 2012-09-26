//
//  MainDao.h
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MainDao : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

+ (MainDao *) createWithContext:(NSManagedObjectContext *)context;

- (NSArray *) findAll;

- (NSArray *) findAllWithImages;

- (NSFetchRequest *) fetchRequestAll;

- (NSFetchRequest *) fetchRequestAllWithImages;

@end
