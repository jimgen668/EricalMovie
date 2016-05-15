//
//  LakeImageDownloader.m
//  lesson_17
//
//  Created by LakesMac on 15/9/23.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "LakeImageDownloader.h"


@implementation LakeImageDownloader

+ (UIImage *)imageDownloaderDownloadImageWithURLString:(NSString *)imageURL{
    //根据传递进来的网址创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    //获得请求到的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (!data) {
        return nil;
    }
    //生成图片并返回
    return [UIImage imageWithData:data];
}

+ (void)imageDownloaderDownloadImageWithURLString:(NSString *)imageURL complitImage:(void (^)(UIImage *))block{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            return ;
        }
        UIImage *image = [UIImage imageWithData:data];
        block(image);
    }];
}

+ (void)DownloadImageWithURLString:(NSString *)imageURL delegate:(id<LakeImageDownloaderDelegate>)delegate{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        
        if (delegate && [delegate respondsToSelector:@selector(imageDownloaderDidFinishDownloadImage:)]) {
            
            [delegate imageDownloaderDidFinishDownloadImage:image];
        }
    }];
    
}

@end
