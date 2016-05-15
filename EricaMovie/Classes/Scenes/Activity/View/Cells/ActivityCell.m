//
//  ActivityCell.m
//  EricaMovie
//
//  Created by jimgen668 on 15/9/23.
//  Copyright (c) 2015年 jimgen668. All rights reserved.
//

#import "ActivityCell.h"
#import "Activity.h"

@interface ActivityCell ()
@property (weak, nonatomic) IBOutlet UIView *activityImageGroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeIconView;

@end
@implementation ActivityCell


- (void)setActivity:(Activity *)activity{
    
    self.titleLabel.text = activity.title;
    self.typelabel.text = activity.category_name;
    self.locationLabel.text = activity.address;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@",activity.begin_time,activity.end_time];
    self.joinLabel.text = activity.wisher_count.stringValue;
    self.likeLabel.text = activity.participant_count.stringValue;
    
}
- (void)setImage:(UIImage *)image{
    
    if ([self.activityImageGroundView.subviews[0] isKindOfClass:[UIImageView class]]) {
        [self.activityImageGroundView.subviews[0] removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    if (imageView.frame.size.width != 0 && imageView.frame.size.height != 0) {
        
        CGFloat scale1 = _activityImageGroundView.frame.size.width / imageView.frame.size.width;
        CGFloat scale2 = _activityImageGroundView.frame.size.height / imageView.frame.size.height;
        CGFloat scale = scale1 > scale2 ? scale1 : scale2;
        imageView.frame = CGRectMake(0, 0, imageView.frame.size.width * scale, imageView.frame.size.height * scale);
        imageView.center = CGPointMake(_activityImageGroundView.frame.size.width / 2, _activityImageGroundView.frame.size.height / 2);
        [_activityImageGroundView insertSubview:imageView atIndex:0];

        
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
