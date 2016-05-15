//
//  MovieTableViewCell.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) Movie *movie;

@end
