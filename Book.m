//
//  Book.m
//  GitDouBan
//
//  Created by ibokan on 13-4-17.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "Book.h"

@implementation Book

-(void)dealloc
{
    [_bookID release];
    [_bookImage release];
    [_bookTitle release];
    [_bookString release];
    [_bookDescription release];
    [super dealloc];
}
@end
