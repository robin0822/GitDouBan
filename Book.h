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
@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Name_en;
@property(nonatomic,retain)NSString *gender;
@property(nonatomic,retain)NSString *born;

@property(nonatomic,retain)NSString *price;
@property(nonatomic,retain)NSString *publish;
@property(nonatomic,retain)NSString *summay;
@property(nonatomic,retain)NSString *author;
@property(nonatomic,retain)NSString *pages;
@property(nonatomic,retain)NSString *pubdate;


@end
