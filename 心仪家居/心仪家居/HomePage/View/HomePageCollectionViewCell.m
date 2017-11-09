//
//  HomePageCollectionViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "HomePageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HomePageModel.h"
@implementation HomePageCollectionViewCell
- (void)dealloc
{
    [_areaNameLabel release];
    [_nameLabel release];
    [_imgUrlPic release];
    [_spaceNameLabel release];
    [_styleNameLabel release];
    [_countsLabel release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.areaNameLabel = [[UILabel alloc]init];
        self.areaNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.areaNameLabel];
        [_areaNameLabel release];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.nameLabel];
        [_nameLabel release];
        
        self.imgUrlPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgUrlPic];
        [_imgUrlPic release];
        
        self.spaceNameLabel = [[UILabel alloc] init];
        self.spaceNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.spaceNameLabel];
        [_spaceNameLabel release];
        
        self.styleNameLabel = [[UILabel alloc] init];
        self.styleNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.styleNameLabel];
        [_styleNameLabel release];
        
        self.countsLabel = [[UILabel alloc] init];
        self.countsLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.countsLabel];
        [_countsLabel release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //图片
    self.imgUrlPic.frame = CGRectMake(0, 0, self.frame.size.width, 180);
    //标题
    self.nameLabel.frame = CGRectMake(20, self.imgUrlPic.frame.origin.y + self.imgUrlPic.frame.size.height + 10, self.frame.size.width - 20 - 20, 20);
    //平数
    self.areaNameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 50, 20);
    
    self.spaceNameLabel.frame = CGRectMake(self.areaNameLabel.frame.origin.x + self.areaNameLabel.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 60, 20);
    
    self.styleNameLabel.frame = CGRectMake(self.spaceNameLabel.frame.origin.x + self.spaceNameLabel.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 75, 20);
    
    self.countsLabel.frame = CGRectMake(self.styleNameLabel.frame.origin.x + self.styleNameLabel.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 80, 20);
    
}
- (void)setHomePageModel:(HomePageModel *)homePageModel
{
    if (_homePageModel != homePageModel) {
        [_homePageModel release];
        _homePageModel = [homePageModel retain];
    }
    [self.imgUrlPic sd_setImageWithURL:[NSURL URLWithString:homePageModel.imgUrl] placeholderImage:[UIImage imageNamed:@"zhanwei"]];

    self.nameLabel.text = homePageModel.name;
    self.areaNameLabel.text = homePageModel.areaName;
    self.spaceNameLabel.text = homePageModel.spaceName;
    self.styleNameLabel.text = [NSString stringWithFormat:@"/  %@", homePageModel.styleName];
    self.countsLabel.text = [NSString stringWithFormat:@"/  %@图",homePageModel.counts];
}

@end
