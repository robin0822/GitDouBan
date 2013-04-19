//
//  ActionViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "ActionViewController.h"
#import "Book.h"
#import "JSON.h"

@interface ActionViewController ()
@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)UILabel *label1;
@end



@implementation ActionViewController

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
    
    
    NSString *str = self.Id;
    NSLog(@"%@",str);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/online/%@",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];

    
    
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
    NSString * xml3 = [[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic3 = [xml3 JSONValue];
    // NSLog(@"adsasdas%@",responseString3);
    NSLog(@"%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
   
           Book *book = [[[Book alloc]init]autorelease];
        book.bookTitle =  [_xmlDic3 objectForKey:@"desc"];
        book.bookID = [_xmlDic3 objectForKey:@"id"];
        book.bookString = [[_xmlDic3 objectForKey:@"images"]objectForKey:@"small"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
        NSLog(@"bwajhfgfhwgfjwfjkfj%@",[_xmlDic3 objectForKey:@"desc"]);
    self.label1.text = book.bookTitle;
        self.books = books;
        
//        [self.books addObject:book];
        [self.tableView reloadData];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0)
    {
        // 标题
        static NSString *identifier = @"MessageTitleCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        
        cell.textLabel.text = self.Name;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = self.Image;
    }
    else if (indexPath.section == 1)
    {
        // 标题
        static NSString *identifier1 = @"MessageTitleCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 输入标题用的text field
        //        UILabel *restlabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 150.0, 40.0)];
        //        restlabel.font = [UIFont systemFontOfSize:18.0];
        //        restlabel.text = @"";
        //        self.restlabel = restlabel;
        //        [cell.contentView addSubview:restlabel];
        //        [restlabel release];
        //cell.textLabel.text = self.label.text;
        
        
        
    }
    else
    {
        // 标题
        static NSString *identifier = @"MessageContentCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        
        //cell.textLabel.text = message.content;
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 100.0, 100.0)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        //label1.textColor = [UIColor orangeColor];
        label1.text =@"";
        label1.numberOfLines=0;
        self.label1 = label1;
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];
        
        
        //cell.detailTextLabel.text = self.restlabel.text;
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        return 100.0;
    }
    else if(indexPath.section == 1)
    {
        return 60.0;
    }
    else
    {
        return 300.0;
    }
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
