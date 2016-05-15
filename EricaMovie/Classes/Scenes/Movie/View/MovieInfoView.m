//
//  MovieInfoView.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/27.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "MovieInfoView.h"

@interface MovieInfoView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *backgroundImage;
@property (nonatomic,strong) UIVisualEffectView *visualEffectView;

@property (nonatomic,strong) UIView *mainImageGroundView;

@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UILabel *commentaryLabel;
@property (nonatomic,strong) UILabel *releaseDateLabel;
@property (nonatomic,strong) UILabel *runtimeLabel;
@property (nonatomic,strong) UILabel *genresLabel;
@property (nonatomic,strong) UILabel *filmLocationsLabel;

@property (nonatomic,strong) UILabel *actorsTitleLabel;
@property (nonatomic,strong) UILabel *actorsLabel;
@property (nonatomic,strong) UILabel *plotSimpleTitleLabel;
@property (nonatomic,strong) UILabel *plotSimpleLabel;

@end

@implementation MovieInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor blackColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:kTableView_Rect];
//    _scrollView.alwaysBounceVertical = YES;
    _scrollView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc]initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;
    
    self.backgroundImage = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.backgroundImage];
    
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    _visualEffectView.frame = self.contentView.bounds;
    [self.backgroundImage addSubview:self.visualEffectView];
    
    
    self.moveContentView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    _moveContentView.frame = CGRectMake(10, -220, self.contentView.frame.size.width - 20, 220);
//    _moveContentView.backgroundColor = [UIColor whiteColor];
    _moveContentView.layer.shadowOpacity = 0.5;
    _moveContentView.layer.shadowOffset = CGSizeMake(-1, 3);
    [self.contentView addSubview:self.moveContentView];
    
    self.mainImageGroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 10,150, 200)];
    _mainImageGroundView.backgroundColor = [UIColor lightGrayColor];
    _mainImageGroundView.layer.cornerRadius = 10;
    _mainImageGroundView.layer.masksToBounds = YES;
    [self.moveContentView addSubview:self.mainImageGroundView];
    
    
    
#pragma mark ___________________Labels_____________________________
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mainImageGroundView.frame.size.width + self.mainImageGroundView.frame.origin.x + 10, self.mainImageGroundView.frame.origin.y, (self.moveContentView.frame.size.width - self.mainImageGroundView.frame.size.width - self.mainImageGroundView.frame.origin.x + 10) / 2 - 20, 21)];
    [self.moveContentView addSubview:self.scoreLabel];
    
    self.commentaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.scoreLabel.frame.size.width + self.scoreLabel.frame.origin.x + 10, self.scoreLabel.frame.origin.y, self.scoreLabel.frame.size.width, 21)];
    _commentaryLabel.font = [UIFont systemFontOfSize:14];
    [self.moveContentView addSubview:self.commentaryLabel];
    
    CGFloat destence = ((self.moveContentView.frame.size.height - 20) - self.scoreLabel.frame.size.height * 5)/4;
    
    self.releaseDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.scoreLabel.frame.origin.x,self.scoreLabel.frame.origin.y + self.scoreLabel.frame.size.height + destence, self.commentaryLabel.frame.origin.x - self.scoreLabel.frame.origin.x + self.commentaryLabel.frame.size.width, 21)];
    [self.moveContentView addSubview:self.releaseDateLabel];
    
    self.runtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.releaseDateLabel.frame.origin.x, self.releaseDateLabel.frame.size.height + self.releaseDateLabel.frame.origin.y + destence, self.releaseDateLabel.frame.size.width, 21)];
    _runtimeLabel.font = [UIFont systemFontOfSize:15];
    [self.moveContentView addSubview:self.runtimeLabel];
    
    self.genresLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.runtimeLabel.frame.origin.x, self.runtimeLabel.frame.origin.y + self.runtimeLabel.frame.size.height + destence, self.runtimeLabel.frame.size.width, self.runtimeLabel.frame.size.height)];
    [self.moveContentView addSubview:self.genresLabel];
    
    self.filmLocationsLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.genresLabel.frame.origin.x, self.genresLabel.frame.origin.y + self.genresLabel.frame.size.height + destence, self.genresLabel.frame.size.width, self.genresLabel.frame.size.height)];
    [self.moveContentView addSubview:self.filmLocationsLabel];
    
    self.actorsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.moveContentView.frame.origin.x, self.moveContentView.frame.size.height + 20, self.contentView.frame.size.width - self.moveContentView.frame.origin.x * 2, 21)];
    _actorsTitleLabel.font = [UIFont systemFontOfSize:20];
    _actorsTitleLabel.text = @"制作人:";
    _actorsTitleLabel.textColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:self.actorsTitleLabel];
    
    self.actorsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.actorsTitleLabel.frame.origin.y + self.actorsTitleLabel.frame.size.height + 10, kScreenBounds.size.width - 40, 21)];
    _actorsLabel.numberOfLines = 0;
//    _actorsLabel.lineBreakMode = NSLineBreakByTruncatingHead;
//    _actorsLabel.backgroundColor = kMainTitleBackgroundColor;
    _actorsLabel.layer.masksToBounds = YES;
    _actorsLabel.font = [UIFont systemFontOfSize:15];
    _actorsLabel.textColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:self.actorsLabel];
    
    
    self.plotSimpleTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.actorsTitleLabel.frame.origin.x, self.actorsLabel.frame.origin.y + self.actorsLabel.frame.size.height + 10, self.actorsTitleLabel.frame.size.width, self.actorsTitleLabel.frame.size.height)];
    _plotSimpleTitleLabel.font = [UIFont systemFontOfSize:20];
    _plotSimpleTitleLabel.text = @"电影情节:";
    _plotSimpleTitleLabel.textColor = kMainTitleBackgroundColor;
    [self.contentView addSubview:self.plotSimpleTitleLabel];
    
    self.plotSimpleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.plotSimpleTitleLabel.frame.size.height + self.plotSimpleLabel.frame.origin.y + 10, kScreenBounds.size.width - 20, 21)];
    _plotSimpleLabel.numberOfLines = 0;
    _plotSimpleLabel.textColor = kMainTitleBackgroundColor;
    _plotSimpleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.plotSimpleLabel];
    
}

- (void)setImage:(UIImage *)image{
    
    self.backgroundImage.image = image;
    if (image) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        CGFloat scale1 = self.mainImageGroundView.frame.size.width / imageView.frame.size.width;
        CGFloat scale2 = self.mainImageGroundView.frame.size.height / imageView.frame.size.height;
        CGFloat scale = scale1 > scale2 ? scale1 : scale2;
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width * scale, imageView.frame.size.height * scale);
        imageView.center = CGPointMake(self.mainImageGroundView.frame.size.width / 2, self.mainImageGroundView.frame.size.height / 2);
        [self.mainImageGroundView addSubview:imageView];
        
    }
}

- (void)setScore:(NSString *)score{
    if (score) {
        self.scoreLabel.text = [NSString stringWithFormat:@"评分:%@",score];
    }
}
- (void)setCommentary:(NSString *)commentary{
    if (commentary) {
        self.commentaryLabel.text = [NSString stringWithFormat:@"(%@条评论)",commentary];
    }
}
- (void)setReleaseDate:(NSString *)releaseDate{
    if (releaseDate) {
        self.releaseDateLabel.text = [NSString stringWithFormat:@"上映日期:%@",releaseDate];
    }
}
- (void)setRunTime:(NSString *)runTime{
    if (runTime) {
        self.runtimeLabel.text = [NSString stringWithFormat:@"时长:%@",runTime];
    }
}
- (void)setGenres:(NSString *)genres{
    if (genres) {
        self.genresLabel.text = [NSString stringWithFormat:@"类型:%@",genres];
    }
}
- (void)setFilmLocations:(NSString *)filmLocations{
    if (filmLocations) {
        self.filmLocationsLabel.text = [NSString stringWithFormat:@"%@",filmLocations];
    }
}
- (void)setActors:(NSString *)actors{
    if (!actors) {
        return;
    }
    CGSize maxSize = CGSizeMake(_actorsLabel.frame.size.width, 1000);
    NSDictionary *dic = @{NSFontAttributeName:_actorsLabel.font};
    
    CGRect frame = [actors boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    _actorsLabel.text = actors;
    _actorsLabel.frame = CGRectMake(_actorsLabel.frame.origin.x, _actorsLabel.frame.origin.y, frame.size.width, frame.size.height);
//    _actorsLabel.layer.cornerRadius = 5;
//    _actorsLabel.layer.borderWidth = 0.5;
//    _actorsLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.plotSimpleTitleLabel.frame = CGRectMake(self.actorsTitleLabel.frame.origin.x, self.actorsLabel.frame.origin.y + self.actorsLabel.frame.size.height + 10, self.actorsTitleLabel.frame.size.width, self.actorsTitleLabel.frame.size.height);
    self.plotSimpleLabel.frame = CGRectMake(10, self.plotSimpleTitleLabel.frame.size.height + self.plotSimpleTitleLabel.frame.origin.y + 10, kScreenBounds.size.width - 20, 21);
    CGFloat height = self.plotSimpleLabel.frame.size.height + self.plotSimpleLabel.frame.origin.y;
    if (height > self.contentView.frame.size.height - 10) {
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, height + 10);
        self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, height + 10);
        self.backgroundImage.frame = self.contentView.frame;
        self.visualEffectView.frame = self.contentView.frame;
        
    }
    
}

- (void)setPlotSimple:(NSString *)plotSimple{
    if (!plotSimple) {
        return;
    }
    CGSize maxSize = CGSizeMake(_plotSimpleLabel.frame.size.width, 1000);
    NSDictionary *dic = @{NSFontAttributeName:_plotSimpleLabel.font};
    
    CGRect frame = [plotSimple boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    _plotSimpleLabel.text = plotSimple;
    _plotSimpleLabel.frame = CGRectMake(_plotSimpleLabel.frame.origin.x, _plotSimpleLabel.frame.origin.y, frame.size.width, frame.size.height);
    _plotSimpleLabel.layer.cornerRadius = 5;
//    _plotSimpleLabel.layer.borderWidth = 0.1;
    _plotSimpleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    CGFloat height = self.plotSimpleLabel.frame.size.height + self.plotSimpleLabel.frame.origin.y;
    if (height > self.contentView.frame.size.height - 10) {
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, height + 10);
        self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, height + 10);
        self.backgroundImage.frame = self.contentView.frame;
        self.visualEffectView.frame = self.contentView.frame;
        
    }

}

@end
