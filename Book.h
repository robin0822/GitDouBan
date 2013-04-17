//
//  Book.h
//  GitDouBan
//
//  Created by ibokan on 13-4-17.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(nonatomic,retain)NSString *bookID;
@property(nonatomic,retain)NSString *bookTitle;
@property(nonatomic,retain)NSString *bookString;
@property(nonatomic,retain)UIImage *bookImage;
@property(nonatomic,retain)NSString *bookDescription;

@end
