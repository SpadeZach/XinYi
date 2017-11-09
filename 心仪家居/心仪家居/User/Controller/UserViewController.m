//
//  UserViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "UserViewController.h"
#import "CollectViewController.h"
#import "BaseViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableViewCell *cell;
    UISwitch *swichButton;
    UILabel *heheLabel;  //单元格名
    BaseViewController *baseVC;
}

/**
 *  单元格名字数组
 */
@property(nonatomic, retain)NSMutableArray *titleArray;
/**
 *  图标数组
 */
@property(nonatomic, retain)NSMutableArray *imageArray;
@end

@implementation UserViewController
- (void)dealloc
{
    [_titleArray release];
    [_imageArray release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"我的";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    UIImageView *showView = [[UIImageView alloc] init];
    
    showView.image = [UIImage imageNamed:@"[WA0YE(}~AM5REBUUN8D4K4.jpg"];
    
    showView.frame = CGRectMake(0, 64, self.view.frame.size.width, 220);
    
    [self.view addSubview:showView];
    
    [showView release];
    
    
    UITableView *userView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220 + 64, self.view.frame.size.width, self.view.frame.size.height - 220 - 49) style:UITableViewStylePlain];
    
    userView.backgroundColor = [UIColor clearColor];
    
    userView.delegate = self;
    
    userView.dataSource = self;
    
    //单元格高度
    userView.rowHeight = (self.view.frame.size.height - 220 - 64 - 49) / 5;
    
    //去除尾部多余单元格
    userView.tableFooterView = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
    [self.view addSubview:userView];
    
    [userView release];
  

    self.titleArray = [NSMutableArray arrayWithObjects:@"退出分享", @"收藏", @"夜间模式", @"清空缓存",nil];;
    
    
    self.imageArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"Indeaslkd";
    cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
 
    //图片
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[indexPath.row]]];
    
    cell.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width / 4, self.view.frame.size.height);
    
    //清除背景
    cell.backgroundColor = [UIColor clearColor];
    
    //文字数组
    heheLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.imageView.frame.size.width + 10, 15, 200, 30)];
    
    heheLabel.backgroundColor = [UIColor clearColor];
    
    heheLabel.text = self.titleArray[indexPath.row];
    
    heheLabel.textColor = [UIColor lightGrayColor];
    [cell addSubview:heheLabel];
    
    //去除单元格点击背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    // 夜间模式开关
    if ([heheLabel.text containsString:@"夜间模式"]) {
        swichButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, (self.view.frame.size.height - 220 - 64 - 49) / 20, 20, 20)];
        [cell addSubview:swichButton];
        swichButton.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [swichButton addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
        
    }

    return cell;
}

-(void)switchIsChanged:(UISwitch *)paramSender{
    
    if ([paramSender isOn]) {
        NSLog(@"开关打开");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ye"];

        baseVC = [[BaseViewController alloc] init];
        baseVC.view.backgroundColor = [UIColor colorWithRed:0.148 green:0.148 blue:0.148 alpha:1];

        
       
        //广播携带的数据，为字典类型
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:baseVC.view.backgroundColor, @"color", nil];
        //发送广播(向所有人发送广播)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:self userInfo:dic];
        
    }else{
      
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ye"];
        
        baseVC =[[BaseViewController alloc] init];
        baseVC.view.backgroundColor = [UIColor whiteColor];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:baseVC.view.backgroundColor, @"color", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:self userInfo:dic];
        
        
        NSLog(@"开关闭合");
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            BOOL hasAuthotized = [ShareSDK hasAuthorized:SSDKPlatformTypeSinaWeibo] ;
            
            
            if (hasAuthotized ) {
                NSLog(@"%d" , hasAuthotized);
                
                
                [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo  ] ;
                
                UIAlertController  *  waring = [UIAlertController alertControllerWithTitle:@"分享授权已取消" message:@"" preferredStyle:UIAlertControllerStyleAlert] ;
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [waring addAction:action ];
                
                [self presentViewController:waring animated:YES completion:nil ] ;
                
                
                
            }else
            {
                
                UIAlertController  *  waring = [UIAlertController alertControllerWithTitle:@"您尚未授权分享" message:@"" preferredStyle:UIAlertControllerStyleAlert] ;
                
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [waring addAction:action ];
                
                [self presentViewController:waring animated:YES completion:nil ] ;
                
                
                
            }

        }
            break;
        
        case 1:{
            CollectViewController *collectVC = [[CollectViewController alloc] init];
            
            [self.navigationController pushViewController:collectVC animated:YES];
            
            
        }
            break;
        
        case 2:
            
            
            break;
       
        default:{
            //获取cache文件夹地址
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            //缓存的大小
            CGFloat fileSize = [self folderSizeAtPath:cachPath];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否清理缓存%.2fMB",fileSize] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
            [alert release];
       
        }
            break;
    }
}
-(CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:folderPath]) {
            return 0;
        }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
    NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        
        
        dispatch_async(
                       
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                       
                       , ^{
                           
                           NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                           
                           
                           NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                           
                           NSLog(@"files :%lu",(unsigned long)[files count]);
                           
                           for (NSString *p in files) {
                               
                               NSError *error;
                               
                               NSString *path = [cachPath stringByAppendingPathComponent:p];
                               
                               if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                   
                                   [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   
                               }
                               
                           }
                       });

    }
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
