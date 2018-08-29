//
//  GiphyFileManager.m
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/27/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import "GiphyFileManager.h"

@implementation GiphyFileManager
-(void)loadURL:(NSString*) url :(void(^)(NSString *imageDestination))complition{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error - %@", [error localizedDescription]);
        }
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *documentsDirectory = [urls objectAtIndex:0];
        NSURL *originalURL = [NSURL URLWithString:[location lastPathComponent]];
        NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
        
        [fileManager copyItemAtURL:location toURL:destinationURL error:nil];
        
        
        
        NSArray *tempArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [tempArray objectAtIndex:0];
        
        NSString *appDir = [docsDir stringByAppendingString:@"/Giphy/"];
        
        
        if(![fileManager fileExistsAtPath:appDir]){
            [fileManager createDirectoryAtPath:appDir withIntermediateDirectories:NO attributes:nil error:&error];
        }
        
        appDir =  [appDir stringByAppendingFormat:@"/%@",[[self.downloadTask response] suggestedFilename]];
        
        
        if([fileManager fileExistsAtPath:appDir]){
            NSLog([fileManager removeItemAtPath:appDir error:&error]?@"deleted":@"not deleted");
        }
        BOOL fileCopied = [fileManager moveItemAtPath:[location path] toPath:appDir error:&error];
        NSLog(fileCopied ? @"Yes" : @"No");
        complition(appDir);
    }];
    
    [self.downloadTask resume];
    
}
@end
