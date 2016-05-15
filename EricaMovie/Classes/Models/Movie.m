//
//  Movie.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/26.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (void)loadImage{
        [LakeImageDownloader imageDownloaderDownloadImageWithURLString:self.pic_url complitImage:^(UIImage *image) {
            self.movieImage = image;
            _isDownloading = NO;
        }];
        _isDownloading = YES;
}

@end
