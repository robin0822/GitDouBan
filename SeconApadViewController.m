//
//  SeconApadViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-22.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SeconApadViewController.h"
#import "JSON.h"
#import "Author.h"
@interface SeconApadViewController ()
@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain)NSMutableArray *authors;
@property(nonatomic,retain)Author *author;
@end

@implementation SeconApadViewController

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
    
    NSLog(@"11111000%@",self.ID);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/%@/annotations",self.ID]];
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self]autorelease];
    NSLog(@"%@",connection);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
    
    
    
}


//-(float)jss
//{
//    for(Author *author in self.authors)
//    {
//        
//        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 50.0, 320.0, 60.0)];
//        label3.text = author.authorString;
//        
//       return label3.frame.size.height;
//        
//    }
//    
//     
//    
//}
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
    
    NSMutableArray *authors = [NSMutableArray array];
    NSArray *MovieList4 = [_xmlDic3 objectForKey:@"annotations"];
    //NSLog(@"%@",MovieList4);
    for(NSDictionary *_dic4 in MovieList4)
    {
        Author *author = [[[Author alloc]init]autorelease];
//        author.authorName =  [_dic4 objectForKey:@"title"];
        author.authorString = [_dic4 objectForKey:@"abstract"];
//        author.authorId = [_dic4 objectForKey:@"id"];
        NSData *thumbnailData4 = [NSData dataWithContentsOfURL:[NSURL URLWithString:author.authorString]];
        author.authorImage = [UIImage imageWithData:thumbnailData4];
        
        
        NSLog(@"%@",author.authorString);
        self.authors = authors;
        
        [self.authors addObject:author];
    
    
    
    }
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source
-(CGFloat)returnHeightForText:(NSString *)text

{
    UILabel *label=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    label.numberOfLines=0;
    label.text=text;
    [label sizeToFit];
    return label.frame.size.height*1.2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    Author *author = [self.authors objectAtIndex:indexPath.row];
    return [self returnHeightForText:author.authorString];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"笔记:";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.authors count];
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
      
    Author *author = [self.authors objectAtIndex:indexPath.row];
    
    //NSString *str = @"";
           NSString *str = @"笔记内容:";
        str = [str stringByAppendingFormat:@"%@",author.authorString];
         cell.textLabel.text = str;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    
    //str = [str stringByAppendingFormat:@"%@",author.authorString];
   
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    
    
    return cell;
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
