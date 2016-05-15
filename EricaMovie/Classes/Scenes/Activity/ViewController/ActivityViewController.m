//
//  ActivityViewController.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/23.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityView.h"
#import "ActivityCell.h"
#import "Activity.h"


#import "AcitvityInfoViewController.h"
#import "UIImageView+WebCache.h"



#define vc self.activityView

@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate,ListButtonDelegate>

@property (nonatomic,strong) ActivityView *activityView;
@property (nonatomic,strong) ListButton   *listButton;
@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation ActivityViewController

static NSString *const CELLID = @"ActivityCell";

- (void)loadView{
    self.activityView = [[ActivityView alloc]initWithFrame:kScreenBounds];
    self.view = self.activityView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"活动";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"活动" image:[UIImage imageNamed:@"ActivityBarIcon"] tag:eTabBarTag_Activity ];
        UIImage *image1 = [UIImage imageNamed:@"ActivityBarIcon"];
        UIImage *image2 = [UIImage imageNamed:@"MovieBarIon"];
        UIImage *image3 = [UIImage imageNamed:@"empty"];
        self.listButton = [ListButton shareListButtonWithTitles:@[@"未登录",@" 我的活动",@" 我的电影",@"退出登录",@"清理缓存"] mainTitle:@"" mainFrame:CGRectMake(0, 0, 30, 30) images:@[image3,image1,image2]subButtonFrame:CGRectMake(0, 0, 100, 30)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.listButton];
        self.listButton.buttonTintColor = [UIColor whiteColor];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    vc.tableView.delegate = self;
    vc.tableView.dataSource = self;
    [vc.tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELLID];
        [self downloadData];
    self.listButton.delegate = self;
    self.listButton.mainImage = [UIImage imageNamed:@"myIcon"];
}

#pragma mark ___________ListButton Delegate_______________
- (void)listButtonClickButtonAtIndex:(NSInteger)index sender:(id)sender{
    if (![UsersControl shareUsers].isLogin) {
        [[LoginView shareView] showLoginView:^id{
            return self;
        }];
    }
    if (index == 0) {
        if ([UsersControl shareUsers].isLogin) {
            
        }else{
            [[LoginView shareView] showLoginView:^id{
                return self;
            }];
        }
    }else if (index == 3){
        [[UsersControl shareUsers] canceling];
    }
}
- (void)listButtonClickMainButton:(id)sender{
    if ([UsersControl shareUsers].isLogin) {
        [self.listButton setItemAtIndex:0 item:^(id item) {
            [((UIButton *)item) setTitle:[NSString stringWithFormat:@"你好 %@",[UsersControl shareUsers].onLineUserName] forState:(UIControlStateNormal)];
        }];
        [self.listButton setItemAtIndex:3 item:^(id item) {
            [((UIButton *)item) setEnabled:YES];
        }];
    }else{
        [self.listButton setItemAtIndex:0 item:^(id item) {
            [((UIButton *)item) setTitle:@"未登录" forState:(UIControlStateNormal)];
        }];
        [self.listButton setItemAtIndex:3 item:^(id item) {
            [((UIButton *)item) setEnabled:NO];
        }];
    }
}
#pragma mark __________________Delegate and DataSource___________________

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    
    
    
    Activity *activity = _allDataArray[indexPath.row];
    
    cell.activity = activity;
    
//    activity.activityImage = [LakeImageDownloader imageDownloaderDownloadImageWithURLString:activity.image];
    
//    cell.image = activity.activityImage;
    
    if (activity.activityImage == nil && !activity.isDownloading ) {
        cell.image = kMainWaitImage;
        [activity loadImage];
        [activity addObserver:self forKeyPath:@"activityImage" options:(NSKeyValueObservingOptionNew) context:(__bridge void *)(indexPath)];
    }else{
        if (activity.activityImage == nil) {
            cell.image = kMainWaitImage;
        }else{
            cell.image = activity.activityImage;
        }
        
    }
//    cell.tableView = vc.tableView;
    
//    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:activity.image] placeholderImage:[UIImage imageNamed:@"1"]];
//    NSLog(@"%@",activity.image);

    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    UIImage *image = (UIImage *)change[@"new"];
    if (image == nil) {
        return;
    }
    NSArray *array = [vc.tableView indexPathsForVisibleRows];
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    if ([array containsObject:indexPath]) {
        ActivityCell *cell = (ActivityCell *)[vc.tableView cellForRowAtIndexPath:indexPath];
        cell.image = image;
        [vc.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    }
    
    [object removeObserver:self forKeyPath:keyPath];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 184;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AcitvityInfoViewController *activityInfoVC = [AcitvityInfoViewController new];
    [self.navigationController pushViewController:activityInfoVC animated:YES];
    activityInfoVC.activity = _allDataArray[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}







#pragma mark 请求数据
- (void)downloadData{
    
    NSURL *url = [NSURL URLWithString:kAction_URL];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (!data) {
            return ;
        }
        NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *eventsArray = firstDic[@"events"];
        _allDataArray = [[NSMutableArray alloc]initWithCapacity:10];
        for (NSDictionary *eventsDic in eventsArray) {
            Activity *action = [Activity new];
            [action setValuesForKeysWithDictionary:eventsDic];
            [_allDataArray addObject:action];
//            [self.tableView reloadData];
        }
        [GMDCircleLoader hideFromView:self.activityView animated:YES];
        [vc.tableView reloadData];
        
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_allDataArray.count != 0) {
        return;
    }
    [GMDCircleLoader setOnView:self.activityView withTitle:@"正在加载……" animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [GMDCircleLoader hideFromView:self.activityView animated:YES];
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
