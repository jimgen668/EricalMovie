//
//  ErCustomImageView.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "ErCustomImageView.h"

@implementation ErCustomImageView

+ (ErCustomImageView *)erCustomImageViewAlloc{

    ErCustomImageView *er = [[ErCustomImageView alloc]init];
//    NSLog(@"%@",er);
    return er;
    
}
- (void)setImage:(UIImage *)image{
    NSLog(@"%@",image);
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeImage:)]) {
        [_delegate didChangeImage:image];
    }
    
}
//
//- (void)setErImage:(UIImage *)erImage{
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(didChangeImage:)]) {
//        [_delegate didChangeImage:erImage];
//    }
//    
//}



@end
