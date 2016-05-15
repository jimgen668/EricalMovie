//
//  ListButton.m
//  ButtonTest
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "ListButton.h"

@interface ListButton ()

@property (nonatomic,strong) NSArray *buttonTitle;
@property (nonatomic,strong) NSArray *buttonImages;

@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,assign) CGRect   frames;

@property (nonatomic,strong) UIButton *mainButton;
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIView *placeView;
//@property (nonatomic,strong) ListButton *listButton;

@end
@implementation ListButton

- (instancetype)initWithTitles:(NSArray *)titles mainTitle:(NSString *)title mainFrame:(CGRect)frame images:(NSArray *)image subButtonFrame:(CGRect)buttonFrame{
    if (self = [super initWithFrame:frame]) {
        if (titles.count != 0 || image.count != 0) {
            if (image)
            self.buttonImages = [NSArray arrayWithArray:image];
            if (title)
            self.buttonTitle = [NSArray arrayWithArray:titles];
            buttonFrame.origin.x = [UIScreen mainScreen].bounds.size.width / 2 - buttonFrame.size.width / 2;
            buttonFrame.origin.y = [UIScreen mainScreen].bounds.size.height / 2 - (buttonFrame.size.height * titles.count + 20 * (titles.count-1)) / 2;
            self.frames = buttonFrame;
            self.mainButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [self.mainButton setTitle:title forState:(UIControlStateNormal)];
            self.mainButton.frame = frame;
            self.mainButton.titleLabel.font = [UIFont systemFontOfSize:10];
            [self.mainButton addTarget:self action:@selector(showAllButton:) forControlEvents:(UIControlEventTouchUpInside)];
            self.mainView = [[UIView alloc]initWithFrame:frame];
            [self addSubview:self.mainButton];
            [self creatButton];
        }
    }
    return self;
}

+ (instancetype)shareListButtonWithTitles:(NSArray *)titles mainTitle:(NSString *)title mainFrame:(CGRect)frame images:(NSArray *)image subButtonFrame:(CGRect)buttonFrame{
    
    ListButton *lb = [[ListButton alloc]initWithTitles:titles mainTitle:title mainFrame:frame images:image subButtonFrame:buttonFrame];
    return lb;
    
}

//+ (instancetype)shareListButton{
//    
//}

- (void)showAllButton:(id)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(listButtonClickMainButton:)]) {
        [_delegate listButtonClickMainButton:sender];
    }
    if (self.placeView) {
        [self.placeView removeFromSuperview];
    }
    self.placeView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.placeView.backgroundColor = [UIColor clearColor];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    effectView.frame = self.placeView.bounds;
    [self.placeView addSubview:effectView];
    self.placeView.alpha = 0;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenAllButton)];
    [effectView addGestureRecognizer:ges];
    
    for (UIButton *btn in self.buttons) {
        [self.placeView addSubview:btn];
    }
    [((UIViewController *)_delegate).view.window addSubview:self.placeView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.placeView.alpha = 1;
    for (NSInteger x = 0; x < self.buttons.count; x++) {
        ((UIButton *)self.buttons[x]).frame = CGRectMake(self.frames.origin.x, self.frames.origin.y + (self.frames.size.height + 20)* x+1 , self.frames.size.width, self.frames.size.height);
    }
    
    
    [UIView commitAnimations];
}

- (void)hiddenAllButton{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    for (UIButton *btn in self.buttons) {
        btn.frame = self.frames;
    }
    
    self.placeView.alpha = 0;
    [UIView commitAnimations];
    
    
}

- (void)creatButton{
    if (self.buttonTitle.count == 0) {
        return;
    }
    for (NSInteger index = 0; index < self.buttonTitle.count; index ++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = _frames;
        [button setTitle:(NSString *)self.buttonTitle[index] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        if (self.buttonImages.count != 0 && self.buttonImages.count >= index)
            if (_buttonImages.count>index && _buttonImages[index]) {
                [button setImage:(UIImage *)self.buttonImages[index] forState:(UIControlStateNormal)];
            }
        [self.buttons addObject:button];
    }
    
}

- (void)setButtonTintColor:(UIColor *)buttonTintColor{
    for (UIButton *btn in self.buttons) {
        [btn setTintColor:buttonTintColor];
    }
}

- (void)buttonAction:(id)sender{
    [self hiddenAllButton];
    UIButton *button = (UIButton *)sender;
    NSInteger index = 0;
    for (UIButton *btn in self.buttons) {
        if (btn == button) {
            if (_delegate && [_delegate respondsToSelector:@selector(listButtonClickButtonAtIndex:sender:)]) {
                [_delegate listButtonClickButtonAtIndex:index sender:sender];
            }
        }
        index ++;
    }
}

- (void)setMainImage:(UIImage *)mainImage{
    
    [self.mainButton setImage:mainImage forState:(UIControlStateNormal)];
    
}

- (void)setItemAtIndex:(NSInteger)index item:(void (^)(id item))handle{
    if (index <= self.buttons.count) {
        handle(self.buttons[index]);
    }
}

- (NSArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

@end
