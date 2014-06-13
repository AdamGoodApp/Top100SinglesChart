//
//  ARBlogPost.h
//  MusicTopCharts
//
//  Created by Adam Rais on 13/06/2014.
//  Copyright (c) 2014 Adam Rais. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARBlogPost : NSObject {
    NSArray *blogData;
}

@property(nonatomic,strong) NSString *songTitle;
@property(nonatomic,strong) NSString *artist;
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong,readonly) NSArray *blogData;
@property(nonatomic,strong) NSMutableArray *jsonMutable;

-(id)initWithSongTitle:(NSString *) songTitle;
+(id)blogPostWithSongTitle:(NSString *) songTitle;

-(NSURL *) imageURL;

@end
