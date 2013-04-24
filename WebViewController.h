//
//  WebViewController.h
//  GitDouBan
//
//  Created by ibokan on 13-4-24.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOUOAuthService.h"

@interface WebViewController : UIViewController<UIWebViewDelegate,DOUOAuthServiceDelegate>
- (id)initWithRequestURL:(NSURL *)aURL;
@end
