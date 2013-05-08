//
//  BookWebViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-5-6.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "BookWebViewController.h"

@interface BookWebViewController ()

@property(nonatomic,retain) UIWebView *webView;

@end

@implementation BookWebViewController

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
    
    NSString *str = self.Bookstr;
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [webView release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
