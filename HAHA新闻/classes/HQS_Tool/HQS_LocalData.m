//
//  HQS_LocalData.m
//  HAHA新闻
//
//  Created by 你好帅 on 2019/7/18.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HQS_LocalData.h"

@implementation HQS_LocalData

//将oc数组 ArrayDete 转为json存在本地Documents 名为Name
+ (BOOL)OCArray: (NSArray *)ArrayDete  writeToDocumentsJSONFileName:(NSString *)Name;
{
    // 加载全路径
    NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    [NSString stringWithFormat: @"%@.json",Name];
    NSString *filePath =  [Documents stringByAppendingPathComponent:[NSString stringWithFormat: @"%@.json",Name] ];
    // 数组转JSON数据
    NSData *tempData = [NSJSONSerialization  dataWithJSONObject:ArrayDete  options:NSJSONWritingPrettyPrinted  error:nil];
    //NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    // 写入数据
    
    return  [tempData  writeToFile:filePath atomically:YES];
}
//将存在本地Documents 名为Name的json文件读取 转为oc数组
+ (nullable id)OCArrayBeReadfromDocumentsJSONFileName:(NSString *)Name;
{
    // 获取文件路径
    NSString *Documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath =  [Documents stringByAppendingPathComponent:[NSString stringWithFormat: @"%@.json",Name] ];
    
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    
    if (data == NULL) {
        return [[NSMutableArray alloc]init];
    }else{
        // 将json数据转数组
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in dictArray) {
            [temp addObject:dict];
        }
       return  temp;
    }
    
    
}

@end
