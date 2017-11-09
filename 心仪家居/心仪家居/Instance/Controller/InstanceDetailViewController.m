//
//  InstanceDetailViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/26.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "InstanceDetailViewController.h"
#import "Instance.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "InstanceDetailTableViewCell.h"
#import "FirstTableViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import "InstanceDetail.h"
@interface InstanceDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)NSMutableArray *sectionArray;

@property(nonatomic, retain)NSMutableArray *temp;
@property(nonatomic, retain)NSMutableDictionary *dic;
@property(nonatomic, retain)InstanceDetail *detail;

@end

@implementation InstanceDetailViewController

- (void)dealloc
{
    [_detail release];
    [_temp release];
    [_sectionArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.title = self.ins.subject;
    
    //分享按钮
     UIBarButtonItem *firstBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenxiang"] style: UIBarButtonItemStylePlain target:self action:@selector(collect)];
    
    
    self.navigationItem.rightBarButtonItem = firstBarButton;
    
     [firstBarButton release];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];

    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    tableView.backgroundColor = [UIColor colorWithRed:0.148 green:0.148 blue:0.148 alpha:1];
    
    //去掉尾部多余单元格
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    tableView.backgroundColor = [UIColor clearColor];
    
    self.dic = [NSMutableDictionary dictionary];
    
    [self.dic setValue:self.ins.Description forKey:@"Description"];
    
    [self.dic setValue:self.ins.housemap forKey:@"housemap"];
     
    [self.view addSubview:tableView];
    
    [tableView release];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.ins.subject_photo_list.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        
        static NSString *cellIndetify = @"describeAndMap";
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
        if (!cell) {
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
        }

        cell.sdictionary = self.dic;
        
        //去除单元格点击后背景颜色
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        
//        cell.backgroundColor = [UIColor colorWithRed:0.148 green:0.148 blue:0.148 alpha:1];
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else
    {
        static NSString *cellIndetify = @"GGsimida";
        InstanceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
        if (!cell) {
            cell = [[InstanceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];

        }
        
        self.detail = [[InstanceDetail alloc] init];
        
        [self.detail setValuesForKeysWithDictionary:self.ins.subject_photo_list[indexPath.row - 1]];
        
        
        cell.instanceDetail = self.detail;
        
        //去除单元格点击后背景颜色
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
//        cell.backgroundColor = [UIColor colorWithRed:0.148 green:0.148 blue:0.148 alpha:1];
        cell.backgroundColor = [UIColor clearColor];
        [self.detail release];
        
       return cell;
        
    }

}

#pragma mark 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       
        NSString *sring = self.dic[@"Description"];
        
        CGFloat height = [FirstTableViewCell heightOfLabel:sring font:[UIFont systemFontOfSize:17] width:self.view.frame.size.width - 20];
        
        return 200 + height + 25;
       
    }else{

        return 250;
    }
}

- (void)collect
{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
                                     images:self.detail
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
         
     }];
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
