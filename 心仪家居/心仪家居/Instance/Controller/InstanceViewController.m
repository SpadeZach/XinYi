//
//  InstanceViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "InstanceViewController.h"
#import "AFNetworking.h"
#import "Instance.h"
#import "InstanceTableViewCell.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "InstanceDetailViewController.h"

@interface InstanceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UITableView *tableView;

//接受model数组
@property(nonatomic, retain)NSMutableArray *sectionArray;


@end

@implementation InstanceViewController
- (void)dealloc
{
    [_sectionArray release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"实例";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatTabelView];
    
    
    self.tableView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:self.tableView];
    
    [_tableView release];
    
}

- (void)creatTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 49 - 64) style:UITableViewStylePlain];
    
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    //去掉尾部多余单元格
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //解数据
    [self getData];
   
}

//实现超时取消网络菊花
- (void)stopReload
{
    [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
}



- (void)getData
{
    // 状态栏网络菊花
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    
    [AKNewWorking GetDataWithURL:@"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=subject_list&page=1&pagesize=24&v=6.0" dic:nil success:^(id responseObject) {
       
        NSArray *array =  responseObject;
        
        self.sectionArray = [NSMutableArray array];
        
        for (NSDictionary *dictionary in array) {
            
            
            Instance *instance = [[Instance alloc] init];
            
            [instance setValuesForKeysWithDictionary:dictionary];
            
            if (dictionary[@"housetype_info"] != [NSNumber numberWithBool:0]) {
                
                NSDictionary *housetype_info = dictionary[@"housetype_info"];
                
                NSString *name1 = housetype_info[@"name"];
                
                instance.name1 = name1;
            }
            
            NSDictionary *style_info = dictionary[@"style_info"];
            
            NSString *name2 = style_info[@"name"];
            
            instance.name2 = name2;
            
            
            
            
            [self.sectionArray addObject:instance];
  
        }
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        //如果超时取消网络菊花
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
        [self.tableView reloadData];
        
        
    } filed:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
    //下拉刷新数据
    [self refreshData];
    
    //上拉加载数据
    [self loadData];
}

- (void)refreshData;
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 状态栏网络菊花
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        
        
        [AKNewWorking GetDataWithURL:@"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=subject_list&page=1&pagesize=24&v=6.0" dic:nil success:^(id responseObject) {
            
            NSArray *array =  responseObject;
            
            self.sectionArray = [NSMutableArray array];
            
            for (NSDictionary *dictionary in array) {
                
                
                Instance *instance = [[Instance alloc] init];
                
                [instance setValuesForKeysWithDictionary:dictionary];
                
                
                
                
                if (dictionary[@"housetype_info"] != [NSNumber numberWithBool:0]) {
                    
                    NSDictionary *housetype_info = dictionary[@"housetype_info"];
                    
                    NSString *name1 = housetype_info[@"name"];
                    
                    instance.name1 = name1;
                }
                
                NSDictionary *style_info = dictionary[@"style_info"];
                
                NSString *name2 = style_info[@"name"];
                
                instance.name2 = name2;

                
                [self.sectionArray addObject:instance];
                
            }
            //如果超时取消网络菊花
            [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
            [self.tableView reloadData];
            
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];

        [self.tableView.mj_header endRefreshing];
        
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        
        [self.tableView reloadData];
    }];
}


- (void)loadData
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 状态栏网络菊花
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        
        static int i = 1;
        
        i++;
        
        [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=subject_list&page=%d&pagesize=24&v=6.0",i] dic:nil success:^(id responseObject) {
            
             NSArray *array = responseObject;
            
            for (NSDictionary *dictionary in array) {
                
                
                Instance *instance = [[Instance alloc] init];
       
                [instance setValuesForKeysWithDictionary:dictionary];
        
                
                
                if (dictionary[@"housetype_info"] != [NSNumber numberWithBool:0]) {
                    
                    NSDictionary *housetype_info = dictionary[@"housetype_info"];
                    
                    NSString *name1 = housetype_info[@"name"];
                    
                    instance.name1 = name1;
                }
                
                if (dictionary[@"style_info"] != [NSNumber numberWithBool:0]) {

                    NSDictionary *style_info = dictionary[@"style_info"];

                    NSString *name2 = style_info[@"name"];

                    instance.name2 = name2;

                }

                
                [self.sectionArray addObject:instance];
                
            }
            
            
            // 状态栏网络菊花
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            //如果超时取消网络菊花
            [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
            [self.tableView reloadData];
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];
        
        [self.tableView.mj_footer endRefreshing];
        
        
        
        [self.tableView reloadData];

        
        
    }];
}



#pragma mark 返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"🍉%ld", self.sectionArray.count);
    return self.sectionArray.count;
}

#pragma mark 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetify = @"Indetify";
    InstanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (!cell) {
        
        cell = [[InstanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
    }
    cell.instance = self.sectionArray[indexPath.row];
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //清除背景
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstanceDetailViewController *instanceDVC = [[InstanceDetailViewController alloc] init];
    
    instanceDVC.ins = self.sectionArray[indexPath.row];
    
//    NSLog(@"%@", self.initialArray[indexPath.row]);
    
    [self.navigationController pushViewController:instanceDVC animated:YES];
    
    [instanceDVC release];
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
