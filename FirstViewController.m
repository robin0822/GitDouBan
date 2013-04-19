//
//  FirstViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-18.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON.h"
#import "Book.h"
#import "FirstaddlistViewController.h"

@interface FirstViewController ()
@property (nonatomic, retain) NSMutableData *responseData;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UILabel *namelabel;
@property(nonatomic,retain)UILabel *daolabel;
@property(nonatomic,retain) UILabel *restlabel;
@property(nonatomic,retain)UIScrollView *scrollView;
@end

@implementation FirstViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = self.movieID;
    
    //    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",str]]];
    //   // NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:NULL error:NULL];
    //     NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request1 delegate:self];
    //     NSString *responseString1= [[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",responseString1);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self]autorelease];
    NSLog(@"%@",connection);
    //    NSString * xml1 = [[NSString alloc]initWithData:responseData1 encoding:NSUTF8StringEncoding];
    //    NSDictionary *_xmlDic1 = [xml1 JSONValue];
    //    NSLog(@"%@",_xmlDic1);
    self.navigationItem.title = self.movieName;
    
    
    
    
    
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320, 180.0)];
    //    [tableV addSubview:view];
    
    
//    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 100, 100)];
//    //[self.view addSubview:imageview];
//    imageview.image =self.movieimage;
//    [self.view addSubview:imageview];
//    [imageview release];
//    
//    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(120.0, 10.0, 95.0, 30.0)];
//    titlelabel.text = @"电影名称:";
//    titlelabel.font = [UIFont boldSystemFontOfSize:15];
//    [self.view addSubview:titlelabel];
//    [titlelabel release];
//    
//    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0, 10.0, 110.0, 28.0)];
//    namelabel.numberOfLines=1;
//    namelabel.font = [UIFont systemFontOfSize:18];
//    namelabel.text = self.movieName;
//    self.namelabel = namelabel;
//    [self.view addSubview:namelabel];
//    [namelabel release];
//    
//    UILabel *daoyanlabel = [[UILabel alloc]initWithFrame:CGRectMake(120.0, 40.0, 50.0, 30.0)];
//    daoyanlabel.text = @"导演:";
//    daoyanlabel.font = [UIFont boldSystemFontOfSize:15];
//    [self.view addSubview:daoyanlabel];
//    
//    
//    UILabel *daolabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0, 40.0, 110.0, 60.0)];
//    daolabel.numberOfLines = 2;
//    daolabel.font = [UIFont systemFontOfSize:18.0];
//    daolabel.text = @"";
//    self.daolabel = daolabel;
//    [self.view addSubview:daolabel];
//    [daolabel release];
//    
//    
//    UILabel *xianshilabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 150.0, 200.0,40.0 )];
//    xianshilabel.text = @"电影简介:";
//    xianshilabel.font = [UIFont boldSystemFontOfSize:18];
//    [self.view addSubview:xianshilabel];
//    [xianshilabel release];
//    
    
//
//    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 180.0, 320.0, 280.0)];
//    //scrollView.pagingEnabled = YES;
//    scrollView.delegate = self;
//    scrollView.contentSize = CGSizeMake(320.0, 300.0);
//    self.scrollView=scrollView;
//    [self.view addSubview:scrollView];
//    [scrollView release];
//    
//    
//
       UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0,-100.0 , 50.0, 40.0)];
    
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor orangeColor];
        label.text =@"";
        label.numberOfLines=0;
        self.label = label;
    [self.tableView addSubview:label];

    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
//    label.textAlignment = NSTextAlignmentCenter;
//    //label.backgroundColor = [UIColor grayColor];
//    //label.font = [UIFont systemFontOfSize:15.0];
//    label.textColor = [UIColor orangeColor];
//    label.text =@"";
//    label.numberOfLines=0;
//    self.label = label;
//    
//    [self.scrollView addSubview:label];
//    //[label sizeToFit];
//    [label release];
//    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(170.0, 120.0, 100.0, 30.0);
//    [button setTitle:@"相 关 作 品" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(tianjianmessage) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"相关列表" style:UIBarButtonItemStyleDone target:self action:@selector(tianjianmessage)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    UILabel *restlabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, -500.0, 320, 450.0)];
    restlabel.font = [UIFont systemFontOfSize:15.0];
    restlabel.text = @"";
    self.restlabel = restlabel;
    [self.tableView addSubview:restlabel];
    

    
    
    
    
}


//-(void)resefd
//{
//    
//    UILabel *restlabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, -500.0, 320, 450.0)];
//    restlabel.font = [UIFont systemFontOfSize:15.0];
//    restlabel.text = @"";
//    self.restlabel = restlabel;
//    [self.tableView addSubview:restlabel];
//    
//    
//    
//    NSLog(@"++++++!!!!!%@",restlabel.text);
//    
//}

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
        
        cell.textLabel.text = self.movieName;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = self.movieimage;
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
        cell.textLabel.text = self.label.text;
        
        
    
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
        
             
        //cell.detailTextLabel.text = self.restlabel.text;
        
        
                
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    //[self.tableView reloadData];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"电影";
    }
    else if (section == 1)
    {
        return @"导演";
    }
    else
    {
        return @"电影简介";
    }
}




-(void)tianjianmessage
{
    
    FirstaddlistViewController *fristlist = [[FirstaddlistViewController alloc]initWithStyle:UITableViewStylePlain];
    
    
    UINavigationController *navigation1 = [[UINavigationController alloc]initWithRootViewController:fristlist];
    navigation1.navigationBar.tintColor = [UIColor grayColor];
    fristlist.ID = self.movieID;
    fristlist.Name =self.label.text;
    
    //[self presentModalViewController:navigation1 animated:YES];
    
    NSLog(@"%@",fristlist.Name);
    
    
    [self presentViewController:navigation1 animated:YES completion:nil];
    [fristlist release];
    [navigation1 release];
    
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
    
    
    NSString * xml1 = [[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic1 = [xml1 JSONValue];
    NSLog(@"%@",_xmlDic1);
    
    
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSString* esc1 = [responseString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);
    
    
    
    
    NSMutableArray *books = [NSMutableArray array];
    NSArray *MovieList3 = [_xmlDic1 objectForKey:@"directors"];
    
    for(NSDictionary *_dic3 in MovieList3)
    {
        Book *book = [[[Book alloc]init]autorelease];
        book.bookTitle =  [_dic3 objectForKey:@"name"];
        book.bookString = [[_dic3 objectForKey:@"avatars"]objectForKey:@"small"];
        book.bookDescription = [_xmlDic1 objectForKey:@"summary"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
        NSLog(@"++++%@",book.bookTitle);
        NSLog(@"fuck%@",book.bookDescription);
        NSLog(@"%@",book.bookDescription);
        self.books = books;
        self.restlabel.text= book.bookDescription;
        NSLog(@"hkjwhfkjwafhwajkfhwajkfgfjgfjk%@",self.restlabel.text);
        //self.namelabel.text = book.bookTitle;
        self.daolabel.text = book.bookTitle;
        self.label.text = book.bookTitle;
        
        
        [self.books addObject:book];
        [self.tableView reloadData];
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
        return 500.0;
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
