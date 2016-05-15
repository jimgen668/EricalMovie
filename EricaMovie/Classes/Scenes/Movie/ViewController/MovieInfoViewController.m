//
//  MovieInfoViewController.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/27.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "MovieInfoViewController.h"
#import "MovieInfoView.h"

#define vc self.movieInfoView

@interface MovieInfoViewController ()

@property (nonatomic,strong) MovieInfoView *movieInfoView;

@end

@implementation MovieInfoViewController

- (void)loadView{
    self.movieInfoView = [[MovieInfoView alloc]initWithFrame:kScreenBounds];
    self.view = self.movieInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GMDCircleLoader setOnView:self.movieInfoView.contentView withTitle:@"正在加载……" animated:YES];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)pushView{
    CGRect to = CGRectMake(10, 0, vc.contentView.frame.size.width - 20, 220);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    vc.moveContentView.frame = to;
    [UIView commitAnimations];
}

- (void)setMovie:(Movie *)movie{
    NSMutableString *urlPath = [NSMutableString stringWithString:kMovieInfo_URL];
    [urlPath appendString:movie.movieId];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (!data) {
            return ;
        }
        NSDictionary *dic = firstDic[@"result"];
        self.movieInfo = [MovieInfo new];
        [self.movieInfo setValuesForKeysWithDictionary:dic];
        [self loadData];
    }];
    
}

- (void)loadData{
    vc.image = kMainWaitImage;
    [LakeImageDownloader imageDownloaderDownloadImageWithURLString:_movieInfo.poster complitImage:^(UIImage *image) {
        [GMDCircleLoader hideFromView:self.movieInfoView.contentView animated:YES];
        vc.image = image;
    }];
    vc.score = _movieInfo.rating;
    vc.commentary = _movieInfo.rating_count;
    vc.releaseDate = _movieInfo.release_date;
    vc.runTime = _movieInfo.runtime;
    vc.genres = _movieInfo.genres;
    vc.filmLocations = _movieInfo.country;
    vc.actors = _movieInfo.actors;
    vc.plotSimple = _movieInfo.plot_simple;
    self.title = _movieInfo.title;
    [self pushView];
    
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
