//
//  TuiJianViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-16.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//
#import "Student.h"
#import "TuiJianViewController.h"
#import "JSON.h"
#import "Movie.h"
#import "OnLine.h"
#import "Book.h"
#import "Author.h"
#import "FirstViewController.h"
#import "CustomURLConnection.h"
#import "SecondViewController.h"
#import "QyhCell.h"
#import "ActionViewController.h"
#import "MusicViewController.h"
#import "MusicViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TuiJianViewController ()
{
     NSArray                       * _segmentedControlArray;
    UITableView * tableV;
    UITableView * tableV1;
    UITableView * tableV2;
    UITableView * tableV3;
    
    UIActivityIndicatorView *juhua2;
    //菊花
    UIActivityIndicatorView * juhua;

}
@property(nonatomic,retain)Movie *movie;
@property(nonatomic,retain)NSMutableArray *movies;
@property(nonatomic,retain)OnLine *online;
@property(nonatomic,retain)NSMutableArray *onlines;
@property(nonatomic,retain)UISearchBar *searchBar;
@property(nonatomic,retain)Book*book;
@property(nonatomic,retain)NSMutableArray *books;
@property(nonatomic,retain) UIView *headerview;
@property(nonatomic,retain)UISegmentedControl *segmentControl;
@property(nonatomic,retain)NSMutableArray *authors;
@property(nonatomic,retain)Author *author;
@property(nonatomic,retain)NSMutableData *responseData1;
@property(nonatomic,retain)NSMutableData *responseData2;
@property(nonatomic,retain) UIImage* scaledImage;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UISearchDisplayController *search;
@property (nonatomic, retain) NSMutableArray *searchResults;
@property(nonatomic,retain)UIImageView *imgView2;
@property(nonatomic,retain)UIImageView *imgView3;




@property (nonatomic, retain) NSMutableArray *students;
@end

@implementation TuiJianViewController
static NSString * const kAPIKey = @"04e0b2ab7ca02a8a0ea2180275e07f9e";
static NSString * const kPrivateKey = @"4275ee2fa3689a2f";
static NSString * const kRedirectUrl = @"http://www.douban.com/location/mobile";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc
{
    [_movie release];
    [_movies release];
    [_online release];
    [_onlines release];
    [super dealloc];
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    self.students = [NSMutableArray array];
    
       //创建4个TableView
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 420)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
     tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 420)];
    
    tableV1.tag = 2;
    tableV1.delegate = self;
    tableV1.dataSource = self;
    
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 80.0, 320.0, 400)];
    tableV2.tag = 3;
    tableV2.delegate = self;
    tableV2.dataSource = self;
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 80.0, 320.0, 400)];
    tableV3.tag = 4;
    tableV3.delegate = self;
    tableV3.dataSource = self;
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(eat)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];

   //创建试图分区；
    
    _segmentedControlArray = [NSArray arrayWithObjects:@"电影",@"图书",@"音乐",@"活动", nil];
    //创建分区视图
    UISegmentedControl * _segmentedControl = [[UISegmentedControl alloc]initWithItems:_segmentedControlArray];
    _segmentedControl.momentary  = NO;
    _segmentedControl.segmentedControlStyle = UISegmentedControlNoSegment;
    _segmentedControl.frame = CGRectMake(0, 0, 320, 40);
    _segmentedControl.tintColor = [UIColor grayColor];
    [_segmentedControl addTarget:self action:@selector(_loadData:) forControlEvents:UIControlEventValueChanged];
    
    
    _segmentedControl.selectedSegmentIndex=0;
    self.segmentControl=_segmentedControl;
    [self.view addSubview:_segmentedControl];
    
    //[NSThread detachNewThreadSelector:@selector(didsegmentcontrol) toTarget:self withObject:nil];
    

    
    
    NSURL *url3 = [NSURL URLWithString:@"https://api.douban.com/v2/movie/top250?start-index=1&max-results=20&apikey=0dea1ee3719c992829be5caa54d5cb78"];
    NSURLRequest *request3 = [[[NSURLRequest alloc]initWithURL:url3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request3 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"movie";
    // 开始异步请求
    [connection start];
    
    
    
    
   
   

    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}




-(void)stopimage
{
    
    [self.imgView removeFromSuperview];
    
}



-(void)eat
{
    NSString *str = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code", kAPIKey, kRedirectUrl];
    
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    UIViewController *webViewController = [[WebViewController alloc] initWithRequestURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController release];
    
}





-(void)hideKeyboards
{
    [self.searchBar resignFirstResponder];
    
}





-(void)searchbar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 40.0, 320.0, 44.0)];
    
    self.searchBar = searchBar;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar release];
    
    

    
    
}




- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;
{
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text=@"";
    [self.books removeAllObjects];
    [searchBar resignFirstResponder];
    [tableV2 reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     
{
   
    
    [self.imgView2 removeFromSuperview];
    [self.imgView3 removeFromSuperview];
    if (self.segmentControl.selectedSegmentIndex==1) {
        [self souSuo:searchBar.text];
       
        
    }
    if (self.segmentControl.selectedSegmentIndex==2) {
        [self yinYu:searchBar.text];
        
    }
    
    
    
    
    
     [self hideKeyboards];
    
}




-(void)yinYu:(NSString*)searchTxt
{
    
     NSLog(@"%@",searchTxt);
    


    searchTxt = [searchTxt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url4 = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/search?q=%@&apikey=0dea1ee3719c992829be5caa54d5cb78",searchTxt]];
    NSURLRequest *request5 = [[[NSURLRequest alloc]initWithURL:url4 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request5 delegate:self startImmediately:NO]autorelease];
    
    connection.name = @"music";
   
    [connection start];
 
    
    

}








-(void)souSuo:(NSString *)searchText
{
   
    NSLog(@"%@",searchText);
    
    
    
    searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&apikey=0dea1ee3719c992829be5caa54d5cb78",searchText]];
    NSURLRequest *request2 = [[[NSURLRequest alloc]initWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request2 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"book";
    // 开始异步请求
    [connection start];

    
    
    
}
- (void)getData
{
    
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/onlines?apikey=0dea1ee3719c992829be5caa54d5cb78"];
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"huodong";
    // 开始异步请求
    [connection start];
    //NSLog(@"%@",connection);
    
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
    
    [NSThread detachNewThreadSelector:@selector(loadAndRefresh:) toTarget:self withObject:connection];
    
   
   
    
    
}



-(void)loadAndRefresh:(NSURLConnection *)connection
{
    
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"movie"] )
    {
        NSString * xml = [[[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding]autorelease];
        NSDictionary *_xmlDic = [xml JSONValue];
         //NSLog(@"dlkgjlsdjglsjdlgkj%@",_xmlDic);
        
        
        NSMutableArray *movies = [NSMutableArray array];
        NSArray *  MovieList  =   [_xmlDic objectForKey:@"subjects"];
        for(NSDictionary *_dic in MovieList)
        {
            Movie *movie = [[[Movie alloc]init]autorelease];
            movie.movieName =  [_dic objectForKey:@"title"];
            movie.movieID = [_dic objectForKey:@"id"];
            movie.thumbnailURLString = [[_dic objectForKey:@"images"]objectForKey:@"small"];
            NSData *thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.thumbnailURLString]];
            movie.thumbnail = [UIImage imageWithData:thumbnailData];
            
            
            
            self.movies = movies;
            
            [self.movies addObject:movie];
            
            [self performSelectorOnMainThread:@selector(refreshTableViewCellForMovie) withObject:movie waitUntilDone:NO];
             
        }
        
         
    
        
        //[xml release];
        
    }
    
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"huodong"] )
    {
        
        
        
        NSString * xml1 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
        NSDictionary *_xmlDic1 = [xml1 JSONValue];
        
        NSLog(@"！！！！！++++%@",_xmlDic1);
        
        
        NSString *responseString = [[NSString alloc] initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
        NSString* esc1 = [responseString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
        NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
        NSString* unesc = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
        assert([unesc isKindOfClass:[NSString class]]);
        
        NSMutableArray *onlines = [NSMutableArray array];
        NSArray *  MovieList2  =   [_xmlDic1 objectForKey:@"onlines"];
        for(NSDictionary *_dic1 in MovieList2)
        {
            OnLine *online = [[[OnLine alloc]init]autorelease];
            online.onlineTitle =  [_dic1 objectForKey:@"title"];
            online.onlineString = [_dic1 objectForKey:@"thumb"];
            online.onlineId = [_dic1 objectForKey:@"id"];
            NSData *thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:online.onlineString]];
            online.onlineImage = [UIImage imageWithData:thumbnailData];
            
            NSLog(@"!!!!####%@",online.onlineId);
            
            self.onlines = onlines;
            
            [self.onlines addObject:online];
            [self performSelectorOnMainThread:@selector(refreshTableViewCellForonline) withObject:online waitUntilDone:NO];
        }
        
       
        
        [responseString release];
        [xml1 release];
        
    }
    if([((CustomURLConnection*)connection).name isEqualToString:@"book"] )
    {
        NSString * xml3 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
        NSDictionary *_xmlDic3 = [xml3 JSONValue];
        //NSLog(@"%@",_xmlDic3);
        NSMutableArray *books = [NSMutableArray array];
        NSArray *MovieList3 = [_xmlDic3 objectForKey:@"books"];
        
        for(NSDictionary *_dic3 in MovieList3)
        {
            Book *book = [[[Book alloc]init]autorelease];
            book.bookTitle =  [_dic3 objectForKey:@"title"];
            book.bookID = [_dic3 objectForKey:@"id"];
            book.bookString = [[_dic3 objectForKey:@"images"]objectForKey:@"small"];
            NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
            book.bookImage = [UIImage imageWithData:thumbnailData1];
            //NSLog(@"++++%@",book.bookID);
            
            self.books = books;
            
            [self.books addObject:book];
            [self performSelectorOnMainThread:@selector(refreshTableViewCellForbook) withObject:book waitUntilDone:NO];
        }
        
        //[juhua stopAnimating];
        [xml3 release];
        
    }
    
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"music"] )
    {
        
        
        NSString * xml4 = [[[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding]autorelease];
        NSDictionary *_xmlDic4 = [xml4 JSONValue];
        
        //    NSLog(@"%@",_xmlDic4);
        NSMutableArray *authors = [NSMutableArray array];
        NSArray *MovieList4 = [_xmlDic4 objectForKey:@"musics"];
        NSLog(@"%@",MovieList4);
        for(NSDictionary *_dic4 in MovieList4)
        {
            Author *author = [[[Author alloc]init]autorelease];
            author.authorName =  [_dic4 objectForKey:@"title"];
            author.authorString = [_dic4 objectForKey:@"image"];
            author.authorId = [_dic4 objectForKey:@"id"];
            NSData *thumbnailData4 = [NSData dataWithContentsOfURL:[NSURL URLWithString:author.authorString]];
            author.authorImage = [UIImage imageWithData:thumbnailData4];
            
            
            
            self.authors = authors;
            
            [self.authors addObject:author];
            
             [self performSelectorOnMainThread:@selector(refreshTableViewCellFormuisc) withObject:author waitUntilDone:NO];
            
        }
        
        
        
        
    }


    

    
}


-(void)refreshTableViewCellFormuisc
{
    [tableV3 reloadData];
    
}
-(void)refreshTableViewCellForbook
{
    [tableV2 reloadData];
    
}
-(void)refreshTableViewCellForonline
{
    
     [tableV1 reloadData];
    
}
-(void)refreshTableViewCellForMovie
{
    [tableV reloadData];
}


-(void)_loadData:(UISegmentedControl*)yy
{
    
    NSInteger index = yy.selectedSegmentIndex ;
    if (index == 3) {
        
        [tableV removeFromSuperview];
        [tableV2 removeFromSuperview];
        [tableV3 removeFromSuperview];
             [self.view addSubview:tableV1];
        self.navigationItem.title = @"本周活动";
        
        
        [self getData];
        
        
    }
    if (index == 0) {
     
      
        [tableV1 removeFromSuperview];
        [tableV2 removeFromSuperview];
        [tableV3 removeFromSuperview];
        
        self.navigationItem.title= @"TOP10电影";
//        [self tianjianmessage];
        [self.view addSubview:tableV];
        //[tableV reloadData];
               
        
    }
    
    if(index == 1)
    {
             self.navigationItem.title =@"搜索图书";
        [tableV removeFromSuperview];
        [tableV1 removeFromSuperview];
        
        [tableV3 removeFromSuperview];
        [self searchbar];
        [self.view addSubview:tableV2];
        
        UIImage *img2 = [UIImage imageNamed:@"book.jpg"];
        
        UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 80.0, 320.0, 420.0)];
        imgView2.image = img2;
        self.imgView2 = imgView2;
        [self.view addSubview:imgView2];
        [imgView2 release];
        
        
        //[self loadtupian];
        
        
    }
    if(index == 2)
    {
       
        self.navigationItem.title= @"搜索音乐";
        
        [tableV removeFromSuperview];
        [tableV1 removeFromSuperview];
        [tableV2 removeFromSuperview];
        [self searchbar];
        [self.view addSubview:tableV3];
        
        UIImage *img3 = [UIImage imageNamed:@"music.jpg"];
        
        UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 80.0, 320.0, 420.0)];
        imgView3.image = img3;
        self.imgView2 = imgView3;
        [self.view addSubview:imgView3];
        [imgView3 release];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView.tag == 1){
        return [self.movies count];
    }
    else if(tableView.tag == 2)
    {
        return [self.onlines count];
    }
    else if(tableView.tag == 3)
    {
        return [self.books count];
    }
    else
    {
        return [self.authors count];
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MovieCell";
    QyhCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[[QyhCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    else if(tableView.tag == 1)
    {
        Movie *movie = [self.movies objectAtIndex:indexPath.row];
        
        cell.nameLabel.text = movie.movieName;
        if (movie.thumbnail)
        {
            cell.imageV.image = movie.thumbnail;
        }

    }
    
    else if(tableView.tag == 2)
    {
        OnLine *online = [self.onlines objectAtIndex:indexPath.row];
        cell.nameLabel.text = online.onlineTitle;
        if(online.onlineImage)
        {
            cell.imageV.image = online.onlineImage;
        }
    }
    
     else if(tableView.tag ==3)
    {
        Book *book = [self.books objectAtIndex:indexPath.row];
        
        
        
        
        
        cell.nameLabel.text = book.bookTitle;
        if(book.bookImage)
        {
            cell.imageV.image = book.bookImage;
        }
        
    }
    else if(tableView.tag ==4)
    {
        Author *author = [self.authors objectAtIndex:indexPath.row];
        cell.nameLabel.text = author.authorName;
        if(author.authorImage)
        {
            cell.imageV.image =author.authorImage ;
        }
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 80.0;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.segmentControl.selectedSegmentIndex==0){
        
    FirstViewController *first = [[FirstViewController alloc]initWithStyle:UITableViewStyleGrouped];
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    first.movieID =movie.movieID;
    first.movieName = movie.movieName;
    first.movieimage = movie.thumbnail;
        first.movieString = movie.thumbnailURLString;

        
    first.kamovie = [self.movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:first animated:YES];
    
    
    [first release];
    }
    
    else if(self.segmentControl.selectedSegmentIndex == 1)
    {
        
        SecondViewController *second = [[SecondViewController alloc]init];
        Book *book = [self.books objectAtIndex:indexPath.row];
        second.Name = book.bookTitle;
        second.ID = book.bookID;
        second.bookString = book.bookString;
        second.bookImage = book.bookImage;
        second.mmbook = [self.books objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:second animated:YES];
        
        [second release];
        
    }
    
    
     else if(self.segmentControl.selectedSegmentIndex==3)
    {
        
        
        ActionViewController *action = [[ActionViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        OnLine*online = [self.onlines objectAtIndex:indexPath.row];
        
        action.Id = online.onlineId;
        action.Name = online.onlineTitle;
        action.Image = online.onlineImage;
        NSLog(@"%@",online.onlineId);
        [self.navigationController pushViewController:action animated:YES];
        [action release];
        
        
    }
    
    
    else if(self.segmentControl.selectedSegmentIndex==2)
   {
       MusicViewController *music = [[MusicViewController alloc]initWithStyle:UITableViewStylePlain];
       Author *authour = [self.authors objectAtIndex:indexPath.row];
       music.musicID = authour.authorId;
       music.musicName = authour.authorName;
       music.musicImage = authour.authorImage;
       NSLog(@"%@",music.musicID);
       [self.navigationController pushViewController:music animated:YES];
       [music release];
       
       
       
       
       
   }
    
    
    
    
    
}

@end
