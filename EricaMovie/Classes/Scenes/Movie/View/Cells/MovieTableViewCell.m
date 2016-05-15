//
//  MovieTableViewCell.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/24.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "MovieTableViewCell.h"

@interface MovieTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *movieImageGroundView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@end
@implementation MovieTableViewCell

- (void)setMovie:(Movie *)movie{
    
    self.movieTitleLabel.text = movie.movieName;
    
}

- (void)setImage:(UIImage *)image{
    if (self.movieImageGroundView.subviews.count != 0)
    if ([self.movieImageGroundView.subviews[0] isKindOfClass:[UIImageView class]]) {
        [self.movieImageGroundView.subviews[0] removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    if (imageView.frame.size.width != 0 && imageView.frame.size.height != 0) {
        
        CGFloat scale1 = _movieImageGroundView.frame.size.width / imageView.frame.size.width;
        CGFloat scale2 = _movieImageGroundView.frame.size.height / imageView.frame.size.height;
        CGFloat scale = scale1 > scale2 ? scale1 : scale2;
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width * scale, imageView.frame.size.height * scale);
        imageView.center = CGPointMake(_movieImageGroundView.frame.size.width / 2, _movieImageGroundView.frame.size.height / 2);
        [_movieImageGroundView insertSubview:imageView atIndex:0];
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
