//
//  AppDelegate.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/7.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

//-(void)get
//{
//    
//    // 1.创建url
//    
//    NSURL *url=[NSURL  URLWithString:@"http://api01.idataapi.cn:8000/video/toutiao?kw=%E8%A7%86%E9%A2%91&pageToken=1&apikey=x4ILKXqZ0HiAU1SPzeV0Gjw6dkSn0gBcWpTVfGfV0xvE4QmCu3yu3p2orvs9iiRX"];
//    
//    
//    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
//    NSURLRequest *request = [NSURLRequest requestWithURL:url  ];
//    
//    // 3.采用苹果提供的共享session
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    // 4.由系统直接返回一个dataTask任务
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        
//    }];
//    
//    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
//    [dataTask resume];
//    
//}


//-(void)get
//{
//
//    // 1.创建url
//
//    NSURL *url=[NSURL  URLWithString:@"http://api01.idataapi.cn:8000/news/qihoo?kw=%3F&site=qq.com&apikey=x4ILKXqZ0HiAU1SPzeV0Gjw6dkSn0gBcWpTVfGfV0xvE4QmCu3yu3p2orvs9iiRX"];
//
//
//    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
//    NSURLRequest *request = [NSURLRequest requestWithURL:url  ];
//
//    // 3.采用苹果提供的共享session
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    // 4.由系统直接返回一个dataTask任务
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSDictionary *temp =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//        self.fileData = temp[@"data"];
//
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//
//    }];
//
//    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
//    [dataTask resume];
//}
