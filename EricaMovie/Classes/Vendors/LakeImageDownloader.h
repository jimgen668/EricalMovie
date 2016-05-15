//
//  LakeImageDownloader.h
//  lesson_17
//
//  Created by LakesMac on 15/9/23.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LakeImageDownloaderDelegate;
@interface LakeImageDownloader : NSObject

@property (nonatomic,strong) id<LakeImageDownloaderDelegate> delegate;

//同步下载
+ (UIImage *)imageDownloaderDownloadImageWithURLString:(NSString *)imageURL;

//block
+ (void)imageDownloaderDownloadImageWithURLString:(NSString *)imageURL complitImage:(void(^)(UIImage *image))block;

//代理
+ (void)DownloadImageWithURLString:(NSString *)imageURL delegate:(id<LakeImageDownloaderDelegate>)delegate;

@end
@protocol LakeImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinishDownloadImage:(UIImage *)image;

@end