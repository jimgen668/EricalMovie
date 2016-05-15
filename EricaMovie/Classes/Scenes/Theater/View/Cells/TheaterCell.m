//
//  TheaterCell.m
//  EricaMovie
//
//  Created by LakesMac on 15/9/28.
//  Copyright (c) 2015年 LakesMac. All rights reserved.
//

#import "TheaterCell.h"

@interface TheaterCell ()

// w 375 h 184

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *trafficRoutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;

@end

@implementation TheaterCell


- (void)setTheater:(Theater *)theater{
    _theater = theater;   
    self.titleLabel.text = theater.cinemaName;
    self.cityLabel.text = theater.cityName;
    self.addressLabel.text = theater.address;
    self.trafficRoutesLabel.text = theater.trafficRoutes;
    self.telephoneLabel.text = theater.telephone;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
