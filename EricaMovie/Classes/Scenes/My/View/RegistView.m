//
//  RegistView.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/29.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "RegistView.h"

#define rMainTintColor [UIColor colorWithRed:234 / 255. green:123 / 255. blue:49 / 255. alpha:1]
#define rLabelViewImageName @"RegistTextField"
#define rTag_nameTextField      10000001
#define rTag_pwsTextField       10000002
#define rTag_pwsChackTextField  10000003

@interface RegistView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIVisualEffectView *backgroundView;
@property (nonatomic,strong) UIView *nameLabelView;
@property (nonatomic,strong) UIView *pwdLabelView;
@property (nonatomic,strong) UIView *pwdChackLabelView;

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITextField *pwdChackTextField;

@property (nonatomic,strong) UIButton *conformButton;
@property (nonatomic,strong) UIButton *cancelButton;

@end
@implementation RegistView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

+ (instancetype)shareRegistView{
    
    static RegistView *reg = nil;
    if (!reg) {
        reg = [[RegistView alloc]initWithFrame:kScreenBounds];
    }
    return reg;
    

}

- (void)addAllViews{
    self.backgroundView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.backgroundView.frame = kScreenBounds;
    [self addSubview:self.backgroundView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 30)];
    titleLabel.center = CGPointMake(kScreenBounds.size.width / 2, 70);
    titleLabel.text = @"- 注册 -";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = rMainTintColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:titleLabel];
//    ======================================================
    [self addLabelViews];//添加输入框背板
    [self addLabelAndTextFields];//添加文本框和文本框
    [self addButtons];//添加按钮

}

#pragma mark ____________添加输入框背板____________________
- (void)addLabelViews{
    self.nameLabelView = [[UIView alloc]initWithFrame:CGRectMake((kScreenBounds.size.width - 300) / 2, (kScreenBounds.size.height - 30)/4, 300, 30)];
    UIImageView *nameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:rLabelViewImageName]];
    [self.nameLabelView addSubview:nameImageView];
    [self.backgroundView addSubview:self.nameLabelView];
    
    self.pwdLabelView = [[UIView alloc]initWithFrame:CGRectMake(self.nameLabelView.frame.origin.x, self.nameLabelView.frame.origin.y + self.nameLabelView.frame.size.height * 2.5, self.nameLabelView.frame.size.width, self.nameLabelView.frame.size.height)];
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rLabelViewImageName]];
    [self.pwdLabelView addSubview:pwdImageView];
    [self.backgroundView addSubview:self.pwdLabelView];
    
    self.pwdChackLabelView = [[UIView alloc]initWithFrame:CGRectMake(self.pwdLabelView.frame.origin.x, self.pwdLabelView.frame.origin.y + self.pwdLabelView.frame.size.height * 2.5, self.pwdLabelView.frame.size.width, self.pwdLabelView.frame.size.height)];
    UIImageView *pwdChackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:rLabelViewImageName]];
    [self.pwdChackLabelView addSubview:pwdChackImageView];
    [self.backgroundView addSubview:self.pwdChackLabelView];
}
#pragma mark ____________添加文本框和输入框_________________
- (void)addLabelAndTextFields{
    UILabel *nameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 0, 84, 30)];
    nameTitleLabel.text = @"用户名:";
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    nameTitleLabel.textColor = [UIColor whiteColor];
    [self.nameLabelView addSubview:nameTitleLabel];
    
    UILabel *pwdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 0, 84, 30)];
    pwdTitleLabel.text = @"密   码:";
    pwdTitleLabel.textAlignment = NSTextAlignmentCenter;
    pwdTitleLabel.textColor = [UIColor whiteColor];
    [self.pwdLabelView addSubview:pwdTitleLabel];
    
    UILabel *pwdChackTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 0, 84, 30)];
    pwdChackTitleLabel.text = @"确认密码:";
    pwdChackTitleLabel.textAlignment = NSTextAlignmentCenter;
    pwdChackTitleLabel.textColor = [UIColor whiteColor];
    [self.pwdChackLabelView addSubview:pwdChackTitleLabel];
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTitleLabel.frame.origin.x + nameTitleLabel.frame.size.width, 1, 182, 28)];
    self.nameTextField.textColor = [UIColor whiteColor];
    [self.nameLabelView addSubview:self.nameTextField];
    
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTitleLabel.frame.origin.x + nameTitleLabel.frame.size.width, 1, 182, 28)];
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.secureTextEntry = YES;
    [self.pwdLabelView addSubview:self.pwdTextField];
    
    self.pwdChackTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTitleLabel.frame.origin.x + nameTitleLabel.frame.size.width, 1, 182, 28)];
    self.pwdChackTextField.textColor = [UIColor whiteColor];
    self.pwdChackTextField.secureTextEntry = YES;
    [self.pwdChackLabelView addSubview:self.pwdChackTextField];
    
    self.nameTextField.delegate = self;
    self.nameTextField.tag = rTag_nameTextField;
    self.pwdTextField.delegate = self;
    self.pwdTextField.tag = rTag_pwsTextField;
    self.pwdChackTextField.delegate = self;
    self.pwdChackTextField.tag = rTag_pwsChackTextField;
    
    
}
#pragma mark ____________添加按钮_________________________
- (void)addButtons{
    self.conformButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.conformButton.frame = CGRectMake(0, 0, 200, 30);
    self.conformButton.center = CGPointMake(kScreenBounds.size.width / 2, self.pwdChackLabelView.frame.origin.y + 100);
    [self.conformButton setTitle:@"确定" forState:(UIControlStateNormal)];
    self.conformButton.tintColor = rMainTintColor;
    self.conformButton.layer.borderColor = rMainTintColor.CGColor;
    self.conformButton.layer.borderWidth = 0.5;
    [self.conformButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backgroundView addSubview:self.conformButton];
    
    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.cancelButton.frame = CGRectMake(self.conformButton.frame.origin.x, self.conformButton.frame.origin.y + self.conformButton.frame.size.height + 30, self.conformButton.frame.size.width, self.conformButton.frame.size.height);
    [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    self.cancelButton.tintColor = rMainTintColor;
    self.cancelButton.layer.borderWidth = 0.5;
    self.cancelButton.layer.borderColor = rMainTintColor.CGColor;
    [self.cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backgroundView addSubview:self.cancelButton];
    
    
}

//按钮点击事件
- (void)buttonAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button == self.conformButton) {
        NSString *name    = self.nameTextField.text;
        NSString *passwd1 = self.pwdTextField.text;
        NSString *passwd2 = self.pwdChackTextField.text;
        if ([passwd1 isEqualToString:passwd2] && ![passwd1 isEqualToString:@""] && ![passwd2 isEqualToString:@""]) {
            [[UsersControl shareUsers] registWithUserName:name password:passwd1];
            [[UsersControl shareUsers] loginWithUserName:name password:passwd1];
            [self hiddenView];
        }
        if (![passwd1 isEqualToString:passwd2]){
            [self changeButton:button color:[UIColor redColor] andTitle:@"两次密码不一致"];
        }
        if ([name isEqualToString:@""] || [passwd1 isEqualToString:@""]){
            [self changeButton:button color:[UIColor redColor] andTitle:@"用户名/密码不能为空"];
        }
    }else{
        
        [self hiddenView];
    }
    [self endEditing:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.conformButton.tintColor == [UIColor redColor]) {
        [self changeButton:self.conformButton color:rMainTintColor andTitle:@"确定"];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.tag == rTag_pwsChackTextField) {
        return YES;
    }else{
        [[self viewWithTag:textField.tag + 1] becomeFirstResponder];
    }
    return YES;
}


//改变按钮颜色和标题
- (void)changeButton:(UIButton *)button color:(UIColor *)color andTitle:(NSString *)title{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [button setTitle:title forState:(UIControlStateNormal)];
    button.tintColor = color;
    button.layer.borderColor = color.CGColor;
    [UIView commitAnimations];
}

//出现和消失
- (void)showRegistView:(id (^)(void))viewController{
    self.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y + kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    [((UIViewController *)viewController()).view.window addSubview:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.frame = kScreenBounds;
    
    [UIView commitAnimations];
}
- (void)hiddenView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y + kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    self.pwdTextField.text = self.pwdChackTextField.text = self.nameTextField.text = @"";
    [UIView commitAnimations];
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self endEditing:YES];
}

@end
