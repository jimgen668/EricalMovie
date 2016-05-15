//
//  MovieInfoViewController.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/27.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieInfo.h"

@interface MovieInfoViewController : UIViewController

@property (nonatomic,strong) Movie *movie;
@property (nonatomic,strong) MovieInfo *movieInfo;

@end
