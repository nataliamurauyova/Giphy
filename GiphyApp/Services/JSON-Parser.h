//
//  JSON-Parser.h
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/22/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSON_Parser : NSObject


-(NSArray*)parseJSONFromURL:(NSString*)url;

@end
