//
//  HHhistoryTableViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/18.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHWebViewController.h"
#import "HHhistoryTableViewController.h"
#import "HHNew_p0_TableViewCell.h"
#import "HHNewsModel.h"

#import "HQS_LocalData.h"

@interface HHhistoryTableViewController ()

@property (nonatomic, strong) NSMutableArray *HistorynewsArray;

@end

@implementation HHhistoryTableViewController

//加载历史记录数组数据 
- (NSMutableArray *)HistorynewsArray
{
    if (!_HistorynewsArray){
            _HistorynewsArray = [HQS_LocalData OCArrayBeReadfromDocumentsJSONFileName: @"HistoryList"];
    }
    return _HistorynewsArray;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView  reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [HQS_LocalData OCArray:self.HistorynewsArray writeToDocumentsJSONFileName:@"HistoryList"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册通知(接收,监听,一个通知)添加记录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ADD:) name:@"ADD" object:nil];
    
    self.tabBarController.selectedIndex = 1;
    
    self.tableView.tableFooterView = [[UIView alloc] init]; 

}

//添加浏览记录
-(void)ADD:(NSNotification *)noti2{
    
    NSDictionary *dict = [noti2 object];
    
    BOOL exchange = NO;
    for (int i =  (int)lroundf( self.HistorynewsArray.count - 1 ); i >= 0; i--) {
        NSDictionary *obj = self.HistorynewsArray[i];
        if ([ obj[@"title"] isEqualToString: dict[@"title"] ] ) {
            [self.HistorynewsArray exchangeObjectAtIndex:i withObjectAtIndex:self.HistorynewsArray.count - 1];
            exchange = YES;
            break;
        }
    }
    
    if (exchange == NO) {
        [self.HistorynewsArray addObject: dict ];
    }

    [self.tableView  reloadData];
    
    [HQS_LocalData OCArray:self.HistorynewsArray writeToDocumentsJSONFileName:@"HistoryList"];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.HistorynewsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //       获取重用池中的cell
    static NSString *IDCell = @"IDCell";
    HHNew_p0_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    //       如果没有取到,就初始化
    if (!cell)
    {
        cell = [[HHNew_p0_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.news = [HHNewsModel newsWithDict:self.HistorynewsArray[self.HistorynewsArray.count - indexPath.row -1]];

    return cell;
}


// 设置 cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 78;
}


//    左滑删除
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //      把删除这一行的国家从 显示汇率换算的名单中删除掉
        [self.HistorynewsArray removeObjectAtIndex:(self.HistorynewsArray.count - indexPath.row -1)];
        completionHandler (YES);
        //      删掉数据后更新整个列表
        [self.tableView reloadData];
    }];
    
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

// 选中了 cell 时触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HHWebViewController   *webvc = [[HHWebViewController alloc]init];
    webvc.newdict = self.HistorynewsArray[self.HistorynewsArray.count - indexPath.row -1] ;
    webvc.news = [HHNewsModel newsWithDict: self.HistorynewsArray[self.HistorynewsArray.count - indexPath.row -1] ];
    [self.navigationController  pushViewController:webvc animated:YES];
    
}

@end
