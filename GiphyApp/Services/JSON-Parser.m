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
    
//    if(url){
//        self.title = [[NSMutableString alloc] init];
//        self.pubDate = [[NSMutableString alloc] init];
//        self.trendingDate = [[NSMutableString alloc] init];
//        self.smallURL = [[NSMutableString alloc] init];
//        self.largeURL = [[NSMutableString alloc] init];
//        self.results = [[NSMutableDictionary alloc] init];
//    
//    }
    NSData *allContentOfJSON = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *error;
    NSMutableDictionary *allGifsInfo = [NSJSONSerialization JSONObjectWithData:allContentOfJSON
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&error];
    if(error){
        NSLog(@"Error with JSON-parsing - %@",[error localizedDescription]);
    } else {
        NSArray *dataFromJSONDataTag = allGifsInfo[@"data"];
        //NSLog(@"dataFromJSONDataTag - %@",dataFromJSONDataTag);
        return dataFromJSONDataTag;
//        for (NSDictionary *partOfJSON in dataFromJSONDataTag) {
//            self.title = partOfJSON[@"title"];
//            self.pubDate = partOfJSON[@"import_datetime"];
//            self.trendingDate = partOfJSON[@"trending_datetime"];
//            NSMutableDictionary *dataFromJSONImagesTag = [NSMutableDictionary dictionaryWithDictionary:partOfJSON[@"images"]];
//            NSMutableDictionary *dataFromJSONPreviewTag = [NSMutableDictionary dictionaryWithDictionary:dataFromJSONImagesTag[@"preview"]];
//            NSMutableDictionary *dataFromJSONOriginalTag = [NSMutableDictionary dictionaryWithDictionary:dataFromJSONImagesTag[@"original"]];
//            self.smallURL = dataFromJSONPreviewTag[@"mp4"];
//            self.largeURL = dataFromJSONOriginalTag[@"mp4"];
//
//            [self.results setObject:self.title forKey:@"title"];
//            [self.results setObject:self.pubDate forKey:@"pubDate"];
//            [self.results setObject:self.trendingDate forKey:@"trendingDate"];
//            [self.results setObject:self.smallURL forKey:@"smallURL"];
//            [self.results setObject:self.largeURL forKey:@"largeURL"];
//            //NSLog(@"INSIDE THE LOOP - %@",self.results);
//            return self.results;
//        }
    }
    
    return nil;
}
@end
