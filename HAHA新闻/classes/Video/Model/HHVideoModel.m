//
//  HHVideoModel.m
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/22.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import "HHVideoModel.h"

@implementation HHVideoModel



+(instancetype)videoWithDict:(NSDictionary *)dict
{
    HHVideoModel *video = [[self alloc] init];
//    [video setValuesForKeysWithDictionary: dict ];
    //    const.country =dict[@"country"];
    video.commentCount = dict[@"commentCount"];
    video.title = dict[@"title"];
    video.url = dict[@"title"];
    video.coverUrl = dict[@"coverUrl"];
    video.Description = dict[@"description"];
    video.posterScreenName =dict[@"posterScreenName"];
    video.publishDateStr =dict[@"publishDateStr"];
    return video;
    
}




@end
