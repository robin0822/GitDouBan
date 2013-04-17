//
//  Author.m
//  GitDouBan
//
//  Created by ibokan on 13-4-17.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "Author.h"

@implementation Author

-(void)dealloc
{
    
    [_authorId release];
    [_authorName release];
    [_authorString release];
    [_authorImage release];
    [super dealloc];
    
}
@end
