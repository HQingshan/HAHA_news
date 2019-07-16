//
//  HHNewsTableView.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/16.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNewsTableView.h"
#import "HHFooterView.h"
#import "HHHeaderView.h"

#import "HHNewsModel.h"

#import "HHNew_p0_TableViewCell.h"
#import "HHNew_p1_TableViewCell.h"
#import "HHNew_p3_TableViewCell.h"

#import "HHRotationTableViewCell.h"

int page=1;

@interface  HHNewsTableView ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDataDelegate>


/**  内存缓存图片  */
@property (nonatomic, strong) NSMutableDictionary *images;

@property (nonatomic, strong) NSMutableArray *fileData;

@property (nonatomic, strong) NSMutableArray *newsArray;

/*   队列   */
@property (nonatomic, strong) NSOperationQueue *queue;


@end


@implementation HHNewsTableView

- (void)drawRect:(CGRect)rect {
    //  定时刷新
    NSTimer  *timer  =  [NSTimer scheduledTimerWithTimeInterval:600.0 target:self selector:@selector(timeIntervalSinceReferenceDate) userInfo:nil repeats:YES];
    
    self.delegate = self;
    self.dataSource = self;
    
    
    [self setupRefresh];
    
    
    self.autoresizesSubviews = NO ;
    
    
    [self setContentOffset:CGPointMake(0, -20) animated:YES];
    
    
     [timer invalidate];
}
//  定时刷新
- (void)timeIntervalSinceReferenceDate{
//     NSLog(@"------- 定时刷新触发");
//    [self refreshClick: self.refreshControl ];
    [self setContentOffset:CGPointMake(0, -50) animated:YES];
}

// 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];

    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:refreshControl];
    self.refreshControl = refreshControl;
    self.refreshControl.tintColor = [UIColor clearColor];

    [self refreshClick: refreshControl ];
    
    
    
    HHHeaderView *refreshHHHeaderView = [HHHeaderView refreshHeaderView];
    refreshHHHeaderView.hidden = NO;
    self.tableHeaderView = refreshHHHeaderView;
}


// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
     [refreshControl endRefreshing];
    HHHeaderView *refreshHHHeaderView = [HHHeaderView refreshHeaderView];
    refreshHHHeaderView.hidden = NO;
    self.tableHeaderView = refreshHHHeaderView;    NSLog(@"refreshClick: -- 刷新触发");
    page = 1;
    
    NSString *urlStr = [NSString stringWithFormat: @"http://api01.idataapi.cn:8000/news/qihoo?kw=%@&site=qq.com&pageToken=%i&apikey=T4hYohaiaDqdgeFA6R3osirDKh9zgQF4pX1SgT3gmkUIAWbGgKZXg5HKsCOZhBHC",self.channel,page];
    
    urlStr=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 1. url
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    //3.创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //4.创建Task
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request];
    
    //5.执行Task
    [datatask resume];
    
    
    


    self.refreshControl.hidden = YES;
    [self reloadData];// 刷新tableView即可
    
}


// 创建上拉刷新控件
- (void)setupUpRefresh
{
    NSLog(@"refreshClick: -- 上拉刷新创建");
    HHFooterView *refreshHHFooterView = [HHFooterView refreshFooterView];
    refreshHHFooterView.hidden = YES;
    self.tableFooterView = refreshHHFooterView;
}

#pragma mark UIScrollView Delegate
// 上拉刷新触发，在此获取数据
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 获取当前contentView滑动的位置(对应contentSize)
    CGFloat contenOffsetY = scrollView.contentOffset.y;
    
    // 如果tableView还没有数据或HHfooterView在显示时, 直接返回
    if ( self.tableFooterView.hidden == NO || self.fileData.count == 0)
    {
        return;
    }
    
    // 最后一个Cell显示时contentOffSetY应该在的最小位置(内容高度 + 边框 - 显示窗口高度 - footrerView高度)
    CGFloat targetContentOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - [UIScreen mainScreen].bounds.size.height - 35;
    
    // 若滑动位置在目标位置下(显示到最后一个Cell)时
    if (contenOffsetY >= targetContentOffsetY)
    {
        // 显示HHfooterView
        self.tableFooterView.hidden = NO;
        
        // 加载更多数据
        [self loadMoreDatas];
    }
}
//  加载后续数据
- (void) loadMoreDatas{
    
    
    NSLog(@"refreshClick: -- 上拉刷新触发");
    
/**
 
    dispatch_after   能让我们添加进队列的任务延时执行，该函数并不是在指定时间后执行处理，而只是在指定时间追加处理到dispatch_queu
 
    DISPATCH_TIME_NOW 表示现在，NSEC_PER_SEC 表示的是秒数，它还提供了 NSEC_PER_MSEC 表示毫秒
    该方法的第一个参数是 time，第二个参数是 dispatch_queue，第三个参数是要执行的block。
 */
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *urlStr = [NSString stringWithFormat: @"http://api01.idataapi.cn:8000/news/qihoo?kw=%@&site=qq.com&pageToken=%i&apikey=T4hYohaiaDqdgeFA6R3osirDKh9zgQF4pX1SgT3gmkUIAWbGgKZXg5HKsCOZhBHC",self.channel,page];
        
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
            for (NSDictionary *newsdict in dictArray) {
                //                NSLog(@"----***--%@--**----",newsdict);
                [self.fileData addObject:newsdict ];
                [self.newsArray addObject:[HHNewsModel newsWithDict:newsdict]];
            }
//            NSLog(@"----***--%zd--**----",self.fileData.count);

            page ++;
            //        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
        }];
        
        // 5.每一个任务默认都是挂起的，需要调用 resume 方法
        [dataTask resume];

        
        // 刷新表格。 ？
        [self reloadData];
        
        // 结束刷新状态, 隐藏HHFooterView
        self.tableFooterView.hidden = YES;
        
    });
    
   
}


#pragma mark - NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
//    NSLog(@"----*********----");
    completionHandler(NSURLSessionResponseAllow);
    
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    // 4.将得到数据进行返序列化
    NSDictionary *temp =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSLog(@"----***--%@--**----",temp);
    if (temp != nil) {
//        NSLog(@"----***--%@--**----",temp);
        if (page == 1) {
            NSArray *dictArray =temp[@"data"];
            self.fileData = [[NSMutableArray alloc]init];
            for (NSDictionary *newsdict in dictArray) {
                [self.fileData addObject:newsdict ];
        }
            page ++;
        }
    }
NSLog(@"----***--%i--**----",page);
    
}
//当申请数据加载结束时
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
    self.tableHeaderView.hidden = YES;
    self.tableHeaderView = nil;
    [self reloadData];
//    page ++;
    if (page == 2 && self.fileData != nil ) {
        [self setupUpRefresh];
    }

}

-(NSMutableDictionary *)images{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
    
}

- (NSMutableArray *)newsArray
{
    if (!_newsArray){
        NSArray *dictArray =self.fileData;
        //        NSLog(@"-----%@--------",[dictArray  valueForKey: @"rate" ][0]   );
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSDictionary *newsdict in dictArray) {
            [temp addObject:[HHNewsModel newsWithDict:newsdict]];
        }
        _newsArray = temp;
    }
    return _newsArray;
}


-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue  = [[NSOperationQueue alloc]init];
        //最大bing并发数
        _queue.maxConcurrentOperationCount = 5;
    }
    
    return _queue;
}



// 每个 Section 中的 Cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"******%zd******",self.fileData.count);
    
    return self.fileData.count;
    
}



// 设置每个 Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHNewsModel *new = self.newsArray[indexPath.row];
    //保存图片的名称到沙盒缓存
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES)lastObject] ;
    
//    #import "HHRotationTableViewCell.h"
    if ([self.channel isEqualToString:@"新闻"]) {
        if (indexPath.row == 0) {
            
            // 创建一个cellID，用于cell的重用
            NSString *ROcellID = @"ROcellID";
            // 从tableview的重用池里通过cellID取一个cell
            HHRotationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ROcellID];
            if (cell == nil) {
                // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
                cell = [[HHRotationTableViewCell alloc] init];
                NSMutableArray *temp = [[NSMutableArray alloc] init];
                NSMutableDictionary *tempimage = [NSMutableDictionary dictionary];

                for (int i = 0; temp.count <= 5; i++) {
                    
                    HHNewsModel *new = self.newsArray[i+1];
                    if ( new.imageUrls ) {
                        
                        [temp addObject:self.fileData[i+1] ];
                        
                        UIImage *image = [self.images objectForKey:new.imageUrls[0]];
                        if (image) {
                            
                             [tempimage setObject:image forKey: new.imageUrls[0]];
                        }
                    }
                }
                cell.images = tempimage;
                cell.news = temp ;
                [cell setNews:temp];
                [cell setImages:tempimage];
            }
            
            return cell;
        }

        
    }
    
    
    if (new.imageUrls.count >= 3) {
        // 创建一个cellID，用于cell的重用
        NSString *P3cellID = @"P3cellID";
        // 从tableview的重用池里通过cellID取一个cell
        HHNew_p3_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:P3cellID];
        if (cell == nil) {
            // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
            cell = [[HHNew_p3_TableViewCell alloc] init];
        }
        cell.HHUIImage3 =cell.HHUIImage2 =cell.HHUIImage1 = [UIImage imageNamed: @"jiazai" ];
        [cell setNews:new];
        
        
        
        UIImage *image1 = [self.images objectForKey:new.imageUrls[0]];
        if (image1) {
            cell.HHUIImage1 = image1;
            NSLog(@"----%zd--内存缓存---",indexPath.row);
        }else
        {

            //获得图片名称，不能包含
            NSString *fileName = [new.imageUrls[0] lastPathComponent];
            //拼接图片的全路径
            NSString *fullPath = [caches stringByAppendingPathComponent:fileName ];
            
            
            
            //检查磁盘缓存
            NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
            //            imageData = nil;
            if (imageData) {
                UIImage *image1 = [UIImage imageWithData:imageData];
                cell.HHUIImage1 = image1;
                NSLog(@"----%zd--磁盘缓存---",indexPath.row);
                
                //保存到内存缓存
                [self.images setObject:image1 forKey:new.imageUrls[0]];
            }else{
                //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];
                
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSLog(@"----%zd--下载---",indexPath.row);
                    NSURL *url = [NSURL URLWithString:new.imageUrls[0]];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image1 = [UIImage imageWithData:imageData];
                    
                    
                    
                    
                    //保存到内存缓存
                    [self.images setObject:image1 forKey:new.imageUrls[0]];
                    
                    
                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        cell.HHUIImage1 = image1;
                        [self  rectForRowAtIndexPath:indexPath];
                       
                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];
                
                
            }
        }
        
        
        
        UIImage *image2 = [self.images objectForKey:new.imageUrls[1]];
        if (image2) {
            cell.HHUIImage2 = image2;
            NSLog(@"----%zd--内存缓存---",indexPath.row);
        }else
        {

//            *********************************
            
            
            //获得图片名称，不能包含
            NSString *fileName = [new.imageUrls[1] lastPathComponent];
            //拼接图片的全路径
            NSString *fullPath = [caches stringByAppendingPathComponent:fileName ];
            
            
            
            //检查磁盘缓存
            NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
            //            imageData = nil;
            if (imageData) {
                UIImage *image2 = [UIImage imageWithData:imageData];
                cell.HHUIImage2 = image2;
                NSLog(@"----%zd--磁盘缓存---",indexPath.row);
                //保存到内存缓存
                [self.images setObject:image2 forKey:new.imageUrls[1]];
            }else{
                //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];
                
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSLog(@"----%zd--下载---",indexPath.row);
                    NSURL *url = [NSURL URLWithString:new.imageUrls[1]];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image2 = [UIImage imageWithData:imageData];
                    
                    
                    
                    
                    //保存到内存缓存
                    [self.images setObject:image2 forKey:new.imageUrls[1]];
                    
                    
                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        cell.HHUIImage2 = image2;
                        [self  rectForRowAtIndexPath:indexPath];
                        
                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];
                
                
            }
        }
        
        
        
        UIImage *image3 = [self.images objectForKey:new.imageUrls[2]];
        if (image3) {
            cell.HHUIImage3 = image3;
            NSLog(@"----%zd--内存缓存---",indexPath.row);
        }else
        {

//            ***************************
            
            //获得图片名称，不能包含
            NSString *fileName = [new.imageUrls[0] lastPathComponent];
            //拼接图片的全路径
            NSString *fullPath = [caches stringByAppendingPathComponent:fileName ];
            
            
            
            //检查磁盘缓存
            NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
            //            imageData = nil;
            if (imageData) {
                UIImage *image3 = [UIImage imageWithData:imageData];
                cell.HHUIImage3 = image3;
                NSLog(@"----%zd--磁盘缓存---",indexPath.row);
                //保存到内存缓存
                [self.images setObject:image3 forKey:new.imageUrls[2]];
            }else{
                //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];
                
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSLog(@"----%zd--下载---",indexPath.row);
                    NSURL *url = [NSURL URLWithString:new.imageUrls[2]];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image3 = [UIImage imageWithData:imageData];
                    
                    
                    
                    
                    //保存到内存缓存
                    [self.images setObject:image3 forKey:new.imageUrls[2]];
                    
                    
                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        cell.HHUIImage3 = image3;
                        [self  rectForRowAtIndexPath:indexPath];
                        
                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];
                
                
            }
        }
        
        return cell;
    }
    
    
    
    
    if (new.imageUrls) {
        // 创建一个cellID，用于cell的重用
        NSString *P1cellID = @"P1cellID";
        // 从tableview的重用池里通过cellID取一个cell
        HHNew_p1_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:P1cellID];
        if (cell == nil) {
            // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
            cell = [[HHNew_p1_TableViewCell alloc] init];
        }
        cell.HHUIImage =[UIImage imageNamed: @"jiazai" ];
        [cell setNews:new];
        
        UIImage *image = [self.images objectForKey:new.imageUrls[0]];
        if (image) {
            cell.HHUIImage = image;
            NSLog(@"----%zd--内存缓存---",indexPath.row);
        }else
        {
            

            //获得图片名称，不能包含
            NSString *fileName = [new.imageUrls[0] lastPathComponent];
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
                [self.images setObject:image forKey:new.imageUrls[0]];
            }else{
                //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];
                
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSLog(@"----%zd--下载---",indexPath.row);
                    NSURL *url = [NSURL URLWithString:new.imageUrls[0]];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    
                    
                    
                    //保存到内存缓存
//                    [self.images setObject:image forKey: new.imageUrls[0] ];
                    
                    
                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        cell.HHUIImage = image;
                        [self  rectForRowAtIndexPath:indexPath];
                        
                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];
                
                
            }
        }
        return cell;
    }
    
    
    
    
    // 创建一个cellID，用于cell的重用
    NSString *P0cellID = @"P0cellID";
    // 从tableview的重用池里通过cellID取一个cell
    HHNew_p0_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:P0cellID];
    if (cell == nil) {
        // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
        cell = [[HHNew_p0_TableViewCell alloc] init];
    }
    [cell setNews:new];
    
    
    
    
    
    
    return cell;
    
    
    
}




// 设置 cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHNewsModel *new = self.newsArray[indexPath.row];
    
    if ([self.channel isEqualToString:@"新闻"]) {
        if (indexPath.row == 0) {

            return [UIScreen mainScreen].bounds.size.width*0.618 ;
        }
        
        
    }
    
    
    if (new.imageUrls.count ==0 ){
        return 78;
    }
    if (new.imageUrls.count >= 3 ){
        return 152;
    }
    
    return 95;
}


// 选中了 cell 时触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if ([self.channel isEqualToString:@"新闻"]) {
        if (indexPath.row == 0) {
            
            return  ;
        }
        
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADD" object: self.fileData[indexPath.row] ];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Web" object: self.fileData[indexPath.row] ];

}


@end
