//
//  SouCangViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-24.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "SouCangViewController.h"
#import "BookViewController.h"
#import "Student.h"

@interface SouCangViewController ()
{
    NSArray                       * _segmentedControlArray;
    UITableView * tableV;
    UITableView * tableV1;
    
}
@property(nonatomic,retain)NSMutableArray *students;
@property(nonatomic,retain)UIImage *movieIMage;
@property(nonatomic,retain)UISegmentedControl *segmentControl;

@end

@implementation SouCangViewController

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
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _segmentedControlArray = [NSArray arrayWithObjects:@"电影",@"图书", nil];
    //创建分区视图
    UISegmentedControl * _segmentedControl = [[UISegmentedControl alloc]initWithItems:_segmentedControlArray];
    _segmentedControl.momentary  = NO;
    _segmentedControl.segmentedControlStyle = UISegmentedControlNoSegment;
    _segmentedControl.frame = CGRectMake(0, 0, 320, 45);
    _segmentedControl.tintColor = [UIColor grayColor];
    [_segmentedControl addTarget:self action:@selector(_loadData:) forControlEvents:UIControlEventValueChanged];
    
    
    _segmentedControl.selectedSegmentIndex=0;
    // self.segmentControl=_segmentedControl;
    [self.view addSubview:_segmentedControl];
}

-(void)_loadData:(UISegmentedControl*)yy
{
    NSInteger index = yy.selectedSegmentIndex ;
    if (index == 0) {
        
        
    }
    else if (index == 1)
    {
        BookViewController *bookview = [[BookViewController alloc]init];
        UINavigationController *navigtion = [[UINavigationController alloc]initWithRootViewController:bookview];
        
        
        [self presentViewController:navigtion animated:YES completion:nil];
        
        
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
