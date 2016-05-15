//
//  RegistView.h
//  EricaMovie
//
//  Created by LakesMac on 15/9/29.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistView : UIView

+ (instancetype)shareRegistView;

- (void)showRegistView:(id(^)(void))viewController;

@end
