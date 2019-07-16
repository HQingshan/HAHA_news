//
//  HHNewsModel.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/12.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHNewsModel.h"

@implementation HHNewsModel



+(instancetype)newsWithDict:(NSDictionary *)dict;
{
    HHNewsModel *news = [[self alloc] init];
    [news setValuesForKeysWithDictionary:dict];
//    const.country =dict[@"country"];
//    news.title =dict[@"title"];
//    news.imageUrls =dict[@"imageUrls"];
//    news.posterScreenName =dict[@"posterScreenName"];
//    news.publishDateStr =dict[@"publishDateStr"];
//    news.content =dict[@"content"];
//    news.id =dict[@"id"];
    return news;
    
}

@end
