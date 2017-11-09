//
//  BaseViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/31.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ye"]) {
        self.view.backgroundColor = [UIColor colorWithRed:0.148 green:0.148 blue:0.148 alpha:1];

    }else
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    
    //消息注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"changeColor" object:nil];

}

#pragma mark 接收消息时，执行的方法 开关打开
-(void)notificationAction:(NSNotification *)notification
{
    
    self.view.backgroundColor = [notification.userInfo objectForKey:@"color"];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
