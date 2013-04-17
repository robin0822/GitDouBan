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

@interface TuiJianViewController ()
{
     NSArray                       * _segmentedControlArray;
    UITableView * tableV;
    UITableView * tableV1;
    UITableView * tableV2;
    UITableView * tableV3;

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
    
    
    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
//
//    self.searchBar = searchBar;
//    searchBar.delegate = self;
//    [tableV2 addSubview:searchBar];
//    [searchBar release];
    //appKey=0dea1ee3719c992829be5caa54d5cb78
//    NSString * _appkey = @"0dea1ee3719c992829be5caa54d5cb78";
       NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/movie/top250?apikey=0dea1ee3719c992829be5caa54d5cb78"]];
//    [request setValue:_appkey forHTTPHeaderField:@"API-Key"];
    // 发送同步网络请求
    NSData *responseData2 = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    // 将返回数据responseData2转换为NSString，并输出
    NSString *responseString2 = [[NSString alloc] initWithData:responseData2 encoding:NSUTF8StringEncoding];
    //NSLog(@"asda%@",responseString2);
     NSString * xml = [[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
     NSDictionary *_xmlDic = [xml JSONValue];
    
    //NSLog(@"asfafsasdfdsa%@",_xmlDic);
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
    [responseString2 release];
    [xml release];
    
    
    
    
    
    

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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
//    NSLog(@"%@",searchBar.text);
    if (self.segmentControl.selectedSegmentIndex==1) {
        [self souSuo:searchBar.text];
    }
    if (self.segmentControl.selectedSegmentIndex==2) {
        [self yinYu:searchBar.text];
    }
        
    
}

-(void)yinYu:(NSString*)searchTxt
{
    
    NSURLRequest *request4 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/search?q=%@",searchTxt]]];
    
    
    NSData *responseData4 = [NSURLConnection sendSynchronousRequest:request4 returningResponse:NULL error:NULL];
    NSString *responseString4= [[NSString alloc] initWithData:responseData4 encoding:NSUTF8StringEncoding];
    NSString * xml4 = [[NSString alloc]initWithData:responseData4 encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic4 = [xml4 JSONValue];
    NSLog(@"adsasdas%@",responseString4);
    NSLog(@"%@",_xmlDic4);
    NSMutableArray *authors = [NSMutableArray array];
    NSArray *MovieList4 = [_xmlDic4 objectForKey:@"musics"];
    
    for(NSDictionary *_dic4 in MovieList4)
    {
        Author *author = [[[Author alloc]init]autorelease];
        author.authorName =  [_dic4 objectForKey:@"title"];
        author.authorString = [[_dic4 objectForKey:@"images"]objectForKey:@"small"];
        NSData *thumbnailData4 = [NSData dataWithContentsOfURL:[NSURL URLWithString:author.authorString]];
        author.authorImage = [UIImage imageWithData:thumbnailData4];
        
        
        self.authors = authors;
        
        [self.authors addObject:author];
        
        
    }
   [tableV3 reloadData];


}





-(void)souSuo:(NSString *)searchText
{
    NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@",searchText]]];
    
    
    NSData *responseData3 = [NSURLConnection sendSynchronousRequest:request3 returningResponse:NULL error:NULL];
    NSString *responseString3= [[NSString alloc] initWithData:responseData3 encoding:NSUTF8StringEncoding];
    NSString * xml3 = [[NSString alloc]initWithData:responseData3 encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic3 = [xml3 JSONValue];
    NSLog(@"adsasdas%@",responseString3);
    //NSLog(@"%@",_xmlDic3);
    NSMutableArray *books = [NSMutableArray array];
    NSArray *MovieList3 = [_xmlDic3 objectForKey:@"books"];
    
    for(NSDictionary *_dic3 in MovieList3)
    {
        Book *book = [[[Book alloc]init]autorelease];
        book.bookTitle =  [_dic3 objectForKey:@"title"];
        book.bookString = [[_dic3 objectForKey:@"images"]objectForKey:@"small"];
        NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.bookString]];
      book.bookImage = [UIImage imageWithData:thumbnailData1];
        NSLog(@"++++%@",book.bookTitle);
        
        self.books = books;
        
        [self.books addObject:book];
    }
    [responseString3 release];
    [tableV2 reloadData];
}
- (void)getData
{
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/onlines?apikey=0dea1ee3719c992829be5caa54d5cb78"]];
    NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:NULL error:NULL];
    
    NSString *responseString1 = [[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding];
    
    
    NSString * xml1 = [[NSString alloc]initWithData:responseData1 encoding:NSUTF8StringEncoding];
    NSDictionary *_xmlDic1 = [xml1 JSONValue];
    
    
    
    
    NSString *responseString = [[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding];
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
        NSData *thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:online.onlineString]];
        online.onlineImage = [UIImage imageWithData:thumbnailData];
        
        
        self.onlines = onlines;
        
        [self.onlines addObject:online];
    }
    [tableV1 reloadData];
   
    [responseString1 release];
    [xml1 release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    if(tableView.tag == 1)
    {
        Movie *movie = [self.movies objectAtIndex:indexPath.row];
        
        cell.textLabel.text = movie.movieName;
        if (movie.thumbnail)
        {
            cell.imageView.image = movie.thumbnail;
        }

    }
    
    else if(tableView.tag == 2)
    {
        OnLine *online = [self.onlines objectAtIndex:indexPath.row];
        cell.textLabel.text = online.onlineTitle;
        if(online.onlineImage)
        {
            cell.imageView.image = online.onlineImage;
        }
    }
    
    else if(tableView.tag ==3)
    {
        Book *book = [self.books objectAtIndex:indexPath.row];
        cell.textLabel.text = book.bookTitle;
    }
    else if(tableView.tag ==4)
    {
        Author *author = [self.authors objectAtIndex:indexPath.row];
        cell.textLabel.text = author.authorName;
        
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
    FirstViewController *first = [[FirstViewController alloc]init];
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    first.movieID =movie.movieID;
    first.movieName = movie.movieName;
    first.kamovie = [self.movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:first animated:YES];
    
    
    [first release];
}

@end
