//
//  ListButton.h
//  ButtonTest
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListButtonDelegate;
@interface ListButton : UIView

@property (nonatomic,strong) id<ListButtonDelegate> delegate;
@property (nonatomic,strong) UIImage *mainImage;
@property (nonatomic,strong) UIColor *buttonTintColor;

- (instancetype)initWithTitles:(NSArray *)titles
                     mainTitle:(NSString *)title
                         mainFrame:(CGRect)frame
                        images:(NSArray *)image
                subButtonFrame:(CGRect)buttonFrame;

+ (instancetype)shareListButtonWithTitles:(NSArray *)titles
                                mainTitle:(NSString *)title
                                mainFrame:(CGRect)frame
                                   images:(NSArray *)image
                           subButtonFrame:(CGRect)buttonFrame;

- (void)setItemAtIndex:(NSInteger)index item:(void(^)(id item))handle;

//+ (instancetype)shareListButton;
@end
@protocol ListButtonDelegate <NSObject>

@optional
- (void)listButtonClickButtonAtIndex:(NSInteger)index
                              sender:(id)sender;
- (void)listButtonClickMainButton:(id)sender;

@end