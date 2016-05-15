//
//  MovieCollectionViewCell.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) Movie *movie;

@end
