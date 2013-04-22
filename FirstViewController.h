//
//  FirstViewController.h
//  GitDouBan
//
//  Created by ibokan on 13-4-18.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController
@property(nonatomic,retain)NSString *movieID;
@property(nonatomic,retain)NSString *movieName;
@property(nonatomic,retain)NSMutableArray *kamovie;
@property(nonatomic,retain)UIImage *movieimage;
@property(nonatomic,retain)NSString *movieString;
@end
