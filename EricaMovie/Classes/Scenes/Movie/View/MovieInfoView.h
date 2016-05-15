//
//  MovieInfoView.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/27.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieInfoView : UIView

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIVisualEffectView *moveContentView;

@property (nonatomic,strong) UIImage *image;//图片
@property (nonatomic,copy) NSString *score;//评分
@property (nonatomic,copy) NSString *commentary;//评论数
@property (nonatomic,copy) NSString *releaseDate;//上映日期
@property (nonatomic,copy) NSString *runTime;//持续时间
@property (nonatomic,copy) NSString *genres;//类型
@property (nonatomic,copy) NSString *filmLocations;//国家
@property (nonatomic,copy) NSString *actors;//演员
@property (nonatomic,copy) NSString *plotSimple;


//@property (nonatomic,copy) NSString *plot_simple;//简介
//@property (nonatomic,copy) NSString *title;//电影名字
//@property (nonatomic,copy) NSString *genres;//分类
//@property (nonatomic,copy) NSString *country;//国家
//@property (nonatomic,copy) NSString *runtime;//时间
//@property (nonatomic,copy) NSString *poster;//图片
//@property (nonatomic,copy) NSString *rating_count;//评论人数
//@property (nonatomic,copy) NSString *rating;//评分
//@property (nonatomic,copy) NSString *release_date;//上映信息
//@property (nonatomic,copy) NSString *actors;//制作人信息

@end
