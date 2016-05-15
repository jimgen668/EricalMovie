//
//  MovieViewController.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableView.h"
#import "MovieCollectionView.h"
#import "Movie.h"

#import "MovieTableViewCell.h"
#import "MovieCollectionViewCell.h"

#import "MovieInfoViewController.h"
#import "ListButton.h"


#define movieTV self.movieTableView.tableView
#define movieCV self.movieCollectionView.collectionView

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ListButtonDelegate>

@property (nonatomic,assign) BOOL isTableView;
@property (nonatomic,strong) MovieTableView *movieTableView;
@property (nonatomic,strong) MovieCollectionView *movieCollectionView;
@property (nonatomic,strong) UIButton *rightBarButton;

@property (nonatomic,strong) NSMutableArray *allDataArray;

@property (nonatomic,strong) ListButton *listButton;
@end

@implementation MovieViewController

static NSString *const CELLID = @"MovieCell";
static NSString *const CCELLID = @"MovieCollectionCell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"电影";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电影" image:[UIImage imageNamed:@"MovieBarIon"] tag:eTabBarTag_Movie];
        
        self.rightBarButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_rightBarButton setImage:[UIImage imageNamed:@"MovieNBarCollectionIcon"] forState:(UIControlStateNormal)];
        _rightBarButton.frame = CGRectMake(0, 0, 30, 30);
        [_rightBarButton addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBarButton];
        
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
    self.movieTableView = [[MovieTableView alloc]initWithFrame:kScreenBounds];
    self.movieCollectionView = [[MovieCollectionView alloc]initWithFrame:kTableView_Rect];
    [self.view addSubview:_movieCollectionView];
    
    [movieTV registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELLID];
    movieTV.delegate = self;
    movieTV.dataSource = self;
    
    [movieCV registerNib:[UINib nibWithNibName:@"MovieCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CCELLID];
    movieCV.delegate = self;
    movieCV.dataSource = self;
    self.listButton.delegate = self;
    self.listButton.mainImage = [UIImage imageNamed:@"myIcon"];
    [self downloadData];

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

#pragma mark ____________TableView Delegate and DataSource_________
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 416;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    
    Movie *movie = self.allDataArray[indexPath.row];
    cell.movie = movie;
    
    if (movie.movieImage == nil && !movie.isDownloading ) {
        cell.image = kMainWaitImage;
        [movie loadImage];
        [movie addObserver:self forKeyPath:@"movieImage" options:(NSKeyValueObservingOptionNew) context:(__bridge void *)(indexPath)];
    }else{
        if (movie.movieImage== nil) {
            cell.image = kMainWaitImage;
        }else{
            cell.image = movie.movieImage;
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MovieInfoViewController *movieInfoVC = [MovieInfoViewController new];
    movieInfoVC.movie = _allDataArray[indexPath.row];
    [self.navigationController pushViewController:movieInfoVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark ___________CollectionView Delegate and DataSource____________
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CCELLID forIndexPath:indexPath];

    Movie *movie = self.allDataArray[indexPath.item];
    cell.movie = movie;
    
    if (movie.movieImage == nil && !movie.isDownloading ) {
        cell.image = kMainWaitImage;
        [movie loadImage];
        [movie addObserver:self forKeyPath:@"movieImage" options:(NSKeyValueObservingOptionNew) context:(__bridge void *)(indexPath)];
    }else{
        if (movie.movieImage== nil) {
            cell.image = kMainWaitImage;
        }else{
            cell.image = movie.movieImage;
        }
        
    }
    
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieInfoViewController *movieInfoVC = [MovieInfoViewController new];
    movieInfoVC.movie = _allDataArray[indexPath.item];
    [self.navigationController pushViewController:movieInfoVC animated:YES];
    
    
}

#pragma mark ___________________观察者实现___________________________
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    UIImage *image = (UIImage *)change[@"new"];
    if (image == nil) {
        return;
    }
    NSArray *Carray = [movieCV indexPathsForVisibleItems];
    NSArray *array = [movieTV indexPathsForVisibleRows];
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    if ([array containsObject:indexPath]) {
        MovieTableViewCell *cell = (MovieTableViewCell *)[movieTV cellForRowAtIndexPath:indexPath];
        cell.image = image;
        [movieTV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    }
    
    if ([Carray containsObject:indexPath]) {
        MovieCollectionViewCell *cell = (MovieCollectionViewCell *)[movieCV cellForItemAtIndexPath:indexPath];
        cell.image = image;
        [movieCV reloadItemsAtIndexPaths:@[indexPath]];
    }
    
    //    [object removeObserver:self forKeyPath:keyPath];
    
}


#pragma mark ___________________切换视图——————————————————————————————————
- (void)rightBarButtonAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    if (_isTableView) {
        [button setImage:[UIImage imageNamed:@"MovieNBarCollectionIcon"] forState:(UIControlStateNormal)];
        [UIView transitionFromView:self.movieTableView toView:self.movieCollectionView duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
    }else{
        [button setImage:[UIImage imageNamed:@"MovieNBarListIcon"] forState:(UIControlStateNormal)];
        [UIView transitionFromView:self.movieCollectionView toView:self.movieTableView duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
    }
    _isTableView = !_isTableView;
    
}

#pragma mark ______________下载数据____________
- (void)downloadData{
    NSURL *url = [NSURL URLWithString:kMovie_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSArray *array = dic[@"result"];
        for (NSDictionary *dict in array) {
            Movie *movie = [[Movie alloc]init];
            [movie setValuesForKeysWithDictionary:dict];
            [self.allDataArray addObject:movie];
        }
        [GMDCircleLoader hideFromView:self.view animated:YES];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [movieTV reloadData];
        [movieCV reloadData];
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_allDataArray.count != 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [GMDCircleLoader setOnView:self.view withTitle:@"正在加载……" animated:YES];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [GMDCircleLoader hideFromView:self.view animated:YES];
}


#pragma mark _________  懒加载 ___________________
- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray arrayWithCapacity:10];
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
