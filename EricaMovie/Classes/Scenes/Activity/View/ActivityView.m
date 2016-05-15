//
//  ActivityView.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/23.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

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
    [self addSubview:_tableView];

//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(60, 60, 100, 100)];
//    view.backgroundColor = [UIColor yellowColor];
//    view.layer.shadowOpacity = 4;
//    [self addSubview:view];
    
    
    
    
    
    
}

@end
