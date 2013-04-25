//
//  Student.m
//  GitDouBan
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
       
        self.bookName = [aDecoder decodeObjectForKey:@"bname"];
        self.bookString = [aDecoder decodeObjectForKey:@"kkname"];
        self.bookTitle = [aDecoder decodeObjectForKey:@"mmname"];
        self.bookPhone = [aDecoder decodeObjectForKey:@"ccname"];
        self.bookID = [aDecoder decodeObjectForKey:@"mccname"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_bookName forKey:@"bname"];
    [aCoder encodeObject:_bookString forKey:@"kkname"];
    [aCoder encodeObject:_bookTitle forKey:@"mmname"];
     [aCoder encodeObject:_bookPhone forKey:@"ccname"];
    [aCoder encodeObject:_bookID forKey:@"mccname"];
}





@end
