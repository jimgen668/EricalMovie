//
//  MovieTableView.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "MovieTableView.h"

@implementation MovieTableView

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
    self.tableView = [[UITableView alloc]initWithFrame:kTableView_Rect style:(UITableViewStylePlain)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor blackColor];
    [self addSubview:_tableView];
    
    
}

@end
