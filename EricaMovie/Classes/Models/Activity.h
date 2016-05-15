//
//  Activity.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Activity : NSObject

@property (nonatomic,strong) UIImage *activityImage;
@property (nonatomic,assign) BOOL isDownloading;

- (void)loadImage;

@property (nonatomic,copy) NSString *image;//图片
@property (nonatomic,copy) NSString *title;//活动标题
@property (nonatomic,copy) NSString *begin_time;//开始时间
@property (nonatomic,copy) NSString *end_time;//结束时间
@property (nonatomic,copy) NSString *address;//地点
@property (nonatomic,copy) NSString *category_name;//活动类型
@property (nonatomic,copy) NSString *name;//主办方
@property (nonatomic,copy) NSString *content;//详情
@property (nonatomic,copy) NSNumber *wisher_count;//感兴趣人数
@property (nonatomic,copy) NSNumber *participant_count;//参加人数
@property (nonatomic,copy) NSDictionary *owner;

@end
