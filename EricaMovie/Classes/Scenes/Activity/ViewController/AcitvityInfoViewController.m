//
//  AcitvityInfoViewController.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/24.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "AcitvityInfoViewController.h"
#import "ActivityInfoView.h"


#define vc self.activityInfoView
@interface AcitvityInfoViewController ()

@property (nonatomic,strong) ActivityInfoView *activityInfoView;

@end

@implementation AcitvityInfoViewController

- (void)loadView{
    self.activityInfoView = [[ActivityInfoView alloc]initWithFrame:kScreenBounds];
    self.view = self.activityInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vc.image = _activity.activityImage;
    vc.content = _activity.content;
    vc.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@",_activity.begin_time,_activity.end_time];
    vc.titleLabel.text = _activity.title;
    vc.ownerLabel.text = _activity.owner[@"name"];
    vc.typeLabel.text = _activity.category_name;
    vc.locationLabel.text = _activity.address;
//    [vc loadData];
    
}
-(void)setImage:(UIImage *)image{
    vc.image = image;
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
