//
//  BookViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-24.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "BookViewController.h"
#import "Student.h"
#import "Kuke.h"
#import "QyhCell.h"

@interface BookViewController ()
{
    UITableView * tableV;
     NSArray                       * _segmentedControlArray;
}
@property(nonatomic,retain)NSMutableArray *students;
@property(nonatomic,retain)UIImage *image;
@end

@implementation BookViewController

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
    self.navigationItem.title=@"图书收藏";
    
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(closeInterface)];
    self.navigationItem.leftBarButtonItem = returnButton;
    
    
        
    
        
    [returnButton release];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSData *studentData = [NSData dataWithContentsOfFile:[filepath stringByAppendingPathComponent:@"students.00bbchive"]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)closeInterface
{
    // 关闭当前modal view
    //[self dismissModalViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.students count]);
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
    
    
    
    Kuke *kuke = [self.students objectAtIndex:indexPath.row];
    cell.textLabel.text= kuke.bookTitle;
    NSData *thumbnailData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:kuke.bookPhone]];
      self.image = [UIImage imageWithData:thumbnailData1];
    
    cell.imageView.image= self.image;
    
        return cell;
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
    [studentData1 writeToFile:[filepath1 stringByAppendingPathComponent:@"students.00bbchive"] atomically:YES];
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80.0;
}

@end
