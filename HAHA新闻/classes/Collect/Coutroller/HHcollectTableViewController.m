//
//  HHcollectTableViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/19.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHWebViewController.h"
#import "HHcollectTableViewController.h"
#import "HHNew_p0_TableViewCell.h"
#import "HHNewsModel.h"

#import "HQS_LocalData.h"

@interface HHcollectTableViewController ()

@property (nonatomic, strong) NSMutableArray *CollectnewsArray;

@end

@implementation HHcollectTableViewController

//加载收藏记录数组数据
- (NSMutableArray *)CollectnewsArray
{
    if (!_CollectnewsArray){
        
        _CollectnewsArray = [HQS_LocalData OCArrayBeReadfromDocumentsJSONFileName:@"CollectList"];
    }
    return _CollectnewsArray;
}

-(void)viewWillAppear:(BOOL)animated{
            NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    [self.tableView  reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    

    
    [HQS_LocalData OCArray:self.CollectnewsArray writeToDocumentsJSONFileName:@"CollectList"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Askcollect:) name:@"Showcollectbtn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Askcollect:) name:@"Askcollect" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Addcollect:) name:@"Addcollect" object:nil];
    self.tabBarController.selectedIndex = 0;
    self.tableView.tableFooterView = [[UIView alloc] init]; 
}



-(void)Addcollect:(NSNotification *)noti{
    NSDictionary *dict = [noti object];
    
//        NSLog(@"1111111%@",dict);
    BOOL exchange = NO;
    for (int i = (int)lroundf(self.CollectnewsArray.count - 1); i >= 0; i--) {
        NSDictionary *obj = self.CollectnewsArray[i];
        if ([ obj[@"title"] isEqualToString: dict[@"title"] ] ) {
            [self.CollectnewsArray exchangeObjectAtIndex:i withObjectAtIndex:self.CollectnewsArray.count - 1];
            exchange = YES;
            break;
        }
    }
    
    if (exchange == NO) {
//        NSLog(@"-----添加--");
        [self.CollectnewsArray addObject: dict ];
    }if (exchange == YES) {
//        NSLog(@"-----删除--");
        [self.CollectnewsArray removeObjectAtIndex:self.CollectnewsArray.count - 1];
    }
    
    [self.tableView  reloadData];
    
    
    [HQS_LocalData OCArray:self.CollectnewsArray writeToDocumentsJSONFileName:@"CollectList"];
    
    
}
-(void)Askcollect:(NSNotification *)noti{
    NSDictionary *dict = [noti object];
    
    //        NSLog(@"1111111%@",dict);
    BOOL collected = NO;
    for (int i = (int)lroundf(self.CollectnewsArray.count - 1); i >= 0; i--) {
        NSDictionary *obj = self.CollectnewsArray[i];
        if ([ obj[@"title"] isEqualToString: dict[@"title"] ] ) {
            collected = YES;
            break;
        }
    }
    
    if (collected == NO) {
                NSLog(@"-----no collected--");
        
    }if (collected == YES) {
                NSLog(@"-----collected--");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Showcollectbtn" object: nil ];
    }
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.CollectnewsArray.count;
    
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
    if (self.CollectnewsArray[self.CollectnewsArray.count - indexPath.row -1] != NULL) {
        cell.news = [HHNewsModel newsWithDict: self.CollectnewsArray[self.CollectnewsArray.count - indexPath.row -1] ];
    }
    
    
    
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
        [self.CollectnewsArray removeObjectAtIndex:(self.CollectnewsArray.count - indexPath.row -1)];
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
    webvc.newdict = self.CollectnewsArray[self.CollectnewsArray.count - indexPath.row -1] ;
    webvc.news = [HHNewsModel newsWithDict: self.CollectnewsArray[self.CollectnewsArray.count - indexPath.row -1] ];
    [self.navigationController  pushViewController:webvc animated:YES];
    
}
@end
