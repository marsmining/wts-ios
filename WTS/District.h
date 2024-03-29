//
//  District.h
//  WTS
//
//  Created by foo on 9/26/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface District : NSManagedObject

@property (nonatomic, retain) NSNumber * ident;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parent;
@property (nonatomic, retain) NSSet *images;
@end

@interface District (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
