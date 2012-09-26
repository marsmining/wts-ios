//
//  Fetcher.m
//  WTS
//
//  Created by foo on 9/24/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "Fetcher.h"

@interface Fetcher () {
    onSuccess myblock;
}
@property (nonatomic, strong) NSMutableData *content;
@property (nonatomic, strong) NSURLConnection *conn;
@end

@implementation Fetcher

@synthesize content = _content;
@synthesize conn = _conn;

- (NSMutableData *) content {
    if (!_content) _content = [NSMutableData data];
    return _content;
}

- (void) fetch:(NSURL *) url withBlock:(onSuccess) block {
    dlog();
    
    myblock = block;
        
    // create the request.
    NSURLRequest *myreq = [NSURLRequest requestWithURL:url
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:10.0f];
    
    // create the connection with the request and start loading the data
    self.conn = [[NSURLConnection alloc] initWithRequest:myreq delegate:self];
    
    if (self.conn) {
        dlog();
    } else {
        dlog();
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    dlog();
    [self.content appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    dlog();
    [self.content setLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    dlog(@"ERROR - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dlog(@"%d bytes of data", [self.content length]);
    
    myblock(self.content);
}

@end
