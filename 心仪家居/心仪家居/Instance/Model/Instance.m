//
//  Instance.m
//  心仪家居
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "Instance.h"

@implementation Instance
- (void)dealloc
{
    [_bimgfile release];
    [_subject release];
//    [_name release];
    [super dealloc];
}





- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }
}



@end
