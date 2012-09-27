//
//  Sync.m
//  WTS
//
//  Created by foo on 9/25/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "Sync.h"
#import "Fetcher.h"
#import "District+CD.h"
#import "Image+CD.h"
#import "MainDao.h"

@interface Sync ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation Sync

//
// new instance
//
+ (Sync *) createWithContext:(NSManagedObjectContext *)context {
    Sync *sync = [[Sync alloc] init];
    sync.context = context;
    return sync;
}

//
// fetch json to populate our database
// be notified as each image entity is added, to grab thumbnail
//
- (void) syncAll {
    dlog();

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(entityChanged:)
               name:NSManagedObjectContextObjectsDidChangeNotification
             object:nil];
    
    [self syncDistricts];
}

- (void) entityChanged:(NSNotification *) notice {
    dlog();
    
    // just do the whole shebang now
    [self syncImages];
}

//
// fetch json and persist to core data
//
- (void) syncDistricts {
    dlog();
    
    // fetch districts json via http
    Fetcher *fetcher = [[Fetcher alloc] init];
    
    NSURL *fetchUrl = [NSURL URLWithString:URL_DISTRICT];
    
    [fetcher fetch:fetchUrl withBlock:^(NSData *data){
        dlog(@"data length: %d", data.length);
        
        NSError *err = nil;
        NSArray *pd = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&err];
        if (err) {
            dlog(@"error!");
            return;
        }
        
        // now we have parsed json, do database work on main thread (not good)
        dispatch_async(dispatch_get_main_queue(), ^{
            [Sync persistDistricts:pd withContext:self.context];
        });
        
    }];
}

//
// persist districts and images given a dictionary
//
+ (void) persistDistricts:(NSArray *) parsedJson withContext:(NSManagedObjectContext *) ctx {
    dlog();
    
    for (NSDictionary *ddict in parsedJson) {
        
        District *district = [District createOrUpdateWithDict:ddict andContext:ctx];
        
        if (!district) {
            dlog(@"district create/update failed");
            continue;
        }
        
        for (NSDictionary *idict in ddict[@"images"]) {
            
            Image *image = [Image createOrUpdateWithDict:idict andContext:ctx];
            
            if (image) {
                if (![district.images containsObject:image]) {
                    dlog(@"adding image to district");
                    [district addImagesObject:image];
                }
            } else {
                dlog(@"image create/update failed");
            }
        }
    }
    
    NSError *error = nil;
    if (![ctx save:&error]) {
        dlog(@"error: %@", error);
    }
}

//
// attempt to store each image path from database to file on disk cache
//
- (void) syncImages {
    dlog();

    MainDao *mainDao = [MainDao createWithContext:self.context];
    NSArray *districts = [mainDao findAll];

    // grab each image and store it
    for (District *dist in districts) {
        for (Image *img in dist.images) {
            [self storeImage:img.path];
        }
    }
}

//
// fetch and store path
//
- (void) storeImage:(NSString *) path {
    
    // generate remote url
    NSURL *remoteUrl = [Image getRemoteUrlFromPathThumb:path];
    
    // generate local file url
    NSURL *localUrl = [Image getLocalUrlFromPathThumb:path];
    
    // only fetch if file does not exist
    BOOL fileExists = [localUrl checkResourceIsReachableAndReturnError:nil];
    
    if (fileExists) return;
    
    dlog(@"about to fetch url: %@", remoteUrl);

    Fetcher *fetcher = [[Fetcher alloc] init];
    [fetcher fetch:remoteUrl withBlock:^(NSData *data){
        dlog(@"data length: %d", data.length);
        dlog(@"writing to file: %@", localUrl);
        [data writeToURL:localUrl atomically:YES];
    }];
    
}

@end

