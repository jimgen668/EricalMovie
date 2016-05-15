//
//  TheaterInfoViewController.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "TheaterInfoViewController.h"
#import "TheaterInfoView.h"

@interface TheaterInfoViewController ()

@property (nonatomic,strong) TheaterInfoView *theaterInfoView;

@end

@implementation TheaterInfoViewController

- (void)loadView{
    self.theaterInfoView = [[TheaterInfoView alloc]initWithFrame:kScreenBounds];
    self.view = self.theaterInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
