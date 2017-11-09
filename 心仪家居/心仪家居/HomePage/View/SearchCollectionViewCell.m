//
//  SearchCollectionViewCell.m
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HomePageDetail.h"
@implementation SearchCollectionViewCell

- (void)dealloc
{
    [_commentLabel release];
    [_urlPic release];
    [super dealloc];
}
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.urlPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.urlPic];
        
    }
    return self;
}
//位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.urlPic.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    
}
//重写set方法
- (void)setHomePageDetail:(HomePageDetail *)homePageDetail
{
    if (_homePageDetail != homePageDetail) {
        [_homePageDetail release];
        _homePageDetail = [homePageDetail retain];
    }
    [self.urlPic sd_setImageWithURL:[NSURL URLWithString:_homePageDetail.imgUrl]];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
