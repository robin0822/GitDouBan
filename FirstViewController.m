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
#import "SeconAddViewController.h"
#import "SecondMovieViewController.h"

#import "Student.h"

@interface FirstViewController ()
{
    UIProgressView* progressView_;
}


-(CGFloat)hanggao;


@property (nonatomic, retain) NSMutableData *responseData;
@property(nonatomic,retain)Book *book;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UILabel *namelabel;
@property(nonatomic,retain)UILabel *daolabel;
@property(nonatomic,retain) UILabel *restlabel;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)Student *student;
@property(nonatomic,retain) NSMutableArray *students;
@end

@implementation FirstViewController

-(CGFloat)hanggao
{
   
    
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)] autorelease];
    label1.textAlignment = NSTextAlignmentCenter;
   
    label1.font = [UIFont systemFontOfSize:15.0];
    //label1.textColor = [UIColor orangeColor];
    label1.text = self.restlabel.text;
    label1.numberOfLines=0;
    [label1 sizeToFit];
    
    return  label1.frame.size.height+30;
    
}


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
    //self.navigationItem.backBarButtonItem.title = self.movieName;
    
    NSString *str = self.movieID;
    
//    //    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",str]]];
//    //   // NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:NULL error:NULL];
//    //     NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request1 delegate:self];
//    //     NSString *responseString1= [[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding];
//    //    NSLog(@"%@",responseString1);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@?apikey=0dea1ee3719c992829be5caa54d5cb78",str]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self]autorelease];
    NSLog(@"%@",connection);
    //    NSString * xml1 = [[NSString alloc]initWithData:responseData1 encoding:NSUTF8StringEncoding];
//    //    NSDictionary *_xmlDic1 = [xml1 JSONValue];
//    //    NSLog(@"%@",_xmlDic1);
//    self.navigationItem.title = self.movieName;
    
    
    
    
           UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0,-100.0 , 50.0, 40.0)];
    
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor orangeColor];
        label.text =@"";
        label.numberOfLines=0;
        self.label = label;
    [self.tableView addSubview:label];
    [label release];
    

    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"相关列表" style:UIBarButtonItemStyleDone target:self action:@selector(tianjianmessage)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    UILabel *restlabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, -500.0, 320, 450.0)];
    restlabel.font = [UIFont systemFontOfSize:15.0];
    restlabel.text = @"";
    self.restlabel = restlabel;
    [self.tableView addSubview:restlabel];
    [restlabel release];
    
    
    
//    NSString *urlString = @"https://api.douban.com/v2/user/~me";
//    NSString *appkey = @"Bearer 8dd3053775ee31fda9790fa661ca95f7";
//    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [request2 setValue:appkey forHTTPHeaderField:@"Authorization"];
//    NSData *responseData2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:NULL error:NULL];
//    
//    
//    NSString * xml2 = [[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
//    NSDictionary *_xmlDic2 = [xml2 JSONValue];
//    NSLog(@"%@",_xmlDic2);
    
       NSString *appkey = @"Bearer c27b84887ad3381547728d997079a83f";
    NSURL *url3 = [NSURL URLWithString:@"https://api.douban.com/v2/book/1442720/annotations"];
    NSMutableURLRequest *request3 = [[NSMutableURLRequest alloc]initWithURL:url3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request3 setHTTPMethod:@"POST"];
     [request3 setValue:appkey forHTTPHeaderField:@"Authorization"];
//    
    //NSString *resttitle = @"这本书写的我热血沸腾啊，感觉自己身在其中啊。";
//    NSString *restdesc = @"开展各种体育活动健身";
//    NSString *ssda = @" ";
   //resttitle = [resttitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"%@",resttitle);
//restdesc = [restdesc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@",restdesc);
    NSString *str2 = @"content=%E8%BF%99%E6%9C%AC%E4%B9%A6%E5%86%99%E7%9A%84%E6%88%91%E7%83%AD%E8%A1%80%E6%B2%B8%E8%85%BE%E5%95%8A%EF%BC%8C%E6%84%9F%E8%A7%89%E8%87%AA%E5%B7%B1%E8%BA%AB%E5%9C%A8%E5%85%B6%E4%B8%AD%E5%95%8A%E3%80%82&page=110";
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    [request3 setHTTPBody:data];
    
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request3 returningResponse:nil error:nil];
    
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //[str1 release];
    NSLog(@"1111%@",str1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        cell.textLabel.text = self.movieName;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = self.movieimage;

        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(220.0, 35.0, 40.0, 30.0);
        [button setTitle:@"收藏" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.label.text;
        
    
    }
    else if(indexPath.section==2)
    {
        // 标题
        static NSString *identifier = @"MessageContentCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        
        
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.backgroundColor = [UIColor clearColor];
            label1.font = [UIFont systemFontOfSize:15.0];
            
        label1.text =self.restlabel.text;
            label1.numberOfLines=0;
        [label1 sizeToFit];
        [cell.contentView addSubview:label1];
        [label1 release];
             
               
        
                
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   
    
    else 
    {
        static NSString *identifier = @"MeageContentCell";
        
        // 重用
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        

        cell.textLabel.text = @"电影评价";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
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
    else if(section == 2)
    {
        return @"电影简介";
    }
    else
    {
        return @"";
    }
}


//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(section == 1)
//    {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(260.0, 5.0, 50.0, 30.0);
//        [button setTitle:@"收藏" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor clearColor];
//        [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//        return view;
//        
//        
//    }
//    else
//    {
//        return nil;
//    }
//    
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section ==1)
//    {
//        return 40.0;
//    }
//    
//   else
//   {
//       return  [super tableView:tableView heightForHeaderInSection:section];
//   }
//}


-(void)add
{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"选择了菜单中的操作"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
    
//    progressView_ = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
//    progressView_.frame = CGRectMake(30, 80, 225, 30);
//    [alert addSubview:progressView_];
    
    [alert show];        
    [alert release];
    
   
    
    
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    if(section==1)
//    {
//        
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 60.0)];
//        
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5.0, 5.0, 80.0, 35.0)];
//        [button setTitle:@"影评信息" forState:UIControlStateNormal];
//        [button setTintColor:[UIColor blackColor]];
//        
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [view addSubview:button];
//        return view;
//        
//        
//    }
//    else
//    {
//        return  nil;
//    }
//    
//}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==1)
    {
        
        UIAlertView *alert2 = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"选择了菜单中的操作"
                              delegate:self
                              cancelButtonTitle:@"收藏成功"
                              otherButtonTitles:nil];
        
        [alert2 show];
        [alert2 release];
        
        Student *student = [[Student alloc]init];
        student.bookName = self.movieName;
        student.bookString = self.movieString;
        student.bookID = self.movieID;
        NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSData *studentData = [NSData dataWithContentsOfFile:[filepath stringByAppendingPathComponent:@"students.bmbbchive"]];
        NSMutableArray *students = [NSKeyedUnarchiver unarchiveObjectWithData:studentData];
        if(students)
        {
            self.students = students;
        }
        else
        {
            self.students = [NSMutableArray array];
        }
        
        
        [self.students addObject:student];
        
        
        
        
        
        [student release];
        //归档
        NSData *studentData1 = [NSKeyedArchiver archivedDataWithRootObject:self.students];
        NSString *filepath1 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        [studentData1 writeToFile:[filepath1 stringByAppendingPathComponent:@"students.bmbbchive"] atomically:YES];
        
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
   // NSLog(@"111111111%@",_xmlDic1);
    
    
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
        book.bookID = [_dic3 objectForKey:@"id"];
        book.bookString = [[_dic3 objectForKey:@"avatars"]objectForKey:@"small"];
        book.bookDescription = [_xmlDic1 objectForKey:@"summary"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
        book.bookImage = [UIImage imageWithData:thumbnailData1];
        //NSLog(@"++++%@",book.bookTitle);
        //NSLog(@"fuck%@",book.bookDescription);
        //NSLog(@"%@",book.bookDescription);
        self.books = books;
        self.restlabel.text= book.bookDescription;
       // NSLog(@"hkjwhfkjwafhwajkfhwajkfgfjgfjk%@",self.restlabel.text);
        //self.namelabel.text = book.bookTitle;
        self.daolabel.text = book.bookTitle;
        self.label.text = book.bookTitle;
        
        
       // NSLog(@"5553333%@",book.bookID);
        
        
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
    else if(indexPath.section==2)
    {
        
//        Book *book = [self.books objectAtIndex:indexPath.row];
//    
//        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 10.0, 280.0, 400.0)];
//        label1.textAlignment = NSTextAlignmentCenter;
//        label1.backgroundColor = [UIColor clearColor];
//        label1.font = [UIFont systemFontOfSize:15.0];
//        //label1.textColor = [UIColor orangeColor];
//        label1.text =book.bookDescription;
//        label1.numberOfLines=0;
//        [label1 sizeToFit];
        
//        return  label1.frame.size.height+30;
        return [self hanggao];
        
    }
    else{
        return 50.0;
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
   if(indexPath.section==1&indexPath.row==0)
{
    
    
    SeconAddViewController *secondadd= [[SeconAddViewController alloc]initWithStyle:UITableViewStyleGrouped];
    Book *book = [self.books objectAtIndex:indexPath.row];
    secondadd.ID= book.bookID;
    secondadd.Name = book.bookTitle;
    NSLog(@"%@",book.bookID);
    
    [self.navigationController pushViewController:secondadd animated:YES];
    [secondadd release];
    
    
}
    if(indexPath.section==3&indexPath.row==0)
    {
        
        SecondMovieViewController *secondMovie = [[SecondMovieViewController alloc]initWithStyle:UITableViewStylePlain];
        Book *book = [self.books objectAtIndex:indexPath.row];
        secondMovie.ID = self.movieID;
        secondMovie.Name = book.bookTitle;
        [self.navigationController pushViewController:secondMovie animated:YES];
        [secondMovie release];
        
        
    }
//if(indexPath.section==0&indexPath.row==0)
//{
//    
//    SouSuoViewController *sousuo = [[SouSuoViewController alloc]init];
//    sousuo.movieName = self.movieName;
//    sousuo.movieImage = self.movieimage;
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"提示"
//                          message:@"选择了菜单中的操作"
//                          delegate:self
//                          cancelButtonTitle:@"确定"
//                          otherButtonTitles:@"取消",nil];
//    //[alert addButtonWithTitle:@"新增加项"];
//    [alert show];
//    [alert release];
//    
//    [self.navigationController pushViewController:sousuo animated:YES];
//    
//    
//    
//
//    
//    
//    
//}

    
    
    
}

@end
