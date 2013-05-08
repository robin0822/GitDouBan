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
#import "QyhCell.h"
#import "FirstViewController.h"

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
    self.navigationItem.title = @"电影收藏";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //_segmentedControlArray = [NSArray arrayWithObjects:@"电影",@"图书", nil];
    //创建分区视图
//    UISegmentedControl * _segmentedControl = [[UISegmentedControl alloc]initWithItems:_segmentedControlArray];
//    _segmentedControl.momentary  = NO;
//    _segmentedControl.segmentedControlStyle = UISegmentedControlNoSegment;
//    _segmentedControl.frame = CGRectMake(0, 0, 320, 38);
//    _segmentedControl.tintColor = [UIColor grayColor];
//    [_segmentedControl addTarget:self action:@selector(_loadData:) forControlEvents:UIControlEventValueChanged];
//    
//    
//    _segmentedControl.selectedSegmentIndex=0;
//    // self.segmentControl=_segmentedControl;
//    [self.view addSubview:_segmentedControl];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 420)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(220.0, 0.0, 90.0, 40.0);
    [button setTitle:@"图书收藏" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
    
    
    
    
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
    
    
    

    
    
}




-(void)add
{
    
    
    BookViewController *bookview = [[BookViewController alloc]init];
    UINavigationController *navigtion = [[UINavigationController alloc]initWithRootViewController:bookview];
    bookview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    navigtion.navigationBar.tintColor = [UIColor grayColor];
    [self presentViewController:navigtion animated:YES completion:nil];
    [navigtion release];
    [bookview release];
    
}
//-(void)_loadData:(UISegmentedControl*)yy
//{
//    NSInteger index = yy.selectedSegmentIndex ;
//    if (index == 1)
//    {
//        BookViewController *bookview = [[BookViewController alloc]init];
//        UINavigationController *navigtion = [[UINavigationController alloc]initWithRootViewController:bookview];
//        bookview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        navigtion.navigationBar.tintColor = [UIColor grayColor];
//        [self presentViewController:navigtion animated:YES completion:nil];
//        [navigtion release];
//        [bookview release];
//        
//        
//    }
//    
//}




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
    
    return [self.students count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString *identifier = @"MovieCell";
    QyhCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[[QyhCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }

        if (!cell)
        {
            cell = [[[QyhCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
    
    
    Student *student = [self.students objectAtIndex:indexPath.row];
    cell.textLabel.text= student.bookName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    NSData *thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:student.bookString]];
    self.movieIMage = [UIImage imageWithData:thumbnailData];
    cell.imageView.image = self.movieIMage;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80.0;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Student *stu = [self.students objectAtIndex:indexPath.row];
        [self.students removeObject:stu];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self save];
}
- (void)save
{
    
    
    
    
    NSData *studentData1 = [NSKeyedArchiver archivedDataWithRootObject:self.students];
    NSString *filepath1 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    [studentData1 writeToFile:[filepath1 stringByAppendingPathComponent:@"students.bmbbchive"] atomically:YES];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FirstViewController *first = [[FirstViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    Student *student = [self.students objectAtIndex:indexPath.row];
    first.movieID =student.bookID;
    first.movieName = student.bookTitle;
    //first.movieimage = student.bookImage;
    first.movieString = student.bookString;
    //first.kamovie = [self.books objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:first animated:YES];
    NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:student.bookString]];
    first.movieimage = [UIImage imageWithData:thumbnailData1];
    
    [first release];
    
    
    
    
    
}



@end
