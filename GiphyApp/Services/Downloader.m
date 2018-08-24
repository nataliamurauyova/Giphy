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
}
@end
