//
//  UsersControl.h
//  EricaMovie
//
//  Created by jimgen668 on 15/9/28.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersControl : NSObject

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,copy) NSString *onLineUserName;

- (BOOL)registWithUserName:(NSString *)userName password:(NSString *)password;
- (BOOL)loginWithUserName:(NSString *)userName password:(NSString *)password;
- (void)canceling;//取消登陆

+ (instancetype)shareUsers;

@end
