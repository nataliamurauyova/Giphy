//
//  JSON-Parser.m
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import "JSON-Parser.h"
@interface JSON_Parser()
@property(nonatomic) NSMutableString* title;
@property(nonatomic) NSMutableString* smallURL;
@property(nonatomic) NSMutableString *largeURL;
@property(nonatomic) NSMutableString *pubDate;
@property(nonatomic) NSMutableString *trendingDate;


@end


@implementation JSON_Parser
-(NSArray*)parseJSONFromURL:(NSString*)url{
    
    NSData *allContentOfJSON = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *error;
    NSMutableDictionary *allGifsInfo = [NSJSONSerialization JSONObjectWithData:allContentOfJSON
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&error];
    if(error){
        NSLog(@"Error with JSON-parsing - %@",[error localizedDescription]);
    } else {
        NSArray *dataFromJSONDataTag = allGifsInfo[@"data"];
        return dataFromJSONDataTag;
    }
    
    return nil;
}
@end
