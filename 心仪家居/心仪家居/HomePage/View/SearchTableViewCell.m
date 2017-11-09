//
//  SearchTableViewCell.m
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "HomePageModel.h"
#import "UIImageView+WebCache.h"
@implementation SearchTableViewCell
- (void)dealloc
{
    [_searchText release];
    [_areaNameLabel release];
    [_nameLabel release];
    [_imgUrlPic release];
    [_spaceNameLabel release];
    [_styleNameLabel release];
    [_countsLabel release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
    self.areaNameLabel = [[UILabel alloc]init];
    self.areaNameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.areaNameLabel];
    [_areaNameLabel release];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
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
    
    self.styleNameLabel.frame = CGRectMake(self.spaceNameLabel.frame.origin.x + self.spaceNameLabel.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 60, 20);
    
    self.countsLabel.frame = CGRectMake(self.styleNameLabel.frame.origin.x + self.styleNameLabel.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 3, 80, 20);
    
}
- (void)setHomePageModel:(HomePageModel *)homePageModel
{
    if (_homePageModel != homePageModel) {
        [_homePageModel release];
        _homePageModel = [homePageModel retain];
    }
    [self.imgUrlPic sd_setImageWithURL:[NSURL URLWithString:homePageModel.imgUrl]];
    self.nameLabel.text = homePageModel.name;
    self.areaNameLabel.text = homePageModel.areaName;
    self.spaceNameLabel.text = homePageModel.spaceName;
    self.styleNameLabel.text = [NSString stringWithFormat:@"/  %@", homePageModel.styleName];
    self.countsLabel.text = [NSString stringWithFormat:@"/  %@图",homePageModel.counts];
    //搜索内容高亮
    self.searchText = _homePageModel.searchText;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:_homePageModel.name];
    NSRange range = [_homePageModel.name rangeOfString:self.searchText];
    
    [attributeString addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:range];
    self.nameLabel.attributedText = attributeString;
    [attributeString release];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
