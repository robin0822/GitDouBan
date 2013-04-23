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
    [restlabel release];
    
    
    
    
    
    
//    Student *student = [[Student alloc]init];
//    student.bookName = self.movieName;
//    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSData *studentData = [NSData dataWithContentsOfFile:[filepath stringByAppendingPathComponent:@"students.archive"]];
//    NSMutableArray *students = [NSKeyedUnarchiver unarchiveObjectWithData:studentData];
//    if(students)
//    {
//        self.students = students;
//    }
//    else
//    {
//        self.students = [NSMutableArray array];
//    }
//    
//    
//    [self.students addObject:student];
//    
//    
//    
//    
//    
//    [student release];
//    //归档
//    NSData *studentData1 = [NSKeyedArchiver archivedDataWithRootObject:self.students];
//    NSString *filepath1 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    [studentData1 writeToFile:[filepath1 stringByAppendingPathComponent:@"students.archive"] atomically:YES];

    
    
    
    
    
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
        static NSString *identifier1 = @"MessageTitleCell";
        
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
        
        NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSData *studentData = [NSData dataWithContentsOfFile:[filepath stringByAppendingPathComponent:@"students.bbchive"]];
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
        [studentData1 writeToFile:[filepath1 stringByAppendingPathComponent:@"students.bbchive"] atomically:YES];
        
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
    else
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
