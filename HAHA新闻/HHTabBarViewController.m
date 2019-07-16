//
//  HHTabBarViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/9.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHTabBarViewController.h"
#import "HHVideoTableViewController.h"
#import "HHNewsViewController.h"
#import "HHhistoryTableViewController.h"
#import "HHcollectTableViewController.h"

@interface HHTabBarViewController ()

@end

@implementation HHTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //  添加子控制器
    [self setupAllChildViewController];
    
}



// 添加所以子控制器
-(void)setupAllChildViewController{
    // 1.新闻首页
    HHNewsViewController  *news = [[HHNewsViewController alloc]init];

    UINavigationController *newsnav = [[UINavigationController alloc]initWithRootViewController:news];
    

    [self addChildViewController:newsnav];

    //导航栏背景颜色
    news.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1/255.0 green:200/255.0 blue:230/255.0 alpha:1];
    UIBarButtonItem *button =[[UIBarButtonItem alloc]initWithTitle:@"HAHA新闻" style:UIBarButtonItemStylePlain target:nil action:nil ];

    button.tintColor = [UIColor blackColor];
    
    news.navigationItem.leftBarButtonItem = button;


    news.tabBarItem.image = [UIImage imageNamed:@"xinwen"];
    news.tabBarItem.selectedImage = [UIImage imageNamed:@"xinwen-1"];
    news.tabBarItem.title = @"新闻";
    [news.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
    // 2.收藏新闻
    HHcollectTableViewController *collect = [[HHcollectTableViewController alloc]init];
    UINavigationController *collectnav = [[UINavigationController alloc]initWithRootViewController:collect];

    [self addChildViewController:collectnav];
    
    collect.navigationItem.title = @"我的收藏";
    collect.tabBarItem.image = [UIImage imageNamed:@"shoucangx"];
    collect.tabBarItem.selectedImage = [UIImage imageNamed:@"shoucangx-1"];
    collect.tabBarItem.title = @"收藏";
    [collect.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
    // 3.历史记录
    HHhistoryTableViewController  *history = [[HHhistoryTableViewController alloc]init];
    UINavigationController *historynav = [[UINavigationController alloc]initWithRootViewController:history];

    [self addChildViewController:historynav];
    
    history.navigationItem.title = @"浏览历史";
    history.tabBarItem.image = [UIImage imageNamed:@"lishi"];
    history.tabBarItem.selectedImage = [UIImage imageNamed:@"lishi-1"];
    history.tabBarItem.title = @"历史";
    [history.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
    
    
    
    // 4.视频  #import "HHVideoTableViewController.h"
    
    HHVideoTableViewController  *video = [[HHVideoTableViewController alloc]init];
    UINavigationController *videonav = [[UINavigationController alloc]initWithRootViewController:video];

    [self addChildViewController:videonav];

    video.navigationItem.title = @"今日头条视频";
    video.tabBarItem.image = [UIImage imageNamed:@"shipin"];
    video.tabBarItem.selectedImage = [UIImage imageNamed:@"shipin-1"];
    video.tabBarItem.title = @"视频";
    [video.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];



    self.selectedIndex = 2;
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    
}



@end
