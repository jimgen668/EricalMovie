//
//  ActivityInfoView.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInfoView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *imageGroundView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *ownerLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UIImage *image;//请从此设置图片
@property (nonatomic,strong) NSString *content;//请从此设置简介内容
@property (nonatomic,strong) NSString *title;//设置标题
@property (nonatomic,strong) NSString *time;//时间
@property (nonatomic,strong) NSString *ownerName;//组织者
@property (nonatomic,strong) NSString *type;//类型
@property (nonatomic,strong) NSString *location;//地址;


- (void)loadData;
@end
