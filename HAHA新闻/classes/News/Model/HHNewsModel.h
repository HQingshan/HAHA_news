//
//  HHNewsModel.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/12.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHNewsModel : NSObject



@property (nonatomic,copy)NSString *posterId;
@property (nonatomic,copy)NSNumber *publishDate;
@property (nonatomic,copy)NSString *publishDateStr;
@property (nonatomic,copy)NSString *posterScreenName;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *tags;
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *shareCount;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSArray  *imageUrls;
@property (nonatomic,copy)NSString *likeCount;


+(instancetype)newsWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
