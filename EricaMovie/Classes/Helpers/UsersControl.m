//
//  UsersControl.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/28.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "UsersControl.h"


@interface UsersControl ()

@property (nonatomic,copy) NSString *onLineUserPasswd;
@property (nonatomic,strong) NSMutableDictionary *userIDDic;
@property (nonatomic,strong) NSMutableDictionary *activitys;
@property (nonatomic,strong) NSMutableDictionary *movies;

@end
@implementation UsersControl

+ (instancetype)shareUsers{
    static UsersControl *user = nil;
    if (!user) {
        user = [UsersControl new];
    }
    return user;
}

- (BOOL)registWithUserName:(NSString *)userName password:(NSString *)password{
    if ([self.userIDDic.allKeys containsObject:userName]) {
        return NO;
    }else{
        
        [self.userIDDic setObject:password forKey:userName];
        
        return YES;
    }
}

- (BOOL)loginWithUserName:(NSString *)userName password:(NSString *)password{
    for (NSString *name in self.userIDDic.allKeys) {
        if ([name isEqualToString:userName]) {
            if ([self.userIDDic[userName] isEqualToString:password]) {
                self.isLogin = YES;
                self.onLineUserName = name;
                return YES;
            }
        }
    }
    return NO;
    
}

- (void)canceling{
    
    self.isLogin = NO;
    self.onLineUserName = nil;
    
}

- (NSMutableDictionary *)userIDDic{
    if (!_userIDDic) {
        _userIDDic = [NSMutableDictionary dictionary];
    }
    return _userIDDic;
}

@end
