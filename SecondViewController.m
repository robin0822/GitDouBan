//
//  SecondViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-21.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SecondViewController.h"
#import "Book.h"
#import "JSON.h"
#import "SeconApadViewController.h"

@interface SecondViewController ()
@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;

@end

@implementation SecondViewController

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
    NSString *str = self.ID;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/%@",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self]autorelease];
    NSLog(@"%@",connection);
    
    
   
   
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString * xml3 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic3 = [xml3 JSONValue];
    NSLog(@"%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
   // NSArray *MovieList3 = [_xmlDic3 objectForKey:@"books"];
   
   
            Book *book = [[[Book alloc]init]autorelease];
        //book.bookTitle =  [_dic3 objectForKey:@"title"];
        //book.bookID = [_dic3 objectForKey:@"id"];
         book.author= [[_xmlDic3 objectForKey:@"author"] lastObject];
    book.summay = [_xmlDic3 objectForKey:@"summary"];
    book.publish = [_xmlDic3 objectForKey:@"publisher"];
    book.pubdate = [_xmlDic3 objectForKey:@"pubdate"];
    book.pages = [_xmlDic3 objectForKey:@"pages"];
    book.price = [_xmlDic3 objectForKey:@"price"];
    book.bookID = [_xmlDic3 objectForKey:@"id"];
    
    NSLog(@"%@",book.bookID);
   
//        book.bookString = [_xmlDic3 objectForKey:@"books"];
//        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
//        book.bookImage = [UIImage imageWithData:thumbnailData1];
    
    
    self.books = books;
        
        [self.books addObject:book];
    [self.tableView reloadData];
    
    
}

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
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
//        cell.textLabel.text = self.label2.text;
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 5.0, 100, 30)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = self.Name;
//        [label sizeToFit];
//        
//        [cell.contentView addSubview:label];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Book *book = [self.books objectAtIndex:indexPath.row];
        
        NSLog(@"++++++%@",book.price);
        
        
        UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 32.0, 80.0, 30.0)];
        label0.textAlignment = NSTextAlignmentCenter;
        label0.backgroundColor = [UIColor clearColor];
        label0.font = [UIFont systemFontOfSize:12.0];
        label0.numberOfLines=0;
        label0.text = book.author;
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(120.0, 65.0, 100.0, 60.0)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:12.0];
        label2.numberOfLines=0;
        //        NSString *stu =@"出生地:";
        //        stu = [stu stringByAppendingFormat:@"%@",book.born];
        
        label2.text =book.publish ;
        NSLog(@"00000%@",label2.text);
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 55.0, 80.0, 30.0)];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:12.0];
        label3.numberOfLines=0;
        label3.text = book.price;
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(80.0, 79.0, 30.0, 30.0)];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.backgroundColor = [UIColor clearColor];
        label4.font = [UIFont systemFontOfSize:12.0];
        label4.numberOfLines=0;
        
        label4.text = @"出版:";
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(80.0, 54.0, 30.0, 30.0)];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.backgroundColor = [UIColor clearColor];
        label5.font = [UIFont systemFontOfSize:12.0];
        label5.numberOfLines=0;
        
        label5.text = @"价格:";
        
        UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(80.0, 30.0, 30.0, 30.0)];
        label6.textAlignment = NSTextAlignmentCenter;
        label6.backgroundColor = [UIColor clearColor];
        label6.font = [UIFont systemFontOfSize:12.0];
        label6.numberOfLines=0;
        
        label6.text = @"作者:";
        
        
        [self.tableView addSubview:label6];
        
        [self.tableView addSubview:label0];
        
        [self.tableView addSubview:label4];
        
        [self.tableView addSubview:label5];
        
        
        
        [self.tableView addSubview:label3];
        
        //[label2 sizeToFit];
        [self.tableView addSubview:label2];
       
        
        
        
cell.imageView.image = self.bookImage;

        
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text= self.Name;
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        
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
        
        Book *book = [self.books  objectAtIndex:indexPath.row];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        
        label1.text =book.summay;
        label1.numberOfLines=0;
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];
        
        
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
return cell;

}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"作品:";
    }
    else if(section ==1)
    {
        return @"笔记信息";
    }
    else
    {
        return @"作品简介";
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath


{
    if(indexPath.section==0)
    {
        return 100;
    }
    else if(indexPath.section==1)
    {
        
        return 60;
    }
    else
    {
        return 200;
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
    SeconApadViewController *secondapad = [[SeconApadViewController alloc]initWithStyle:UITableViewStylePlain];
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    secondapad.ID = book.bookID;
    NSLog(@"GTSJDTYJNDTK%@",book.bookID);
    
    
    [self.navigationController pushViewController:secondapad animated:YES];
    
    
    
    
}

@end
