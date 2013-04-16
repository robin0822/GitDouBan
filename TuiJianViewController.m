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

@interface TuiJianViewController ()
{
     NSArray                       * _segmentedControlArray;
    UITableView * tableV;
    UITableView * tableV1;
}
@property(nonatomic,retain)Movie *movie;
@property(nonatomic,retain)NSMutableArray *movies;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 420)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
     tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 400)];
    
    tableV1.tag = 2;
    tableV1.delegate = self;
    tableV1.dataSource = self;
   
    
    _segmentedControlArray = [NSArray arrayWithObjects:@"电影",@"图书",@"音乐",@"活动", nil];
    //创建分区视图
    UISegmentedControl * _segmentedControl = [[UISegmentedControl alloc]initWithItems:_segmentedControlArray];
    _segmentedControl.momentary  = NO;
    _segmentedControl.segmentedControlStyle = UISegmentedControlNoSegment;
    _segmentedControl.frame = CGRectMake(0, 0, 320, 40);
    _segmentedControl.tintColor = [UIColor grayColor];
    [_segmentedControl addTarget:self action:@selector(_loadData:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.selectedSegmentIndex=0;
    [self.view addSubview:_segmentedControl];
    
//    NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.douban.com/v2/onlines"]];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", responseString);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/movie/top250"]];
    // 发送同步网络请求
    NSData *responseData2 = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    // 将返回数据responseData2转换为NSString，并输出
    NSString *responseString2 = [[NSString alloc] initWithData:responseData2 encoding:NSUTF8StringEncoding];
//NSData *responseData2 = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    
    
//    NSURL* url = [NSURL URLWithString:@"https://api.douban.com/v2/onlines"];
//    NSMutableURLRequest *urlRequest=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:responseData];
//    
//    NSData *responseData2 = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:NULL error:NULL];
//    NSString *responseString2 = [[NSString alloc] initWithData:responseData2 encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responseString2);

     NSString * xml = [[NSString alloc]initWithData:responseData2 encoding:NSUTF8StringEncoding];
     NSDictionary *_xmlDic = [xml JSONValue];
    
    NSLog(@"asfafsasdfdsa%@",_xmlDic);
     NSMutableArray *movies = [NSMutableArray array];
    NSArray *  MovieList  =   [_xmlDic objectForKey:@"subjects"];
    for(NSDictionary *_dic in MovieList)
    {
        Movie *movie = [[[Movie alloc]init]autorelease];
        movie.movieName =  [_dic objectForKey:@"title"];
        movie.thumbnailURLString = [[_dic objectForKey:@"images"]objectForKey:@"small"];
        NSData *thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.thumbnailURLString]];
        movie.thumbnail = [UIImage imageWithData:thumbnailData];

        
        self.movies = movies;

        [self.movies addObject:movie];
                
        
    }
    
        [tableV reloadData];

}

-(void)_loadData:(UISegmentedControl*)yy
{
    
    NSInteger index = yy.selectedSegmentIndex ;
    if (index == 1) {
        [tableV removeFromSuperview];
        [self.view addSubview:tableV1];
    }
    if (index == 0) {
        [tableV1 removeFromSuperview];
        [self.view addSubview:tableV];
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
    else
    {
        return 5;
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
    
    else
    {
        cell.textLabel.text = @"xiaohou";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 80.0;
}


@end
