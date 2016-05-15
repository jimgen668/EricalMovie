//
//  Theater.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/28.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "Theater.h"

@implementation Theater

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _theaterID = value;
    }
}

@end
