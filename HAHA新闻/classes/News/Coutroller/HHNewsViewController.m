//
//  HHNewsViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/11.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHNewsTableView.h"
#import "HHWebViewController.h"

#import "HHsearchrecordTableViewController.h"
#import "HHNewsModel.h"

//#import "HHNew_p0_TableViewCell.h"
//#import "HHNew_p1_TableViewCell.h"
//#import "HHNew_p3_TableViewCell.h"
#import "HHNewsViewController.h"


#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height
#define AppColor [UIColor colorWithRed:0.00392 green:0.576 blue:0.871 alpha:1]


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone
 
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)


long Sc[5]={0,0,0,0,0};

@interface HHNewsViewController ()<UIScrollViewDelegate,UISearchBarDelegate>


/** 频道数据模型 */
@property (nonatomic, strong) NSArray *channelList;

/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;
/** 新闻视图 */
@property (nonatomic, strong) UIScrollView *bigScrollView;
/** 下划线 */
@property (nonatomic, strong) UIView *underline;

@property (nonatomic, strong) NSArray *getLabelArrayFromSubviews;

@end

@implementation HHNewsViewController

/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UILabel *label in _smallScrollView.subviews) {
        if ([ label isKindOfClass:[UILabel class]]) {
            [arrayM addObject:label ];
        }
    }
    return arrayM.copy;
    
}

-(NSArray *)channelList{
    if (_channelList == nil) {
        NSArray *channelList = @[@"新闻",@"娱乐",@"体育",@"广州",@"军事",@"科技",@"国际"];
        _channelList =channelList;
    }
    return _channelList;
    
}

-(UIScrollView *)bigScrollView{
    if (_bigScrollView == nil) {
        
        
        UIScrollView *scroll = [[UIScrollView alloc]init ];
        

        scroll.frame = CGRectMake(0,CGRectGetMaxY(self.smallScrollView.frame), ScrW, ScrH-CGRectGetMaxY(self.smallScrollView.frame)- kNavAndTabHeight );
        scroll.backgroundColor = [UIColor whiteColor];
        
        _bigScrollView = scroll ;
    }
    return _bigScrollView;
}

//  创建频道栏
- (UIScrollView *)smallScrollView
{
    
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, ScrW, 44)];
        _smallScrollView.backgroundColor = [UIColor colorWithRed:200/255.0 green:220/255.0 blue:232/255.0  alpha:1];
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        //         设置频道
        for (int i=0; i < self.channelList.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            // frame
            label.frame = CGRectMake(i*ScrW/5.0, 0, ScrW/5.0, 40);
            // 内容
            label.text = self.channelList[i];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = i;
            label.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
            [label addGestureRecognizer:labelTapGestureRecognizer];
            
            [_smallScrollView addSubview: label];
        }
        
        // 设置下划线
        [_smallScrollView addSubview:({
                        UILabel *firstLabel = [self getLabelArrayFromSubviews][0];
                        firstLabel.textColor = AppColor;
            // smallScrollView高度44，取下面4个点的高度为下划线的高度。
            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScrW/5.0, 4)];

            _underline.backgroundColor = AppColor;
            _underline;
        })];
    }
//    NSLog(@"%@",_smallScrollView.subviews);
    return _smallScrollView;
}

/** 频道Label点击事件 */
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    // 点击label后，让bigCollectionView滚到对应位置。
    for (UILabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor lightGrayColor];
    }
    label.textColor = AppColor ;
    
    [_bigScrollView setContentOffset:CGPointMake(label.tag * _bigScrollView.frame.size.width, 0) ];
    
    
    long i = label.tag ;
    if (i != Sc[i]) {
        NSLog(@"----加载%li页----",i);
        Sc[i] = i ;
        HHNewsTableView *tableView = [[HHNewsTableView alloc] initWithFrame:CGRectMake(ScrW*i, 0, ScrW, self.bigScrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.channel = self.channelList[i];

        [self.bigScrollView addSubview:tableView];


    }
    CGPoint center = self.underline.center;
    center.x = i*(ScrW/5.0)+ScrW/10.0;
    
    self.underline.center = center ;
//    NSLog(@"---%li---",i);
    NSLog(@"%@被点击了",label.text);
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =  UIRectEdgeNone  ;  //self.view.frame.origin.y会下移至navigationBar下方。
    
    [self.view addSubview:self.smallScrollView];
    
    [self.view addSubview:self.bigScrollView];
    
    
    
    [self setsearchBar];
    
        //加载第一页 tableView
        
        HHNewsTableView *tableView = [[HHNewsTableView alloc] initWithFrame:CGRectMake(ScrW*0, 0, ScrW, self.bigScrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.channel = self.channelList[0];
        
        [self.bigScrollView addSubview:tableView];
    
    
    self.smallScrollView.contentSize = CGSizeMake((ScrW/5.0)*self.channelList.count, 0);
    self.bigScrollView.contentSize = CGSizeMake(ScrW*self.channelList.count, 0);
    
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.delegate = self;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    
    
    //注册通知(接收,监听,一个通知)添加记录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Web:) name:@"Web" object:nil];
    
    
}
//创建搜索栏
- (void)setsearchBar{
    
    UISearchBar * searchBar = [[UISearchBar alloc]init];
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 250, 35);
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    searchBar.placeholder = @"搜索新闻";
    [View addSubview:searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = View;
    
    
}

//跳转搜索页面

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    HHsearchrecordTableViewController   *schvc = [[HHsearchrecordTableViewController alloc]init];
    
    [self.navigationController  pushViewController: schvc animated:YES];
    
    return NO;
    
    
}


   //跳转Web页面
-(void)Web:(NSNotification *)noti1{
    NSDictionary *dict = [noti1 object];
    
    HHWebViewController   *webvc = [[HHWebViewController alloc]init];
    webvc.newdict = dict ;
    webvc.news = [HHNewsModel newsWithDict: dict ];
    [self.navigationController  pushViewController:webvc animated:YES];
}




#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"第一个感觉到了");
    if (decelerate == NO) {
        int i = self.bigScrollView.contentOffset.x / ScrW ;
        if (i != Sc[i]) {
//            NSLog(@"----加载%i页----",i);
            Sc[i] = i;
            HHNewsTableView *tableView = [[HHNewsTableView alloc] initWithFrame:CGRectMake(ScrW*i, 0, ScrW, self.bigScrollView.frame.size.height) style:UITableViewStylePlain];
            tableView.channel = self.channelList[i];
            
            [self.bigScrollView addSubview:tableView];
        }
        
        //频道Label换颜色
        for (UILabel *label in [self getLabelArrayFromSubviews]) {
            label.textColor = [UIColor lightGrayColor];
            if (i == label.tag) {
                label.textColor = AppColor ;
            }
        }
        CGPoint center = self.underline.center;
        center.x = i*(ScrW/5.0)+ScrW/10.0;
        self.underline.center = center ;
    }
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"第二个感觉到了");
    int i = self.bigScrollView.contentOffset.x / ScrW ;
    if (i != Sc[i]) {
        Sc[i] = i;
        HHNewsTableView *tableView = [[HHNewsTableView alloc] initWithFrame:CGRectMake(ScrW*i, 0, ScrW, self.bigScrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.channel = self.channelList[i];
        [self.bigScrollView addSubview:tableView];
    }
    //频道Label换颜色
    for (UILabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor lightGrayColor];
        if (i == label.tag) {
            label.textColor = AppColor ;
        }
    }
    
    CGPoint center = self.underline.center;
    center.x = i*(ScrW/5.0)+ScrW/10.0;
    self.underline.center = center ;
    
}
@end


