//
//  ActivityInfoView.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "ActivityInfoView.h"

@implementation ActivityInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor whiteColor];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:kTableView_Rect];
    _scrollView.alwaysBounceVertical = YES;
    [self addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc]initWithFrame:kTableView_Rect];
    [self.scrollView addSubview:_contentView];
    
    self.scrollView.contentSize = self.contentView.frame.size;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.contentView.frame.size.width - 20, 50)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.layer.cornerRadius = 5;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.text = @"罗马巴洛克艺术";
    _titleLabel.font = [UIFont systemFontOfSize:25];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height - 5, self.titleLabel.frame.size.width, 3)];
    line.backgroundColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:line];
    
 
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 10, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width - 20, 20)];
    _timeLabel.text = @"2015-2-2 -- 2015-3-14";
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.imageGroundView = [[UIView alloc]initWithFrame:CGRectMake(8, self.timeLabel.frame.size.height + self.timeLabel.frame.origin.y + 10, self.contentView.frame.size.width - 16, 168)];
    
    _imageGroundView.backgroundColor = kMainTitleBackgroundColor;
    _imageGroundView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageGroundView];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(self.imageGroundView.frame.origin.x, self.imageGroundView.frame.origin.y + self.imageGroundView.frame.size.height + 15, self.imageGroundView.frame.size.width, 3)];
    line2.backgroundColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:line2];
    
    self.ownerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, line2.frame.size.height + line2.frame.origin.y + 10, self.titleLabel.frame.size.width / 2, 21)];
    _ownerLabel.text = @"国家博物馆";
    _ownerLabel.font = [UIFont systemFontOfSize:15];
    _ownerLabel.textColor = [UIColor grayColor];
    _ownerLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.ownerLabel];
    
    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.ownerLabel.frame.origin.x + self.ownerLabel.frame.size.width, self.ownerLabel.frame.origin.y, self.ownerLabel.frame.size.width, self.ownerLabel.frame.size.height)];
    _typeLabel.text = @"类型：展览";
    _typeLabel.font = [UIFont systemFontOfSize:15];
    _typeLabel.textColor = [UIColor grayColor];
    _typeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeLabel];
    
    
    self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.ownerLabel.frame.origin.y + self.ownerLabel.frame.size.height, self.titleLabel.frame.size.width, self.ownerLabel.frame.size.height)];
    _locationLabel.font = [UIFont systemFontOfSize:15];
    _locationLabel.text = @"北京市，海淀区，清河，金五星大厦";
    _locationLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.locationLabel];
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(line.frame.origin.x, self.locationLabel.frame.size.height + self.locationLabel.frame.origin.y + 10, line.frame.size.width, line.frame.size.height)];
    line3.backgroundColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:line3];
    
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + 10, line3.frame.origin.y + line3.frame.size.height + 10, self.titleLabel.frame.size.width - 20, 20)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.layer.cornerRadius = 5;
    _contentLabel.backgroundColor = kMainTitleBackgroundColor;
    _contentLabel.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.contentLabel];
    
    
}

- (void)setContent:(NSString *)content{
    
    CGSize maxSize = CGSizeMake(_contentLabel.frame.size.width, 3000);
    NSDictionary *dic = @{NSFontAttributeName:_contentLabel.font};
    
    CGRect frame = [content boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    _contentLabel.text = content;
    _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, frame.size.width, frame.size.height);
    if (_contentLabel.frame.size.height + _contentLabel.frame.origin.y >= self.contentView.frame.size.height) {
        
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height + _contentLabel.frame.size.height + _contentLabel.frame.origin.y - self.contentView.frame.size.height + 10);
        
        self.scrollView.contentSize = self.contentView.frame.size;
        
    }
    
}

- (void)loadData{
    
}

- (void)setImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    if (imageView.frame.size.width != 0 && imageView.frame.size.height != 0) {
        
        CGFloat scale1 = _imageGroundView.frame.size.width / imageView.frame.size.width;
        CGFloat scale2 = _imageGroundView.frame.size.height / imageView.frame.size.height;
        CGFloat scale = scale1 > scale2 ? scale1 : scale2;
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width * scale, imageView.frame.size.height * scale);
        imageView.center = CGPointMake(_imageGroundView.frame.size.width / 2, _imageGroundView.frame.size.height / 2);
        [_imageGroundView insertSubview:imageView atIndex:0];
        
    }
    
}

@end
