//
//  HHNewsdetailsTableViewController.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/21.
//  Copyright © 2019 你好帅！. All rights reserved.
//
#import "HHNewdetailTableViewCell.h"
#import "HHNewsdetailsTableViewController.h"
#import "HHNewsModel.h"

#define ScrW [UIScreen mainScreen].bounds.size.width
@interface HHNewsdetailsTableViewController ()

/**  内存缓存图片  */
@property (nonatomic, strong) NSMutableDictionary *images;

/*   队列   */
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation HHNewsdetailsTableViewController


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
        _queue.maxConcurrentOperationCount = 4;
    }
    
    return _queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻详情";
    
//    self.view.backgroundColor = [UIColor blueColor];
}




#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHNewsModel *new = [HHNewsModel newsWithDict: self.newdict ];
    //保存图片的名称到沙盒缓存
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES)lastObject] ;
    
    
    //       获取重用池中的cell
    static NSString *IDCell = @"IDCell";
    HHNewdetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    //       如果没有取到,就初始化
    if (!cell)
    {
        cell = [[HHNewdetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    [cell setNews:new];
    
    
    
    if (new.imageUrls) {
        cell.image_1 =[UIImage imageNamed: @"jiazai" ];
        [cell setNews:new];
        
        UIImage *image = [self.images objectForKey:new.imageUrls[0]];
        if (image) {
            cell.image_1 = image;
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
                cell.image_1 = image;
                [cell setImage_1:image];
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
                    [self.images setObject:image forKey:new.imageUrls[0]];
                    
                    
                    //写数据到沙盒l
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //现成间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        cell.image_1 = image;
                        [cell setImage_1:image];
                        [self.tableView reloadData];
                        
                    }];
                }];
                //添加操作到队列中
                [self.queue addOperation:download];
                
                
            }
        }
        
    }
    
    
    
    
        for (int i = 0; i<new.imageUrls.count ; i++) {
            UIImage *image = [self.images objectForKey:new.imageUrls[i]];
            if (image) {
            }else
            {
                //获得图片名称，不能包含
                NSString *fileName = [new.imageUrls[i] lastPathComponent];
                //拼接图片的全路径
                NSString *fullPath = [caches stringByAppendingPathComponent:fileName ];
                
                
                
                //检查磁盘缓存
                NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
                //            imageData = nil;
                if (imageData) {
                    UIImage *image = [UIImage imageWithData:imageData];


                    NSLog(@"----%zd--磁盘缓存---",indexPath.row);
                    //保存到内存缓存
                    [self.images setObject:image forKey:new.imageUrls[i]];
                }else{
                    //                NSOperationQueue *queue =[[NSOperationQueue alloc]init];
                    
                    NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                        NSLog(@"----%zd--下载---",indexPath.row);
                        NSURL *url = [NSURL URLWithString:new.imageUrls[i]];
                        NSData *imageData = [NSData dataWithContentsOfURL:url];
                        UIImage *image = [UIImage imageWithData:imageData];
                        
                        
                        //保存到内存缓存
                        [self.images setObject:image forKey:new.imageUrls[i]];
                        
                        
//                        //写数据到沙盒l
//                        [imageData writeToFile:fullPath atomically:YES];
                        
                        //现成间通信
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                            [self.tableView reloadData];
                            
                        }];
                    }];
                    //添加操作到队列中
                    [self.queue addOperation:download];
                    
                }
            }
            NSMutableDictionary *Otherimages = [[NSMutableDictionary alloc]init];
            Otherimages =  self.images  ;
            [cell  setOtherimages: Otherimages ];
            NSLog(@"----------%zd--------",self.images.count);
            NSLog(@"----------%zd--------",Otherimages.count);
            
        }
    
    
    
    
    
    return cell;
}



// 设置 cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHNewsModel *new = [HHNewsModel newsWithDict: self.newdict ];
    
    NSDictionary *teatAtt = @{NSFontAttributeName : [UIFont systemFontOfSize:15 ]};
    CGSize textSize = CGSizeMake(ScrW -20, MAXFLOAT);
    CGFloat textH = [new.content boundingRectWithSize:textSize options: NSStringDrawingUsesLineFragmentOrigin attributes: teatAtt context:nil].size.height;
    CGFloat cell_H = (ScrW*0.618+10)*new.imageUrls.count+textH+10 ;
    
    return cell_H;
    
}


// 选中了 cell 时触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView reloadData];
    
}


@end
