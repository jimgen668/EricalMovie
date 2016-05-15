//
//  ActivityCell.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/23.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErCustomImageView.h"
@class Activity;

@interface ActivityCell : UITableViewCell

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) Activity *activity;

@end
