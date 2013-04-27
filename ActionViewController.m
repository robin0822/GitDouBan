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
#import "QyhOOOViewController.h"

@interface ActionViewController ()
@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *restlabel;
@property(nonatomic,retain)UILabel *restlabel2;
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
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];
    
    UILabel *restlabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, -500.0, 320, 450.0)];
    restlabel.font = [UIFont systemFontOfSize:15.0];
    restlabel.text = @"";
    self.restlabel = restlabel;
    [self.tableView addSubview:restlabel];
    

    UILabel *restlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0, -100.0, 320, 50.0)];
    restlabel2.font = [UIFont systemFontOfSize:15.0];
    restlabel2.text = @"";
    self.restlabel2 = restlabel2;
    [self.tableView addSubview:restlabel2];
    [restlabel2 release];
    [restlabel release];
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
    NSString * xml3 = [[[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding]autorelease];
    NSDictionary *_xmlDic3 = [xml3 JSONValue];
    // NSLog(@"adsasdas%@",responseString3);
    NSLog(@"%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
   
           Book *book = [[[Book alloc]init]autorelease];
        book.bookTitle =  [_xmlDic3 objectForKey:@"desc"];
        book.bookID = [_xmlDic3 objectForKey:@"id"];
        book.bookString = [[_xmlDic3 objectForKey:@"images"]objectForKey:@"small"];
    NSLog(@"!!!!!!!%@",book.bookID);
    
    book.bookDescription = [[_xmlDic3 objectForKey:@"owner"]objectForKey:@"name"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
       // NSLog(@"bwajhfgfhwgfjwfjkfj%@",[_xmlDic3 objectForKey:@"desc"]);
   self.restlabel.text= book.bookTitle;
        self.books = books;
    self.restlabel2.text = book.bookDescription;
    NSLog(@"pppppp%@",self.restlabel.text);
        
//        [self.books addObject:book];
        [self.tableView reloadData];
    
   // [_xmlDic3 release];
    
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
        
        //cell.textLabel.text = self.Name;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = self.Image;
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 20.0, 180.0, 70.0)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:15.0];
        //label1.textColor = [UIColor orangeColor];
        label3.text = self.Name;
        label3.numberOfLines=0;
        
        
        [cell.contentView addSubview:label3];
        [label3 release];
        
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
        cell.textLabel.text = self.restlabel2.text;
        
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
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        //label1.textColor = [UIColor orangeColor];
        label1.text =self.restlabel.text;
        label1.numberOfLines=0;
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];

        [label1 release];
        
        
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
        
        UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)]autorelease];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        //label1.textColor = [UIColor orangeColor];
        label1.text =self.restlabel.text;
        label1.numberOfLines=0;
        [label1 sizeToFit];
        return label1.frame.size.height+20;
        [label1 release];
        
        //return 600.0;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"活动:";
    }
    else if (section == 1)
    {
        return @"发起者";
    }
    else
    {
        return @"活动要求:";
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
    
    QyhOOOViewController *qyhoo = [[QyhOOOViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:qyhoo animated:YES];
    
    [qyhoo release];

}

@end
