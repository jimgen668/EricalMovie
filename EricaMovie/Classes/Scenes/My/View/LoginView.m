//
//  LoginView.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "LoginView.h"
#import "RegistView.h"

#define lTag_nameTextField 100000001
#define lTag_padTextField  100000002

@interface LoginView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIVisualEffectView *visualEffectView;
@property (nonatomic,strong) UIVisualEffectView *naBar;
@property (nonatomic,strong) UIShakeView *nameView;
@property (nonatomic,strong) UIShakeView *passwdView;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *pwdTextField;

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) UIButton *cancelButton;

@property (nonatomic,strong) UIViewController *tmpViewController;


@end
@implementation LoginView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.visualEffectView.frame = self.frame;
    [self addSubview:self.visualEffectView];
    
    self.naBar = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.naBar.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 64);
    [self addSubview:self.naBar];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"登录";
    titleLabel.textColor = kMainTintColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(self.naBar.frame.size.width / 2, self.naBar.frame.size.height - 5 - titleLabel.frame.size.height / 2);
    [self.naBar addSubview:titleLabel];
    
    
#pragma mark ____________________输入窗口____________________
    self.nameView = [[UIShakeView alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    UIImageView *nameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"UserTextField"]];
    [self.nameView addSubview:nameImageView];
    self.nameView.center = CGPointMake(self.visualEffectView.frame.size.width / 2, self.visualEffectView.frame.size.height / 2 - 200);
    [self.visualEffectView addSubview:self.nameView];
    
    self.passwdView = [[UIShakeView alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    UIImageView *pwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"UserTextField"]];
    [self.passwdView addSubview:pwdImageView];
    self.passwdView.center = CGPointMake(self.visualEffectView.frame.size.width / 2, self.nameView.frame.origin.y + self.nameView.frame.size.height + 70);
    [self.visualEffectView addSubview:self.passwdView];
    
    UILabel *nameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 0, 84, 30)];
    nameTitleLabel.textColor = [UIColor whiteColor];
    nameTitleLabel.text = @"用户名";
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.nameView addSubview:nameTitleLabel];
    
    
    UILabel *pwdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 0, 84, 30)];
    pwdTitleLabel.textColor = [UIColor whiteColor];
    pwdTitleLabel.text = @"密   码";
    pwdTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.passwdView addSubview:pwdTitleLabel];
    
    
    
    
    //    ______________________输入框________________________
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTitleLabel.frame.origin.x + nameTitleLabel.frame.size.width, 1, 182, 28)];
    self.nameTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.nameView addSubview:self.nameTextField];
    self.nameTextField.delegate = self;
    
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTitleLabel.frame.origin.x + nameTitleLabel.frame.size.width, 1, 182, 28)];
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.clearsOnBeginEditing = YES;
    self.pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.passwdView addSubview:self.pwdTextField];
    self.pwdTextField.delegate = self;
    self.nameTextField.tag = lTag_nameTextField;
    self.pwdTextField.tag = lTag_padTextField;
    //    =================================================================
    
#pragma mark ________________登录与注册按钮____________________________
    self.loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.loginButton.frame = CGRectMake(0, 0, 200, 30);
    self.loginButton.center = CGPointMake(self.visualEffectView.frame.size.width / 2, self.passwdView.frame.origin.y + 100);
    [self.loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    UIColor *color = kMainTintColor;
    self.loginButton.layer.borderColor = color.CGColor;
    self.loginButton.layer.borderWidth = 0.5;
    self.loginButton.tintColor = color;
    [self.loginButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.visualEffectView addSubview:self.loginButton];
    
    
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.registerButton.frame = CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y + self.loginButton.frame.size.height + 30, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
    [self.registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    self.registerButton.layer.borderColor = color.CGColor;
    self.registerButton.layer.borderWidth = 0.5;
    self.registerButton.tintColor = color;
    [self.registerButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.visualEffectView addSubview:self.registerButton];
    
    
    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.cancelButton.frame = CGRectMake((kScreenBounds.size.width - 50)/2,kScreenBounds.size.height - 100, 50, 50);
    [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    self.cancelButton.tintColor = [UIColor whiteColor];
    self.cancelButton.layer.cornerRadius = 25;
    self.cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.5;
    [self.cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.visualEffectView addSubview:self.cancelButton];
    
}

- (void)buttonAction:(id)sender{
    if (sender == self.loginButton) {
        NSString *name = self.nameTextField.text;
        NSString *pwd = self.pwdTextField.text;
        if ([[UsersControl shareUsers] loginWithUserName:name password:pwd]) {
            NSLog(@"in");
            [self hiddenView];
        }else{
            [self.nameView shake];
            [self.passwdView shake];
        }
    }else if(sender == self.registerButton){
        [[RegistView shareRegistView] showRegistView:^id{
            return self.tmpViewController;
        }];
        [self endEditing:YES];
        [self hiddenView];
    }else if(sender == self.cancelButton){
        [self hiddenView];
    }
}

+ (instancetype)shareView{
    static LoginView *lv = nil;
    if (!lv) {
        lv = [[LoginView alloc]initWithFrame:kScreenBounds];
    }
    return lv;
}

- (void)hiddenView{
    self.nameTextField.text = @"";
    self.pwdTextField.text = @"";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y - kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    [UIView commitAnimations];
}

- (void)showLoginView:(id (^)(void))handel{
    self.frame = CGRectMake(kScreenBounds.origin.x, kScreenBounds.origin.y - kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    self.tmpViewController =((UIViewController *)handel());
    [self.tmpViewController.view.window addSubview:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.frame = kScreenBounds;
    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.tag == lTag_nameTextField) {
        [[self viewWithTag:lTag_padTextField] becomeFirstResponder];
    }
    return YES;
}

@end
