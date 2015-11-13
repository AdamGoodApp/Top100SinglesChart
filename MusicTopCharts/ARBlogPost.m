//
//  ARBlogPost.m
//  MusicTopCharts
//
//  Created by Adam Rais on 13/06/2014.
//  Copyright (c) 2014 Adam Rais. All rights reserved.
// Implement Json pod.

#import "ARBlogPost.h"

@implementation ARBlogPost

-(id)initWithSongTitle:(NSString *)songTitle {
    self = [super init];
    if (self) {
        _songTitle = songTitle;
        self.artist = nil;
        self.image = nil;
    }
    return self;
}

+(id)blogPostWithSongTitle:(NSString *)songTitle {
    return [[self alloc] initWithSongTitle:songTitle];
}

-(NSArray *) blogData {
    NSURL *jsonURL = [NSURL URLWithString:@"http://www.kimonolabs.com/api/290xhci4?apikey=1a1f5f323969d5157af8a8be857026c2"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    
    NSError *jsonError = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    
    NSArray *jsonArray = [[jsonDictionary objectForKey:@"results"] objectForKey:@"collection1"];
    
    if (blogData == nil) {
        blogData = jsonArray;
    }
    return blogData;
}

-(NSURL *) imageURL {
    return [NSURL URLWithString:self.image];
}

@end
