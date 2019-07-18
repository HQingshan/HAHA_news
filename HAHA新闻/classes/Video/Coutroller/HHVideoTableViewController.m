//
//  HHVideoTableViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/22.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHVideoTableViewCell.h"
#import "HHVideoTableViewController.h"
#import "HHVideoModel.h"
#import "HHFooterView.h"
#import <MediaPlayer/MediaPlayer.h>


int VDpage=1; 

@interface  HHVideoTableViewController ()<NSURLSessionDataDelegate,UIScrollViewDelegate>




@property (nonatomic, strong) NSMutableArray *fileData;

@property (nonatomic, strong) NSMutableArray *videoArray;

/**  内存缓存图片  */
@property (nonatomic, strong) NSMutableDictionary *images;
/*   队列   */
@property (nonatomic, strong) NSOperationQueue *queue;


@end


@implementation HHVideoTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];

    self.tableView.tableFooterView = [[UIView alloc] init]; 
    [self.tableView setContentOffset:CGPointMake(0, -50) animated:YES];
    self.tableView.delegate = self;
}



// 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
    
    
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [refreshControl beginRefreshing];
    
    [self refreshClick: refreshControl ];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    NSLog(@"refreshClick: -- 刷新触发");
    
    VDpage = 1;
    
    // 1. url
    NSURL *url=[NSURL  URLWithString:@"http://api01.idataapi.cn:8000/news/toutiao?kw=nba&pageToken=1&apikey=FKo121FpJnj9cGJkkUjHKZXEH0BV1QCaY3gpVWZanmGXGg8fGDIXoWSFtGhcLLU6"];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3.创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    //4.创建Task
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request];

    //5.执行Task
    [datatask resume];


    [refreshControl endRefreshing];

    [self.tableView reloadData];// 刷新tableView即可
    
}


// 创建上拉刷新控件
- (void)setupUpRefresh
{
    NSLog(@"refreshClick: -- 上拉刷新创建");
    HHFooterView *refreshHHFooterView = [HHFooterView refreshFooterView];
    refreshHHFooterView.hidden = YES;
    self.tableView.tableFooterView = refreshHHFooterView;
}

#pragma mark UIScrollView Delegate
// 上拉加载触发，在此获取数据
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    // 获取当前contentView滑动的位置(对应contentSize)
    CGFloat contenOffsetY = scrollView.contentOffset.y;
    
    // 如果tableView还没有数据或HHfooterView在显示时, 直接返回
    if ( self.tableView.tableFooterView.hidden == NO || self.fileData.count == 0)
    {
        return;
    }
    
    // 最后一个Cell显示时contentOffSetY应该在的最小位置(内容高度 + 边框 - 显示窗口高度 - footrerView高度)
    CGFloat targetContentOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - [UIScreen mainScreen].bounds.size.height - 35;
    
    // 若滑动位置在目标位置下(显示到最后一个Cell)时
    if (contenOffsetY >= targetContentOffsetY)
    {
        // 显示HHfooterView
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多数据
        [self loadMoreDatas];
    }
    
    
}
//  加载后续数据
- (void) loadMoreDatas{
    
    
    NSLog(@"refreshClick: -- 上拉刷新触发");
    
    /*
     
     dispatch_after   能让我们添加进队列的任务延时执行，该函数并不是在指定时间后执行处理，而只是在指定时间追加处理到dispatch_queu
     
     DISPATCH_TIME_NOW 表示现在，NSEC_PER_SEC 表示的是秒数，它还提供了 NSEC_PER_MSEC 表示毫秒
     该方法的第一个参数是 time，第二个参数是 dispatch_queue，第三个参数是要执行的block。
     */
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *video = @"nba";
        NSString *urlStr = [NSString stringWithFormat: @"http://api01.idataapi.cn:8000/news/toutiao?kw=%@&pageToken=%i",video,VDpage];
//        apikey=FKo121FpJnj9cGJkkUjHKZXEH0BV1QCaY3gpVWZanmGXGg8fGDIXoWSFtGhcLLU6
        urlStr=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        // 1. url
        NSURL *url = [NSURL URLWithString:urlStr];
        
        
        // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
        NSURLRequest *request = [NSURLRequest requestWithURL:url  ];
        
        // 3.采用苹果提供的共享session
        NSURLSession *session = [NSURLSession sharedSession];
        
        // 4.由系统直接返回一个dataTask任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *temp =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            
            NSArray *dictArray =temp[@"data"];
            for (NSDictionary *videodict in dictArray) {
//                                NSLog(@"----***--%@--**----",videodict);
                [self.fileData addObject:videodict ];
//                [self.videoArray addObject:[HHVideoModel videoWithDict: videodict]];
            }
            VDpage ++;
            //        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
        }];
        
        // 5.每一个任务默认都是挂起的，需要调用 resume 方法
        [dataTask resume];
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新状态, 隐藏HHFooterView
        self.tableView.tableFooterView.hidden = YES;
    });
    
    
}


#pragma mark - NSURLSessionDataDelegate


-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    completionHandler(NSURLSessionResponseAllow);
    
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
//     4.将得到数据进行返序列化
    NSDictionary *temp =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"----***--%@--**----",temp[@"data"] );
    
    if (temp[@"data"] != nil) {
        //        NSLog(@"----***--%@--**----",temp);
        // 加载全路径
        NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath =  [Documents stringByAppendingPathComponent:@"video.json" ];
        // 数组转JSON数据
        NSData *tempData = [NSJSONSerialization  dataWithJSONObject: temp[@"data"]  options:NSJSONWritingPrettyPrinted  error:nil];
        //    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
        // 写入数据
        [tempData writeToFile:filePath atomically:YES];
        
        if (VDpage == 1) {
            NSArray *dictArray =temp[@"data"];
            self.fileData = [[NSMutableArray alloc]init];
            for (NSDictionary *newsdict in dictArray) {
                [self.fileData addObject:newsdict ];
        }
            VDpage ++;
        }
    }
//    NSLog(@"----***-- %i  页--**----",VDpage);

}
//当申请数据加载结束时
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
//    NSLog(@"----***--%@--**----",self.fileData);
    [self.tableView reloadData];
    //    page ++;
    if (VDpage == 2 && self.fileData != nil ) {
//        [self setupUpRefresh];
    }
    
}


-(NSMutableDictionary *)images{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
    
}

-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue  = [[NSOperationQueue alloc]init];
        //最大bing并发数
        _queue.maxConcurrentOperationCount = 5;
    }
    
    return _queue;
}


- (NSMutableArray *)videoArray
{
    if (!_videoArray){
        NSArray *dictArray =self.fileData;
        //        NSLog(@"-----%@--------",[dictArray  valueForKey: @"rate" ][0]   );
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSDictionary *videodict in dictArray) {
            [temp addObject:[HHVideoModel videoWithDict:videodict]];
        }
        _videoArray = temp;
    }
    return _videoArray;
}


- (NSMutableArray *)fileData{
    if (!_fileData) {
        
        // 获取文件路径
        NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath =  [Documents stringByAppendingPathComponent:@"video.json" ];
        
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        
        if (data == NULL) {
            _fileData = [[NSMutableArray alloc]init];
        }else{
            // 将json数据转数组
            NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dictArray) {
                [temp addObject:dict];
            }
            _fileData = temp;
        }
    }
    
    return _fileData;
}


// 每个 Section 中的 Cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"****** %zd ******",self.fileData.count);
    
    return self.fileData.count ;
    
}



// 设置每个 Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHVideoModel *video = [HHVideoModel videoWithDict: self.fileData[indexPath.row]];
//    //保存图片的名称到沙盒缓存
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES)lastObject] ;
    // 创建一个cellID，用于cell的重用
    NSString *P1cellID = @"P1cellID";
    // 从tableview的重用池里通过cellID取一个cell
    HHVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:P1cellID];
    if (cell == nil) {
        // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
        cell = [[HHVideoTableViewCell alloc] init];
    }
    cell.video =video;
    
    [cell setVideo: video];
    NSLog(@"%@",video.title);
    
    cell.HHUIImage =[UIImage imageNamed: @"jiazai" ];
    
/*
    if (video.coverUrl ) {

        cell.HHUIImage =[UIImage imageNamed: @"jiazai" ];

        UIImage *image = [self.images objectForKey:video.coverUrl];
        if (image) {
            cell.HHUIImage = image;
            NSLog(@"----%zd--内存缓存---",indexPath.row);
        }else
        {


            //获得图片名称，不能包含
            NSString *fileName = [video.coverUrl lastPathComponent];
            //拼接图片的全路径
            NSString *fullPath = [caches stringByAppendingPathComponent:fileName ];



            //检查磁盘缓存
            NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
            //            imageData = nil;
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                cell.HHUIImage = image;
                NSLog(@"----%zd--磁盘缓存---",indexPath.row);
                //保存到内存缓存
                [self.images setObject:image forKey:video.coverUrl];
            }else{
                //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];

                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSLog(@"----%zd--下载---",indexPath.row);
                    NSURL *url = [NSURL URLWithString:video.coverUrl];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:imageData];




                    //保存到内存缓存
                    [self.images setObject:image forKey:video.coverUrl];


                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];

                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                        cell.HHUIImage = image;
                        [self.tableView  rectForRowAtIndexPath:indexPath];

                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];


            }
        }
        return cell;
    }
*/
    
    
    return cell;
    
    
    
}






// 设置 cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    HHVideoModel *video = self.newsArray[indexPath.row];
    
    return [UIScreen mainScreen].bounds.size.width*0.618+70 ;
}




@end
