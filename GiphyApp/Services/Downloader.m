//
//  Downloader.m
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/24/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader
-(void)downloadFromLink:(NSString*)urlString : (void(^)(NSData *data))complition{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        complition(data);
    });
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSData *data = [NSData dataWithContentsOfURL:location];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            complition(data);
//        });
//    }];
//    [downloadTask resume];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    config.allowsCellularAccess = YES;
//    config.waitsForConnectivity = YES;
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error){
//            NSLog(@"Error - %@",[error localizedDescription]);
//        }
//
//         dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
//             complition(data);
//         });
//    }];
//    [dataTask resume];
//
//    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:100.0];
//    [request setHTTPMethod:@"GET"];
//    [request setHTTPBody:postData];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error){
//            NSLog(@"Error - %@",[error localizedDescription]);
//        } else {
//            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*) response;
//            NSLog(@"Response  - %@",httpResponse);
//        }
//                 dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
//                     complition(data);
//                 });
//    }];
//    [dataTask resume];
    
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
        
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        NSArray *urls = [defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
        NSURL *cacheDirectory = [urls objectAtIndex:0];
        NSURL *originalUrl = [NSURL URLWithString:[location lastPathComponent]];
        NSURL *desctinationUrl = [cacheDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
        [defaultManager copyItemAtURL:location toURL:desctinationUrl error:nil];
        NSData *data = [NSData dataWithContentsOfURL:desctinationUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complition(data, desctinationUrl, error);
        });
        
    }];
    [downloadTask resume];
}
@end
