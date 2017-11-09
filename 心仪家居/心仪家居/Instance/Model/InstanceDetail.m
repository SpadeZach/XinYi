//
//  InstanceDetail.m
//  心仪家居
//
//  Created by dllo on 15/12/26.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "InstanceDetail.h"

@implementation InstanceDetail
- (void)dealloc
{
    [_des release];
    [_bimgfile release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
