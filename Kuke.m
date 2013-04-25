//
//  Kuke.m
//  GitDouBan
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "Kuke.h"

@implementation Kuke

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        
       
        self.bookTitle = [aDecoder decodeObjectForKey:@"mmname"];
        self.bookPhone = [aDecoder decodeObjectForKey:@"ccname"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_bookTitle forKey:@"mmname"];
    [aCoder encodeObject:_bookPhone forKey:@"ccname"];
}


@end
