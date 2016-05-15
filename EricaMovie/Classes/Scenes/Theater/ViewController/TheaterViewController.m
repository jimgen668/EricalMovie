//
//  TheaterViewController.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "TheaterViewController.h"
#import "TheaterView.h"
#import "TheaterCell.h"
#import "Theater.h"
#import "ListButton.h"

#define vc self.theaterView
@interface TheaterViewController ()<UITableViewDataSource,UITableViewDelegate,ListButtonDelegate>

@property (nonatomic,strong) TheaterView *theaterView;
@property (nonatomic,strong) NSMutableArray *allDataArray;
@property (nonatomic,strong) ListButton *listButton;

@end

@implementation TheaterViewController
static NSString *const cellID = @"theaterCell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"影院";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"影院" image:[UIImage imageNamed:@"TheaterBarIcon"] tag:eTabBarTag_Theater];
        
        UIImage *image1 = [UIImage imageNamed:@"ActivityBarIcon"];
        UIImage *image2 = [UIImage imageNamed:@"MovieBarIon"];
        UIImage *image3 = [UIImage imageNamed:@"empty"];
        self.listButton = [ListButton shareListButtonWithTitles:@[@"未登录",@" 我的活动",@" 我的电影",@"退出登录",@"清理缓存"] mainTitle:@"" mainFrame:CGRectMake(0, 0, 30, 30) images:@[image3,image1,image2]subButtonFrame:CGRectMake(0, 0, 100, 30)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.listButton];
        self.listButton.buttonTintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadView{
    self.theaterView = [[TheaterView alloc]initWithFrame:kScreenBounds];
    self.view = self.theaterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vc.tableView.delegate = self;
    vc.tableView.dataSource = self;
    [vc.tableView registerNib:[UINib nibWithNibName:@"TheaterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    self.listButton.delegate = self;
    self.listButton.mainImage = [UIImage imageNamed:@"myIcon"];
    [self loadData];
    
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
#pragma mark ____________Delegate and DataSource__________
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TheaterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.theater = self.allDataArray[indexPath.row];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 184;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)loadData{
    NSURL *url = [NSURL URLWithString:kTheater_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *firDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSArray *array = [firDic[@"result"] objectForKey:@"data"];
            for (NSDictionary *dic in array) {
                Theater *theater = [Theater new];
                [theater setValuesForKeysWithDictionary:dic];
                [self.allDataArray addObject:theater];
            }
        }
        [GMDCircleLoader hideFromView:self.theaterView animated:YES];
        [vc.tableView reloadData];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_allDataArray.count != 0) {
        return;
    }
    [GMDCircleLoader setOnView:self.theaterView withTitle:@"正在加载……" animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [GMDCircleLoader hideFromView:self.theaterView animated:YES];
}


- (NSMutableArray *)allDataArray{
    
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _allDataArray;
    
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
