//
//  Downloader.m
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/24/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import "Downloader.h"
#import "GiphyFileManager.h"

@implementation Downloader
-(BOOL)downloadFromLink:(NSString*)urlString : (void(^)(NSData *data))complition{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        complition(data);
    });
    return true;
}
- (void)fetchGifWithUrl:(NSString*)strUrl andComplition:(void(^)(NSData*data, NSURL *locationUrl))complition {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [defaultSession downloadTaskWithURL:[NSURL URLWithString:strUrl] completionHandler:^(NSURL* _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        NSArray *urls = [defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
        NSURL *cacheDirectory = [urls objectAtIndex:0];
        NSURL *originalUrl = [NSURL URLWithString:[location lastPathComponent]];
        NSURL *desctinationUrl = [cacheDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
        [defaultManager copyItemAtURL:location toURL:desctinationUrl error:nil];
        NSData *data = [NSData dataWithContentsOfURL:desctinationUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complition(data, desctinationUrl);
        });
        
    }];
    [downloadTask resume];
}
- (void)fetchGifWithUrlAndError:(NSString*)strUrl andComplition:(void(^)(NSData*data, NSURL *locationUrl, NSError *error ))complition {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [defaultSession downloadTaskWithURL:[NSURL URLWithString:strUrl] completionHandler:^(NSURL* _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        

        //GiphyFileManager *fileManager = [[GiphyFileManager alloc] init];
        NSURL *destinationUrl = [GiphyFileManager copyToCache:location];
        NSData *data = [NSData dataWithContentsOfURL:destinationUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complition(data, destinationUrl, error);
        });
        
    }];
    [downloadTask resume];
}
@end
