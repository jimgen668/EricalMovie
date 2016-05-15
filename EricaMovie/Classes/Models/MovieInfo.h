//
//  MovieInfo.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/27.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject

@property (nonatomic,copy) NSString *plot_simple;//简介
@property (nonatomic,copy) NSString *title;//电影名字
@property (nonatomic,copy) NSString *genres;//分类
@property (nonatomic,copy) NSString *country;//国家
@property (nonatomic,copy) NSString *runtime;//时间
@property (nonatomic,copy) NSString *poster;//图片
@property (nonatomic,copy) NSString *rating_count;//评论人数
@property (nonatomic,copy) NSString *rating;//评分
@property (nonatomic,copy) NSString *release_date;//上映信息
@property (nonatomic,copy) NSString *actors;//制作人信息

@end
