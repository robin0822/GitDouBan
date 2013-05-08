//
//  FirstBookViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-5-6.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "FirstBookViewController.h"
#import "JSON.h"
#import "QyhCell.h"
#import "Author.h"
#import "BookSecondViewController.h"
@interface FirstBookViewController ()
{
    
    
     UITableView * tableV;
}
@property(nonatomic,retain) UITableView *view;
@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain) NSMutableArray *authors;
@property(nonatomic,retain)Author *author;

@end

@implementation FirstBookViewController




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
    self.navigationItem.title = @"热门图书";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    NSString *urlString = @"http://api.shupeng.com/hotbook?psize=30&p=1";
    NSString *appkey = @"f8518e0dfc52bd3624ae041135b1ad29";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [connection start];
   

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    self.responseData1 = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData1 appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //[NSThread detachNewThreadSelector:@selector(loadAndRefresh:) toTarget:self withObject:connection];
    
    NSString * xml = [[[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding]autorelease];
    NSDictionary *_xmlDic = [xml JSONValue];
    NSLog(@"%@",_xmlDic);
    
    NSMutableArray *authors = [NSMutableArray array];
    NSArray *MovieList4 = [_xmlDic objectForKey:@"result"];
   // NSLog(@"%@",MovieList4);
    for(NSDictionary *_dic4 in MovieList4)
    {
        Author *author = [[[Author alloc]init]autorelease];
        author.authorName =  [_dic4 objectForKey:@"name"];
        author.authorString = [_dic4 objectForKey:@"thumb"];
        author.authorId = [_dic4 objectForKey:@"bookid"];
        NSString *str = @"http://a.cdn123.net/img/m/";
        str = [str stringByAppendingString:author.authorString];
        
        
        //author.authorId = [_dic4 objectForKey:@"id"];
        NSData *thumbnailData4 = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        author.authorImage = [UIImage imageWithData:thumbnailData4];
        
       
        
        self.authors = authors;
        
        [self.authors addObject:author];
        
        //[self performSelectorOnMainThread:@selector(refreshTableViewCellFormuisc) withObject:author waitUntilDone:NO];
        
    }
    [tableV reloadData];

    
   }




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.authors count];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"MovieCell";
    QyhCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
  
    
    if (!cell)
    {
        cell = [[[QyhCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    Author *author = [self.authors objectAtIndex:indexPath.row];
    cell.nameLabel.text = author.authorName;
    if(author.authorImage)
    {
        cell.imageV.image = author.authorImage;
    }
      
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BookSecondViewController *booksecond = [[BookSecondViewController alloc]initWithStyle:UITableViewStylePlain];
    
    Author *author = [self.authors objectAtIndex:indexPath.row];
    booksecond.BookId = author.authorId;
    booksecond.BookName = author.authorName;
    booksecond.bookImage = author.authorImage;
    
    
    
    
    
    
    
    [self.navigationController pushViewController:booksecond animated:YES];
    [booksecond release];
    
}















@end
