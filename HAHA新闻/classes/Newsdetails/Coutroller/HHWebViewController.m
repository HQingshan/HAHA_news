//
//  HHWebViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/18.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHNewsdetailsTableViewController.h"
#import "HHWebViewController.h"
#import "HHNewsModel.h"



@interface HHWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@property (strong, nonatomic) UIBarButtonItem * collectButton ;

@end

@implementation HHWebViewController


-(void)viewDidAppear:(BOOL)animated{
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"Askcollect" object: self.newdict ];
}

-(void)Showcollectbtn:(NSNotification *)noti{
     self.collectButton.image = [UIImage imageNamed:@"shoucang-1"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    //新闻详情页⾯ 不使用webview
    UIBarButtonItem *button =[[UIBarButtonItem alloc]initWithTitle:@"新闻详情" style:UIBarButtonItemStylePlain target:self action:@selector(butClick:) ];
    button.tintColor = [UIColor blackColor];
    
    //创建收藏按钮
    _collectButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self  action:@selector(collect:)];
    _collectButton.image = [UIImage imageNamed:@"shoucang"];
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:button, _collectButton, nil];

    
    
    NSURL *url = [NSURL URLWithString:self.news.url];
    //加载网页
    [self.WebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Showcollectbtn:) name:@"Showcollectbtn" object:nil];
}


// 收藏按钮
- (void)collect:(UIButton *)collectButton{

    if (self.collectButton.image == [UIImage imageNamed:@"shoucang-1"]) {
        self.collectButton.image = [UIImage imageNamed:@"shoucang"];
    }else{
        self.collectButton.image = [UIImage imageNamed:@"shoucang-1"];}
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Addcollect" object: self.newdict ];
    
}
//新闻详情页⾯
- (void)butClick:(UIButton *)collectButton{
    HHNewsdetailsTableViewController   *schvc = [[HHNewsdetailsTableViewController alloc]init];
    schvc.newdict = self.newdict ;
    
    [self.navigationController  pushViewController: schvc animated:YES];
    
    
}

@end
