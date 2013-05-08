//
//  BookSecondViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-5-6.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "BookSecondViewController.h"
#import "Author.h"
#import "JSON.h"
#import "QyhCell.h"
#import "BookWebViewController.h"

@interface BookSecondViewController ()



@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain)NSMutableArray *authors;
@property(nonatomic,retain)Author *author;

@end

@implementation BookSecondViewController

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
    
    
    NSLog(@"%@",self.BookId);
    
    
    NSString *URLstring = [NSString stringWithFormat:@"http://api.shupeng.com/book?id=%@",self.BookId];
    
    NSString *appKey = @"f8518e0dfc52bd3624ae041135b1ad29";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLstring]];
    [request setValue:appKey forHTTPHeaderField:@"User-Agent"];
    
    //获得data数据
   
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
   // NSArray *MovieList4 = [_xmlDic objectForKey:@"result"];
 
//    for(NSDictionary *_dic4 in MovieList4)
//    {
        Author *author = [[[Author alloc]init]autorelease];
        author.authorName =  [[_xmlDic objectForKey:@"result"]objectForKey:@"author"];
        author.authorString = [[_xmlDic objectForKey:@"result"]objectForKey:@"intro"];
        author.authorId = [[_xmlDic objectForKey:@"result"]objectForKey:@"read_url"];
        
    NSLog(@"%@",author.authorName);
    NSLog(@"%@",author.authorString);
    
    NSLog(@"%@",author.authorId);
        self.authors = authors;
        
        [self.authors addObject:author];
    
             
//    }
    [self.tableView reloadData];

    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = self.BookName;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        if(self.bookImage)
        {
            cell.imageView.image = self.bookImage;
        }
        
    }
    else if (indexPath.section == 1)
    {
        // 标题
        static NSString *identifier1 = @"ssageTitleCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
                
         Author *author = [self.authors objectAtIndex:indexPath.row];

        cell.textLabel.text = author.authorName;


    }

    
    else
    {
        static NSString *identifier = @"MeageContentCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    Author *author = [self.authors objectAtIndex:indexPath.row];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:15.0];
    
    label1.text =author.authorString;
    label1.numberOfLines=0;
    [label1 sizeToFit];
    [cell.contentView addSubview:label1];
    [label1 release];

    
    }



    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"图书";
    }
    else if (section == 1)
    {
        return @"导演";
    }
       else
    {
        return @"简介";
    }
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
      
        
        Author *author = [self.authors objectAtIndex:indexPath.row];
        
        UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)]autorelease];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        
        label1.text =author.authorString;
        label1.numberOfLines=0;
        [label1 sizeToFit];
        
       

        
        
        return label1.frame.size.height*1.2;
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
   

    BookWebViewController *webview = [[BookWebViewController alloc]init];
    Author *author = [self.authors objectAtIndex:indexPath.row];
    webview.Bookstr = author.authorId;
    
    
    
    [self.navigationController pushViewController:webview animated:YES];
    [webview release];
    
    
    
    


}

@end
