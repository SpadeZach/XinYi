
//
//  InstanceTableViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "InstanceTableViewCell.h"
#import "Instance.h"
#import "UIImageView+WebCache.h"


@implementation InstanceTableViewCell
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
    self.bimgfilePic.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 50);
    self.subjectLabel.frame = CGRectMake(20, self.bimgfilePic.frame.origin.y + self.bimgfilePic.frame.size.height + 5, self.frame.size.width - 40, 20);
//    NSLog(@"%@",self.name1);
    
    self.name1.frame = CGRectMake(20, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height + 5, 80, 20);
    
    self.name2.frame = CGRectMake(self.name1.frame.origin.x + self.name1.frame.size.width, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height + 5, 80, 20);
}


- (void)setInstance:(Instance *)instance
{
    if (_instance != instance) {
        [_instance release];
        _instance = [instance retain];
    }
    
    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:instance.bimgfile] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
//    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:instance.bimgfile]];
    self.subjectLabel.text = instance.subject;
        
    self.name1.text = [NSString stringWithFormat:@"#%@",instance.name1];

    self.name2.text = [NSString stringWithFormat:@"#%@",instance.name2];
}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
