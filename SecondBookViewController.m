//
//  SecondBookViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-24.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SecondBookViewController.h"
#import "JSON.h"
#import "Book.h"

@interface SecondBookViewController ()
@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain) NSMutableArray *books;
@property(nonatomic,retain)Book *book;
@end

@implementation SecondBookViewController

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
    
    self.navigationItem.title = self.Name;
    NSLog(@"adsfasdfg%@",self.ID);
    
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(closeInterface)];
    self.navigationItem.leftBarButtonItem = returnButton;
    
    [returnButton release];

    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.douban.com/book/subject/%@/reviews?alt=json&apikey=0dea1ee3719c992829be5caa54d5cb78",self.ID]];
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}



-(void)closeInterface
{
    // 关闭当前modal view
    //[self dismissModalViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
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
    
    
//    NSString * xml3 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
//    NSDictionary *_xmlDic3 = [xml3 JSONValue];
//    NSLog(@"%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
    // NSArray *MovieList3 = [_xmlDic3 objectForKey:@"books"];
    NSArray *  MovieList  =   [_xmlDic3 objectForKey:@"entry"];
    for(NSDictionary *_dic in MovieList)
    {

    
    Book *book = [[[Book alloc]init]autorelease];
    //book.bookTitle =  [_dic3 objectForKey:@"title"];
    //book.bookID = [_dic3 objectForKey:@"id"];
    book.author= [[_dic objectForKey:@"title"]objectForKey:@"$t"];
    book.summay = [[_dic objectForKey:@"summary"]objectForKey:@"$t"];
    book.publish = [[[_dic objectForKey:@"author"]objectForKey:@"name"]objectForKey:@"$t"];
    book.pubdate = [[_dic objectForKey:@"published"]objectForKey:@"$t"];
    book.pages = [_xmlDic3 objectForKey:@"pages"];
    book.price = [_xmlDic3 objectForKey:@"price"];
    book.bookID = [_xmlDic3 objectForKey:@"id"];
        
        
        
    
     NSLog(@"%@",book.summay);
        NSLog(@"sdfghsag%@",book.author);
        NSLog(@"%@",book.publish);
        NSLog(@"%@",book.pubdate);
    //        book.bookString = [_xmlDic3 objectForKey:@"books"];
    //        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
    //        book.bookImage = [UIImage imageWithData:thumbnailData1];
    
    
    self.books = books;
    
    [self.books addObject:book];
    [self.tableView reloadData];

    
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.books count];
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
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 5.0, 200.0, 130.0)];
    label.text = book.summay;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14.0];
    [cell.contentView addSubview:label];
    UILabel*label2 =[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 40.0, 30.0)];
    label2.text = @"书评者:";
    label2.numberOfLines = 0;
    label2.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(40.0, 0.0, 55.0, 30.0)];
    label1.text = book.publish;
    label1.numberOfLines=0;
    label1.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label1];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(35.0, 40.0, 63.0, 50.0)];
    label3.text = book.author;
    label3.numberOfLines=0;
    label3.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 40.0, 33.0, 30.0)];
    label4.text = @"题目:";
    label4.numberOfLines=0;
    label4.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(35.0, 85.0, 63.0, 50.0)];
    label5.text = book.pubdate;
    label5.numberOfLines=0;
    label5.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label5];
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 80.0, 33.0, 30.0)];
    label6.text = @"时间:";
    label6.numberOfLines=0;
    label6.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:label6];
    
    
    [label release];
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
    [label5 release];
    [label6 release];
    
    
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
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
