//
//  Student.h
//  GitDouBan
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>

@property(nonatomic,retain)NSString *bookName;
@property(nonatomic,retain)NSString *bookString;
@property(nonatomic,retain)NSString *bookTitle;
@property(nonatomic,retain)NSString *bookPhone;
@property(nonatomic,retain)NSString *bookID;

@end
