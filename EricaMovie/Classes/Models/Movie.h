//
//  Movie.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/26.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic,strong) UIImage *movieImage;
@property (nonatomic,assign) BOOL isDownloading;
- (void)loadImage;

@property (nonatomic,strong) NSString *movieId;
@property (nonatomic,strong) NSString *movieName;
@property (nonatomic,strong) NSString *pic_url;


@end
