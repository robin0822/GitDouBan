//
//  FirstViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-17.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON.h"
#import "Book.h"

@interface FirstViewController ()
@property (nonatomic, retain) NSMutableData *responseData;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)NSMutableArray *books;
@end

@implementation FirstViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = self.movieID;
    
//    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",str]]];
//   // NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:NULL error:NULL];
//     NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request1 delegate:self];
//     NSString *responseString1= [[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",responseString1);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self]autorelease];
    
//    NSString * xml1 = [[NSString alloc]initWithData:responseData1 encoding:NSUTF8StringEncoding];
//    NSDictionary *_xmlDic1 = [xml1 JSONValue];
//    NSLog(@"%@",_xmlDic1);
    self.navigationItem.title = self.movieName;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30.0, 110.0, 320.0, 100.0)];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
        NSString * xml1 = [[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
        NSDictionary *_xmlDic1 = [xml1 JSONValue];
        NSLog(@"%@",_xmlDic1);
    
    
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSString* esc1 = [responseString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);

    
    

    NSMutableArray *books = [NSMutableArray array];
    NSArray *MovieList3 = [_xmlDic1 objectForKey:@"directors"];
    
    for(NSDictionary *_dic3 in MovieList3)
    {
        Book *book = [[[Book alloc]init]autorelease];
        book.bookTitle =  [_dic3 objectForKey:@"name"];
        book.bookString = [[_dic3 objectForKey:@"avatars"]objectForKey:@"small"];
        book.bookDescription = [_xmlDic1 objectForKey:@"summary"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
        NSLog(@"++++%@",book.bookTitle);
        NSLog(@"fuck%@",book.bookDescription);
        NSLog(@"%@",book.bookDescription);
        self.books = books;
        
        [self.books addObject:book];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
