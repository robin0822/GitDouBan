//
//  SeconAddViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SeconAddViewController.h"
#import "JSON.h"
#import "Book.h"
#import "Author.h"

@interface SeconAddViewController ()

-(CGFloat)hanggao;

@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain) NSMutableString *string2;
@property(nonatomic,retain)NSDictionary *dicoo;
@property(nonatomic,retain) NSMutableArray *ayyay;
@property(nonatomic,retain)Author *author;
@property(nonatomic,retain)NSString *str2;

@end

@implementation SeconAddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.ayyay=[NSMutableArray array];
    }
    return self;
}

-(CGFloat)hanggao
{
    
    
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)] autorelease];
    label1.textAlignment = NSTextAlignmentCenter;
    
    label1.font = [UIFont systemFontOfSize:15.0];
    //label1.textColor = [UIColor orangeColor];
    label1.text = self.str2;
    label1.numberOfLines=0;
    [label1 sizeToFit];
    
    return  label1.frame.size.height+30;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.navigationItem.title = self.Name;
   // NSLog(@"%@",self.ID);
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/celebrity/%@?apikey=0dea1ee3719c992829be5caa54d5cb78",self.ID]];
    NSLog(@"!!!%@",self.ID);

    NSURLRequest *request3 = [[NSURLRequest alloc]initWithURL:url3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request3 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
//    connection.name = @"movie";
    // 开始异步请求
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
    NSLog(@"19998888%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
    
    Book *book = [[[Book alloc]init]autorelease];
    //book.bookTitle =  [[_xmlDic3 objectForKey:@""]objectForKey:@"title"];
    book.Name = [_xmlDic3 objectForKey:@"name"];
    book.Name_en = [_xmlDic3 objectForKey:@"name_en"];
    book.born = [_xmlDic3 objectForKey:@"born_place"];
    book.gender = [_xmlDic3 objectForKey:@"gender"];
    book.bookString = [[_xmlDic3 objectForKey:@"avatars"]objectForKey:@"small"];
    NSArray *workArray=[_xmlDic3 objectForKey:@"works"];
    //NSMutableArray *ayyay = [NSMutableArray array];
    [self.ayyay removeAllObjects];
    for (NSDictionary *di in workArray) {
        
        Author *author = [[Author alloc]init];
        //book.bookTitle = [[di objectForKey:@"subject"] objectForKey:@"title"];
        //self.string2 = book.bookTitle;
        author.authorName = [[di objectForKey:@"subject"]objectForKey:@"title"];
        [self.ayyay addObject:author];
        [author release];
    }
    
    
    
    //NSLog(@"%@",book.bookTitle);
    NSLog(@"%@",book.Name);
    NSLog(@"%@",book.Name_en);
    NSLog(@"%@",book.born);
    NSLog(@"%@",book.gender);
    
    
    self.books=books;
    
//    book.bookDescription = [_xmlDic3 objectForKey:@""]
//    NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
//    book.bookImage = [UIImage imageWithData:thumbnailData1];
//    self.books= books;
    // NSLog(@"bwajhfgfhwgfjwfjkfj%@",[_xmlDic3 objectForKey:@"desc"]);
//    self.restlabel.text= book.bookTitle;
//    self.books = books;
//    self.restlabel2.text = book.bookDescription;
//    NSLog(@"pppppp%@",self.restlabel.text);
    
            [self.books addObject:book];
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

    return 2;
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
        
        Book *book= [self.books objectAtIndex:indexPath.row];
        cell.textLabel.text = book.Name;
        //cell.detailTextLabel.text = book.born;
        //NSLog(@"55555%@",book.born);
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(190.0, 65.0, 100.0, 60.0)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:12.0];
        label2.numberOfLines=0;
//        NSString *stu =@"出生地:";
//        stu = [stu stringByAppendingFormat:@"%@",book.born];
        
        label2.text = book.born;
        NSLog(@"00000%@",label2.text);
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(160.0, 85.0, 40.0, 30.0)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:12.0];
        label3.numberOfLines=0;
        label3.text = book.gender;
        [self.tableView addSubview:label3];
        
        //[label2 sizeToFit];
        [self.tableView addSubview:label2];
        
        //cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
//        cell.textLabel.text = self.movieName;
//        cell.textLabel.textColor = [UIColor grayColor];
//        cell.imageView.image = self.movieimage;
    }
//    else if (indexPath.section == 1)
//    {
//        // 标题
//        static NSString *identifier1 = @"MessageTitleCell";
//        
//        // 重用
//        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier1];
//        if (!cell)
//        {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
//            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//         //cell.textLabel.text = self.label.text;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
        //Book *book = [self.books objectAtIndex:indexPath.row];
        NSString *str=@"";
        for(Author *author in self.ayyay)
        {
            
            str = [str stringByAppendingFormat:@"%@;",author.authorName];
            NSLog(@"ddfdfdsfsdfddd%@",author.authorName);
            
        }

        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        //label1.textColor = [UIColor orangeColor];
        //label1.text =self.restlabel.text;
//        //label1.text = book.bookTitle;
        label1.text = str;
        //self.str2 = str;
        label1.numberOfLines=0;
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];
        //NSLog(@"%@",book.bookTitle);
               //cell.textLabel.numberOfLines=0;
        //cell.textLabel.text=str;
        
        
        //cell.detailTextLabel.text = self.restlabel.text;
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 100;
        
    }
    else
    {
        
        return 80;
    }
    
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return @"导演简介:";
        
    }
    else 
    {
       return @"相关作品:";
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
