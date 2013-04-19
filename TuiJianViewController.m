//
//  TuiJianViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-16.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

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

@end

@implementation TuiJianViewController

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
    
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
    [self.view addSubview:headerview];
    
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 420)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
     tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 400)];
    
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
    
    
    

    
    
    NSURL *url3 = [NSURL URLWithString:@"https://api.douban.com/v2/movie/top250?apikey=0dea1ee3719c992829be5caa54d5cb78"];
    NSURLRequest *request3 = [[NSURLRequest alloc]initWithURL:url3 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request3 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"movie";
    // 开始异步请求
    [connection start];
    
    
    
    
    
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadAndRefreshForMovie:) object:movie];
//        [thread start];
//        [thread release];
//
        
        

    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboards)];
    recognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];

    
    
   

    

}

//-(void)loadAndRefreshForMovie:(Movie *)movie
//{
//    [self loadImageForMovie:movie];
//    
//    [self performSelectorOnMainThread:@selector(refreshTableViewCellForMovie:) withObject:movie waitUntilDone:NO];
//}
//-(void)loadImageForMovie:(Movie *)movie
//{
//    if (!movie.thumbnail)
//    {
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.thumbnailURLString]];
//        movie.thumbnail = [UIImage imageWithData:imageData];
//        NSLog(@"loaded image for %@", movie.movieName);
//    }
//}
//
//
//-(void)refreshTableViewCellForMovie:(Movie *)movie
//{
//    if (movie.thumbnail)
//    {
//        
//        for (NSIndexPath *indexPath in tableV.indexPathsForVisibleRows)
//        {
//            int rowNumber = indexPath.row;
//            Movie *movieInArray = [self.movies objectAtIndex:rowNumber];
//            if (movieInArray == movie)
//            {
//                
//                [tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }
//        }
//    }
//}




//-(void)tianjianmessage
//{
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"相关列表" style:UIBarButtonItemStyleDone target:self action:@selector(jianmessage)];
//    self.navigationItem.rightBarButtonItem = saveButton;
//    [saveButton release];
//}


-(void)hideKeyboards
{
    [self.searchBar resignFirstResponder];
    
}


//-(void)juhuaddd
//{
//    juhua = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 150, 40, 40)];
//    juhua.color = [UIColor blackColor];
//    [tableV2 addSubview:juhua];
//    
//    
//}

//-(void)juhuadd2
//{
//    
//    juhua2 = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150.0, 150.0, 50.0, 50.0)];
//    juhua2.color = [UIColor blackColor];
//    [tableV3 addSubview:juhua2];
//}



-(void)searchbar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 40.0, 320.0, 44.0)];
    
    self.searchBar = searchBar;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar release];
    

    
    
}



-(void)loadtupian
{
    
//    UIView *imageview = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0,320, 400.0)];
//    [tableV2 addSubview:imageview];
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0,400.0 )];
//    //label.backgroundColor = [UIColor blackColor];
//    label.text = @"请搜素想要的图书";
//    label.textColor = [UIColor blueColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.label = label;
//    [imageview addSubview:label];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     
{
//       [juhua startAnimating];
//    [juhua2 startAnimating];
//    NSLog(@"%@",searchBar.text);
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
     searchTxt = [searchTxt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/search?q=%@",searchTxt]]];
    
    
    NSURL *url4 = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/search?q=%@",searchTxt]];
   NSURLRequest *request5 = [[NSURLRequest alloc]initWithURL:url4 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request5 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"music";
    // 开始异步请求
    [connection start];

    
    
    

}



- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    self.scaledImage = scaledImage;
    UIGraphicsEndImageContext();
    
    return self.scaledImage;
    
    
}






-(void)souSuo:(NSString *)searchText
{
   
    
    searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@",searchText]];
    NSURLRequest *request2 = [[NSURLRequest alloc]initWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    CustomURLConnection *connection = [[[CustomURLConnection alloc]initWithRequest:request2 delegate:self startImmediately:NO]autorelease];
    // 连接的名字是活动
    connection.name = @"book";
    // 开始异步请求
    [connection start];
    
    
    
}
- (void)getData
{
    
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/onlines?apikey=0dea1ee3719c992829be5caa54d5cb78"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
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
//    if ([connection isMemberOfClass:[CustomURLConnection class]])
//    {
//        NSLog(@"%@", ((CustomURLConnection *)connection).name);
//    }
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"huodong"] )
    {
    
    

    NSString * xml1 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic1 = [xml1 JSONValue];
    
        //NSLog(@"！！！！！++++%@",_xmlDic1);
    
    
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
    }

    [tableV1 reloadData];
    
    [responseString release];
    [xml1 release];
    
    }
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"book"] )
    {
        NSString * xml3 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
        NSDictionary *_xmlDic3 = [xml3 JSONValue];
       // NSLog(@"adsasdas%@",responseString3);
        NSLog(@"%@",_xmlDic3);
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
            NSLog(@"++++%@",book.bookTitle);
            
            self.books = books;
            
            [self.books addObject:book];
        }

        [tableV2 reloadData];
             [juhua stopAnimating];
        [xml3 release];
 
    }
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"movie"] )
    {
        NSString * xml = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
        NSDictionary *_xmlDic = [xml JSONValue];
       // NSLog(@"dlkgjlsdjglsjdlgkj%@",_xmlDic);
        
        
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
        }
        
        [tableV reloadData];
        
        [xml release];
            
    }
    
    if([((CustomURLConnection*)connection).name isEqualToString:@"music"] )
    {
        
        
        NSString * xml4 = [[NSString alloc]initWithData:self.responseData1 encoding:NSUTF8StringEncoding];
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
            //        NSLog(@"%@",[_dic4 objectForKey:@"image"]);
            //
            //        [NSThread detachNewThreadSelector:@selector(loadAndRefreshForAuthor:) toTarget:self withObject:author];
            
            
            self.authors = authors;
            
            [self.authors addObject:author];
            
            
            [self scaleToSize:author.authorImage size:CGSizeMake(100.0, 100.0)];
            
            
        }
//        [juhua2 stopAnimating];
        [tableV3 reloadData];

        
    }
    
    
    
    
}

-(void)_loadData:(UISegmentedControl*)yy
{
    
    NSInteger index = yy.selectedSegmentIndex ;
    if (index == 3) {
        [tableV removeFromSuperview];
        [tableV2 removeFromSuperview];
        [tableV3 removeFromSuperview];
        [self.view addSubview:tableV1];
        self.navigationItem.title = @"活动";
        
        
        [self getData];
        
        
    }
    if (index == 0) {
        [tableV1 removeFromSuperview];
        [tableV2 removeFromSuperview];
        [tableV3 removeFromSuperview];
        self.navigationItem.title= @"电影";
        //[self.headerview removeFromSuperview];
//        [self tianjianmessage];
        [self.view addSubview:tableV];
        
        
    }
    
    if(index == 1)
    {
        [tableV1 removeFromSuperview];
        [tableV removeFromSuperview];
        [tableV3 removeFromSuperview];
        self.navigationItem.title =@"图书";
        [self searchbar];
        [self.view addSubview:tableV2];
        [self loadtupian];
        
        
    }
    if(index == 2)
    {
        [tableV1 removeFromSuperview];
        [tableV removeFromSuperview];
        [tableV2 removeFromSuperview];
        self.navigationItem.title= @"音乐";
        [self searchbar];
        [self.view addSubview:tableV3];
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
    
    if(tableView.tag == 1)
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
        if(self.scaledImage)
        {
            cell.imageV.image = self.scaledImage;
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
    first.kamovie = [self.movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:first animated:YES];
    
    
    [first release];
    }
    
    if(self.segmentControl.selectedSegmentIndex == 1)
    {
        
        SecondViewController *second = [[SecondViewController alloc]init];
        Book *book = [self.books objectAtIndex:indexPath.row];
        second.Name = book.bookTitle;
        second.ID = book.bookID;
        second.bookImage = book.bookImage;
        second.mmbook = [self.books objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:second animated:YES];
        
        
        
    }
    
    
    if(self.segmentControl.selectedSegmentIndex==3)
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
    
    
    
    
    
    
    
    
}

@end
