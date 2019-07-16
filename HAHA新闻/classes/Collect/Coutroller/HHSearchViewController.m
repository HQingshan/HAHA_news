//
//  HHSearchViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/20.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHSearchViewController.h"
#import "HHNewsTableView.h"



#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height
@interface HHSearchViewController ()

@end

@implementation HHSearchViewController

- (void)viewDidLoad {
    

    self.navigationItem.title = @"搜索内容";
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HHNewsTableView *tableView = [[HHNewsTableView alloc] initWithFrame:CGRectMake(0, 0, ScrW, ScrH) style:UITableViewStylePlain];
    tableView.channel = self.search;
    
    [self.view addSubview:tableView];
}


@end
