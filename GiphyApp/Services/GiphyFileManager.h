//
//  GiphyFileManager.h
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/27/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiphyFileManager : NSObject
@property(nonatomic) NSData *data;
@property(nonatomic) NSURLSession *session;
@property(nonatomic) NSURLSessionDownloadTask *downloadTask;
@property(nonatomic) NSString *urlForImage;

-(void)loadURL:(NSString*) url :(void(^)(NSString *imageDestination))complition;
@end
