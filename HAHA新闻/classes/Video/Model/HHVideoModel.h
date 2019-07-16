//
//  HHVideoModel.h
//  HAHA新闻
//
//  Created by 你好帅！ on 2019/5/22.
//  Copyright © 2019 你好帅！. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHVideoModel : NSObject

@property (nonatomic,copy)NSNumber  *commentCount;
@property (nonatomic,copy)NSString  *content;
@property (nonatomic,copy)NSString  *coverUrl;
@property (nonatomic,copy)NSString  *Description;
@property (nonatomic,copy)NSString  *posterScreenName ;
@property (nonatomic,copy)NSNumber  *id;
@property (nonatomic,copy)NSString  *publishDateStr;
@property (nonatomic,copy)NSNumber  *publishDate;
@property (nonatomic,copy)NSString  *shareCount;
@property (nonatomic,copy)NSString  *title;
@property (nonatomic,copy)NSString  *url;
@property (nonatomic,copy)NSString  *viewCount;



+(instancetype)videoWithDict:(NSDictionary *)dict;





@end

NS_ASSUME_NONNULL_END
