//
//  HHsearchrecordTableViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/20.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHsearchrecordTableViewController.h"
#import "HHSearchViewController.h"


@interface HHsearchrecordTableViewController ()<UISearchBarDelegate>

/*        搜索记录       */
@property (nonatomic, strong) NSMutableArray  *Searcharray;


@end

@implementation HHsearchrecordTableViewController

//加载搜索记录数组数据
- (NSMutableArray *)Searcharray
{
    if (!_Searcharray){
        
        // 获取文件路径
        NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath =  [Documents stringByAppendingPathComponent:@"SearchList.json" ];
//        NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        
        if (data == NULL) {
            _Searcharray = [[NSMutableArray alloc]init];
        }else{
            // 将json数据转数组
            NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dictArray) {
                [temp addObject:dict];
            }
            _Searcharray = temp;
        }
    }
    return _Searcharray;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    // 加载全路径
    NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath =  [Documents stringByAppendingPathComponent:@"SearchList.json" ];
    // 数组转JSON数据
    NSData *tempData = [NSJSONSerialization  dataWithJSONObject:self.Searcharray options:NSJSONWritingPrettyPrinted  error:nil];
    //        NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    // 写入数据
    [tempData writeToFile:filePath atomically:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建搜索栏
    UISearchBar * searchBar = [[UISearchBar alloc]init];
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    searchBar.delegate =self;
    searchBar.frame = CGRectMake(0, 0, 250, 35);
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    searchBar.placeholder = @"搜索新闻";
    [View addSubview:searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = View;
    
    self.tableView.tableFooterView = [[UIView alloc] init]; 
}

// 搜索内容
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
//    NSLog(@"--搜索内容--%@--",searchBar.text);
    [self.Searcharray addObject:searchBar.text];
    HHSearchViewController   *schvc = [[HHSearchViewController alloc]init];
    schvc.search =  searchBar.text;
    
    [self.navigationController  pushViewController: schvc animated:YES];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.Searcharray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 //       获取重用池中的cell
 static NSString *IDCell = @"IDCell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
 //       如果没有取到,就初始化
 if (!cell)
 {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
 cell.backgroundColor = [UIColor clearColor];
 
 }
    cell.textLabel.text = self.Searcharray[self.Searcharray.count - indexPath.row -1];
 
 return cell;
}


//    左滑删除
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //      把删除这一行的新闻从 显示新闻的名单中删除掉
        [self.Searcharray removeObjectAtIndex:(self.Searcharray.count - indexPath.row -1)];
        completionHandler (YES);
        //      删掉数据后更新整个列表
        [self.tableView reloadData];
    }];
    
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}


@end
