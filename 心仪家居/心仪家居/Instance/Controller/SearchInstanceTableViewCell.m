//
//  SearchInstanceTableViewCell.m
//  心仪家居
//
//  Created by 赵博 on 16/1/5.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchInstanceTableViewCell.h"
#import "Instance.h"
#import "UIImageView+WebCache.h"
@implementation SearchInstanceTableViewCell
- (void)dealloc
{
    [_bimgfilePic release];
    [_subjectLabel release];
    [_style_info release];
    [_housetype_info release];
    [_name1 release];
    [_name2 release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bimgfilePic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.bimgfilePic];
        [_bimgfilePic release];
        
        self.subjectLabel = [[UILabel alloc] init];
        self.subjectLabel.textAlignment = NSTextAlignmentCenter;
        self.subjectLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.subjectLabel];
        [_subjectLabel release];
        
        self.name1 = [[UILabel alloc] init];
        self.name1.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.name1];
        [self.name1 release];
        
        self.name2 = [[UILabel alloc] init];
        self.name2.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.name2];
        [self.name2 release];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bimgfilePic.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 3);
}


- (void)setInstance:(Instance *)instance
{
    if (_instance != instance) {
        [_instance release];
        _instance = [instance retain];
    }
    
    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:instance.bimgfile]];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
