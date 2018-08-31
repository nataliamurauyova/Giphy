//
//  GiphyFileManager.m
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/27/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import "GiphyFileManager.h"

@implementation GiphyFileManager


+ (NSURL*)copyToCache:(NSURL*)location {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *urls = [defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *cacheDirectory = [urls objectAtIndex:0];
    NSURL *originalUrl = [NSURL URLWithString:[location lastPathComponent]];
    NSURL *destinationUrl = [cacheDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
    [defaultManager copyItemAtURL:location toURL:destinationUrl error:nil];
    return destinationUrl;
}

@end
