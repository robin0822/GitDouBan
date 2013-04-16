//
//  Movie.h
//  GitDouBan
//
//  Created by ibokan on 13-4-16.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property(nonatomic,retain)NSString *movieID;
@property(nonatomic,retain)NSString *movieName;
@property (nonatomic, retain) NSString *thumbnailURLString;
@property (nonatomic, retain) UIImage *thumbnail;
@end
