//
//  Movie.m
//  GitDouBan
//
//  Created by ibokan on 13-4-16.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "Movie.h"

@implementation Movie
-(void)dealloc
{
    [_movieID release];
    [_movieName release];
    
    [_thumbnail release];
    [_thumbnailURLString release];
    [super dealloc];
    
    
}
@end
