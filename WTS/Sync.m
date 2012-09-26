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

@interface Sync ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation Sync

+ (Sync *) createWithContext:(NSManagedObjectContext *)context {
    Sync *sync = [[Sync alloc] init];
    sync.context = context;
    return sync;
}

- (void) syncDistricts {
    dlog();
    
    // fetch districts json via http
    Fetcher *fetcher = [[Fetcher alloc] init];
    
    [fetcher fetch:URL_DISTRICT withBlock:^(NSData *data){
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

- (void) syncImages {
    dlog();

    // get district data
    id ds = [[NSUserDefaults standardUserDefaults] objectForKey:DISTRICT_KEY];
    
    if (ds) {
        NSArray *districts = (NSArray *) ds;
        // grab each image and store it
        for (int i=0; i < districts.count; i++) {
            NSArray *images = [districts[i] objectForKey:@"images"];
            for (int j=0; j < images.count; j++) {
                [self storeImage:images[j][@"path"]];
            }
        }
    }
}

- (void) storeImage:(NSString *) path {
    NSString *fthumb = [@"thumb_" stringByAppendingString:path];
    NSString *fpath = [[BASE_IMAGE_URL stringByAppendingString:@"/"]
                       stringByAppendingString:fthumb];
    dlog(@"fpath: %@", fpath);
    
    Fetcher *fetcher = [[Fetcher alloc] init];
    [fetcher fetch:fpath withBlock:^(NSData *data){
        dlog(@"data length: %d", data.length);
        
        // write data to cache dir
        NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *fp = [NSURL fileURLWithPathComponents:@[cacheDir, fthumb]];
        dlog(@"writing to file: %@", fp);
        [data writeToURL:fp atomically:YES];
    }];
    
}

@end
