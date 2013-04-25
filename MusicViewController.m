//
//  MusicViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-22.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "MusicViewController.h"
#import "JSON.h"
#import "Book.h"
#import "SecondMusicViewController.h"

@interface MusicViewController ()
@property(nonatomic,retain)NSMutableData *responseData;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)Book *book;

@end

@implementation MusicViewController

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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/%@?apikey=0dea1ee3719c992829be5caa54d5cb78",self.musicID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"乐评" style:UIBarButtonItemStyleDone target:self action:@selector(xiangguanmessage)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];

    

    
}

- (void)didReceiveMemoryWarning
{
    
}


-(void)xiangguanmessage
{
    
    
    SecondMusicViewController *secondmusic = [[SecondMusicViewController alloc]initWithStyle:UITableViewStylePlain];
    secondmusic.ID = self.musicID;
    secondmusic.Name = self.musicName;
    
    
    UINavigationController *navigation1 = [[UINavigationController alloc]initWithRootViewController:secondmusic];
    navigation1.navigationBar.tintColor = [UIColor grayColor];
    
    
    [self presentViewController:navigation1 animated:YES completion:nil];

    
    
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
    NSLog(@"%@",_xmlDic3);
    
    
    
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSString* esc1 = [responseString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);
    
    NSMutableArray *books = [NSMutableArray array];
   // NSArray *MovieList3 = [_xmlDic3 objectForKey:@"attrs"];
    
   
   
        Book *book = [[[Book alloc]init]autorelease];
    book.pubdate =  [[[_xmlDic3 objectForKey:@"attrs"]objectForKey:@"pubdate"]lastObject];
        book.publish = [[[_xmlDic3 objectForKey:@"attrs"]objectForKey:@"publisher"]lastObject];
    book.author = [[[_xmlDic3 objectForKey:@"attrs"]objectForKey:@"singer"]lastObject];;
        book.summay = [[[_xmlDic3 objectForKey:@"attrs"]objectForKey:@"tracks"]lastObject];
    book.bookString = [_xmlDic3 objectForKey:@"image"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
       // NSLog(@"%@",book.publish);
        
        NSLog(@"%@",book.pubdate);
    
    NSLog(@"%@",book.author);
        
         NSLog(@"%@",book.publish);
        NSLog(@"%@",book.summay);
        self.books = books;
        
        [self.books addObject:book];
   
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
 
    if(indexPath.section==0){
        
    
        // 标题
        static NSString *identifier = @"MessageTitleCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }  //cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            Book *book = [self.books objectAtIndex:indexPath.row];
            
           
            NSLog(@"124312342354235%@",book.publish);
            
            UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 32.0, 80.0, 30.0)];
            label0.textAlignment = NSTextAlignmentCenter;
            label0.backgroundColor = [UIColor clearColor];
            label0.font = [UIFont systemFontOfSize:12.0];
            label0.numberOfLines=0;
            label0.text = book.author;
            NSLog(@"%@",book.author);
            
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
            label3.text = book.pubdate;
            
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(90.0, 79.0, 30.0, 30.0)];
            label4.textAlignment = NSTextAlignmentCenter;
            label4.backgroundColor = [UIColor clearColor];
            label4.font = [UIFont systemFontOfSize:12.0];
            label4.numberOfLines=0;
            
            label4.text = @"出版:";
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(90.0, 54.0, 30.0, 30.0)];
            label5.textAlignment = NSTextAlignmentCenter;
            label5.backgroundColor = [UIColor clearColor];
            label5.font = [UIFont systemFontOfSize:12.0];
            label5.numberOfLines=0;
            
            label5.text = @"日期:";
            
            UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(90.0, 30.0, 30.0, 30.0)];
            label6.textAlignment = NSTextAlignmentCenter;
            label6.backgroundColor = [UIColor clearColor];
            label6.font = [UIFont systemFontOfSize:12.0];
            label6.numberOfLines=0;
            
            label6.text = @"演唱:";
        
        
        [self.tableView addSubview:label0];
         [self.tableView addSubview:label2];
        
            [self.tableView addSubview:label3];
             [self.tableView addSubview:label4];
             [self.tableView addSubview:label5];
        
         [self.tableView addSubview:label6];
        
            cell.imageView.image = self.musicImage;
        
        
        [label6 release];
        [label5 release];
        [label4 release];
        [label3 release];
        [label2 release];
        [label0 release];

            
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
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
             Book *book = [self.books objectAtIndex:indexPath.row];
            cell.textLabel.text= self.musicName;
            cell.textLabel.font = [UIFont systemFontOfSize:18.0];
            cell.imageView.image = book.bookImage;
            
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
            NSLog(@"%@",book.summay);
            label1.numberOfLines=0;
            [label1 sizeToFit];
            [cell.contentView addSubview:label1];
            
            [label1 release];
            
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

    
    // Configure the cell...
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"作品:";
    }
    else if(section ==1)
    {
        return @"歌曲名称:";
    }
    else
    {
        return @"专辑列表:";
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath


{
    if(indexPath.section==0)
    {
        return 85;
    }
    else if(indexPath.section==1)
    {
        
        return 60;
    }
    else
    {
        
        
        
        Book *book = [self.books  objectAtIndex:indexPath.row];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0];
        
        label1.text =book.summay;
        NSLog(@"%@",book.summay);
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
