//
//  ErCustomImageView.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErCustomImageViewDelegate;
@interface ErCustomImageView : UIImageView

@property (nonatomic,assign) id<ErCustomImageViewDelegate> delegate;
@property (nonatomic,strong) UIImage *erImage;

+ (ErCustomImageView *)erCustomImageViewAlloc;

@end

@protocol ErCustomImageViewDelegate <NSObject>

- (void)didChangeImage:(UIImage *)image;

@end