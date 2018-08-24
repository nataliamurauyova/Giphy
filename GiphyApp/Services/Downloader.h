//
//  Downloader.h
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/24/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject

-(void)downloadFromLink:(NSString*)url : (void(^)(NSData *data))complition;

@end
