//
//  LoginView.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate;
@interface LoginView : UIView

- (void)showLoginView:(id(^)(void))handel;

+ (instancetype)shareView;

@end
@protocol LoginViewDelegate <NSObject>



@end