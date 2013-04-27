//
//  SecondMovieViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SecondMovieViewController.h"
#import "JSON.h"

@interface SecondMovieViewController ()
@property(nonatomic,retain)NSMutableData *responseData1;
@end

@implementation SecondMovieViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    NSString *urlString = @"https://api.douban.com/feed/review/book";
//    NSString *appkey = @"Bearer 8dd3053775ee31fda9790fa661ca95f7";
//    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [request2 setValue:appkey forHTTPHeaderField:@"Authorization"];
//    NSData *responseData2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:NULL error:NULL];
//    
//    
//    NSString * xml2 = [[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
//    NSDictionary *_xmlDic2 = [xml2 JSONValue];
//    NSLog(@"%@",_xmlDic2);


//    NSURL *url = [NSURL URLWithString:@"http://api.douban.com/feed/review/book"];
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
//    
//    [connection start];

    
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
    //
    //    [NSThread detachNewThreadSelector:@selector(loadAndRefresh:) toTarget:self withObject:connection];
    NSString * xml3 = [[[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding]autorelease];
    NSDictionary *_xmlDic3 = [xml3 JSONValue];
    NSLog(@"%@",_xmlDic3);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
            // 标题
        static NSString *identifier = @"MessageTitleCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
    cell.textLabel.text = @"API公共接口暂时不可以使用";

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  130.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
