//
//  GuanYuViewController.m
//  GitDouBan
//
//  Created by ibokan on 13-4-16.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "GuanYuViewController.h"
#import "JSON.h"
#import "MovieViewController.h"
#import "AboutViewController.h"
@interface GuanYuViewController ()
{
    UITableView * tableV;

}
@property(nonatomic,retain)NSMutableData *responseData1;
@end

@implementation GuanYuViewController

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
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 40.0, 320.0, 120)];
    
    tableV.tag = 1;
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    self.navigationItem.title = @"更多内容";
    
    
    
    self.view.backgroundColor = [UIColor grayColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
    
     if(indexPath.section==0&indexPath.row==0){
    
   // UITableViewCell *cell;
   
        static NSString *identifier = @"MessageTitleCell";
        
        // 重用
        cell = [tableV dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
        }
         cell.textLabel.text = @"著名导演电影搜索";
         
                
    }
    
     else
     {
         
         static NSString *identifier = @"MegeTitleCell";
         
         // 重用
         cell = [tableV dequeueReusableCellWithIdentifier:identifier];
         if (!cell)
         {
             cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
             //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             //cell.accessoryType = UITableViewCellAccessoryCheckmark;
             
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             
         }

         
         cell.textLabel.text = @"关于豆瓣";
     }

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section==0&indexPath.row==0)
    {
        
        MovieViewController *movieview = [[MovieViewController alloc]initWithStyle:UITableViewStylePlain];
        
        
        self.navigationController.navigationBar.tintColor = [UIColor grayColor];
        
        [self.navigationController pushViewController:movieview animated:YES];
        [movieview release];
        
    }
    else
    {
        
        AboutViewController *aboutaa = [[AboutViewController alloc]init];
        
        [self.navigationController pushViewController:aboutaa animated:YES];
        
        [aboutaa release];
    }
        
}



@end
