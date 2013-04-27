//
//  AboutViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"关于豆瓣";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 30.0, 300.0, 240.0)];
    label.text= @"　豆瓣网站的每个开发管理者也都是豆瓣每日的用户，分享着自己心爱的发现，也从你的参与中受益。我们鼓励你通过点击成员的名号或头像访问别人的个人主页，并充实自己的收藏或评论。这些是豆瓣上最重要和有益的内容。";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
