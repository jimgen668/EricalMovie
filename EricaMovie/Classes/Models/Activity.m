//
//  Activity.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "Activity.h"
#import "LakeImageDownloader.h"

@implementation Activity

- (void)loadImage{
    
    [LakeImageDownloader imageDownloaderDownloadImageWithURLString:self.image complitImage:^(UIImage *image) {
        self.activityImage = image;
        _isDownloading = NO;
    }];
    _isDownloading = YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
