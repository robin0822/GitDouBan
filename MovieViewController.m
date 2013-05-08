//
//  MovieViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-26.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "MovieViewController.h"
#import "Book.h"
#import "JSON.h"
#import "QyhCell.h"
#import "Movie.h"
#import "FirstViewController.h"


@interface MovieViewController ()

{
    BOOL isAlreadyScrolling;
}
@property(nonatomic,retain)NSMutableArray *movies;
@property(nonatomic,retain)Movie *movie;
@property(nonatomic,retain)NSMutableData *responseData;

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property(nonatomic,retain) UISearchBar *searchBar;

@end

@implementation MovieViewController

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
    
    self.navigationItem.title = @"著名电影";

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 200.0 + 44.0)];
    headerView.backgroundColor = [UIColor grayColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 200.0)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    
    //self.searchBar = searchBar;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    [headerView addSubview:searchBar];

    // 所有幻灯片的底视图
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0 * 8, 200.0)];
    
    UIImageView *imageView6fake = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.jpg"]];
    imageView6fake.frame = CGRectMake(0.0, 0.0, 320.0, 200.0);
    [contentView addSubview:imageView6fake];
    [imageView6fake release];
    // 假1
    UIImageView *imageView1fake = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    imageView1fake.frame = CGRectMake(320.0 * 7, 0.0, 320.0, 200.0);
    [contentView addSubview:imageView1fake];
    [imageView1fake release];

    for (int i=0; i<6; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i+1]]];
        imageView.frame = CGRectMake(320.0 * i + 320.0, 0.0, 320.0, 200.0);
        [contentView addSubview:imageView];
        [imageView release];
    }
 
    [scrollView addSubview:contentView];
    self.contentView = contentView;
    [contentView release];
    scrollView.contentSize = CGSizeMake(320.0 * 8, 200.0);
    
   
    [headerView addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release];
   
    [self.scrollView zoomToRect:CGRectMake(320.0, 0.0, 320.0, 200.0) animated:NO];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, 44.0 + 150.0, 320.0, 20.0)];
    pageControl.numberOfPages = 6;
    pageControl.currentPage = 0;
    [headerView addSubview:pageControl];
    self.pageControl = pageControl;
    [pageControl release];
    
    self.tableView.tableHeaderView = headerView;
    
    [headerView release];
    
    // 滚动table view隐藏search bar
    self.tableView.contentOffset = CGPointMake(0.0, 44.0);
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timer1) userInfo:nil repeats:YES];
    
    
    
}


- (void)timer1
{
    CGFloat imageViewX = _scrollView.contentOffset.x;
    int i = imageViewX  / 320 ;
    if (i == 7 ) {
        i = 1;
    }
    [_scrollView scrollRectToVisible:CGRectMake(i*320 +320, 0, 320, 200) animated:YES];
    //    NSLog(@"%d",i);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.scrollView)
    {
        
        CGFloat offsetX = self.scrollView.contentOffset.x;
        int x = (int)(floor((offsetX-320.0+160.0) / 320.0) + 6.0) % 6;

        self.pageControl.currentPage = x % 6;
        if (!isAlreadyScrolling && offsetX >= -50.0 && offsetX < 50.0)
        {
           
            isAlreadyScrolling = YES;
            self.scrollView.contentOffset = CGPointMake(320.0 * 6.0+offsetX, 0.0);
            isAlreadyScrolling = NO;
        }
        
        
        if (!isAlreadyScrolling && offsetX >= -50.0 + 320.0 * 7 && offsetX < 50.0 + 320.0 * 7)
        {
            
            isAlreadyScrolling = YES;
            self.scrollView.contentOffset = CGPointMake(320.0+(offsetX - 320.0 * 7), 0.0);
            isAlreadyScrolling = NO;
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.contentView;
}

-(void)hideKeyboards
{
    [self.searchBar resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.movies removeAllObjects];
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
       [self resignFirstResponder];
    //NSString *str = @"张艺谋";
    
    
    
    
    
    searchBar.text = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/movie/search?q=%@&apikey=0dea1ee3719c992829be5caa54d5cb78",searchBar.text]];
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]autorelease];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO]autorelease];
    
    [connection start];
    [self hideKeyboards];
 
   
 
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
    
    
    NSString * xml = [[[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding]autorelease];
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
        [self.tableView reloadData];
       
        
    }
    
    //[xml release];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MovieCell";
    QyhCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[[QyhCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = movie.movieName;
    if (movie.thumbnail)
    {
        cell.imageV.image = movie.thumbnail;
    }

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FirstViewController *first = [[FirstViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    
    first.movieID = movie.movieID;
    first.movieName = movie.movieName;
    first.movieimage = movie.thumbnail;
    
    
    [self.navigationController pushViewController:first animated:YES];
    [first release];
    

}

@end
