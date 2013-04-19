//
//  SecondViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-18.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SecondViewController.h"
#import "Book.h"
#import "JSON.h"

@interface SecondViewController ()
@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)Book *book;
@end

@implementation SecondViewController

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
    self.navigationItem.title = self.Name;
    
    NSString *str = self.ID;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/online/%@",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];


    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
