//
//  HomePageViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "HomePageViewController.h"
#import "AFNetworking.h" 
#import "HeaderCollectionReusableView.h"
#import "HomePageModel.h"
#import "HomePageCollectionViewCell.h"
#import "HomePageDetailViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "DataBaseLast.h"
#import "SearchViewController.h"
@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//控制数组
@property(nonatomic, retain)NSMutableArray *sectionArray;

@property(nonatomic, retain)UICollectionView *collectionView;

@property(nonatomic, retain)HomePageModel *homePageModel;

@property(nonatomic, copy)NSString *ID;

@end

@implementation HomePageViewController
- (void)dealloc
{
    [_homePageModel release];
    [_ID release];
    [_collectionView release];
    [_sectionArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"首页";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //搜索
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtn)];
    
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //打开数据库
    [[DataBaseLast defaultDataBaseLast]openDatabase];
    
    //创建CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    //分区头大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 49) collectionViewLayout:layout];
    //设置颜色
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.collectionView registerClass:[HomePageCollectionViewCell class] forCellWithReuseIdentifier:@"intef"];
    
    //注册分区头视图
    [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //遵循协议
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
 
    
    // 状态栏网络菊花
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];


    //解析第一页数据
    [AKNewWorking GetDataWithURL:@"http://www.shejiben.com/mobile/index.php?action=home&appid=30&appostype=2&appversion=2.2.0&area=0&channel=appstore&idfa=170C1679-6CC9-44DC-B744-F2DF5D7633E1&module=cases&page=1&price=0&style=0&systemversion=8.3&t8t_device_id=7E49229C-5F62-4C61-9645-4959F46184CE&to8to_token=&type=0&uid=0&version=2.2" dic:nil success:^(id responseObject) {
 
        NSDictionary *dictionary = responseObject;
        
        self.sectionArray = [NSMutableArray array];
        
        for (NSMutableDictionary *dic in dictionary[@"data"]) {
            
            HomePageModel *homePageModel = [[HomePageModel alloc] init];
            
            [homePageModel setValuesForKeysWithDictionary:dic];
            
            [self.sectionArray addObject:homePageModel];
        }
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
        //如果超时取消网络菊花
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
        [self.collectionView reloadData];
        
    } filed:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];

    
    
    
    /**************** 下拉刷新 ****************/
   
    [self refreshData];
    
    /**************** 上拉加载 ****************/
    static int i = 2;
    
    i++;
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"http://www.shejiben.com/mobile/index.php?action=home&appid=30&appostype=2&appversion=2.2.0&area=0&channel=appstore&idfa=170C1679-6CC9-44DC-B744-F2DF5D7633E1&module=cases&page=%d&price=0&style=0&systemversion=8.3&t8t_device_id=7E49229C-5F62-4C61-9645-4959F46184CE&to8to_token=&type=0&uid=0&version=2.2", i] dic:nil success:^(id responseObject) {
            
            NSDictionary *dictionary = responseObject;
            
            for (NSMutableDictionary *dic in dictionary[@"data"]) {
                
                HomePageModel *homePageModel = [[HomePageModel alloc] init];
                
                [homePageModel setValuesForKeysWithDictionary:dic];
                
                [self.sectionArray addObject:homePageModel];
            }
            // 状态栏网络菊花
            [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
            //如果超时取消网络菊花
            [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
            [self.collectionView reloadData];
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];
        
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
        
        
    }];
 
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView release];
  
}

- (void)refreshData
{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [AKNewWorking GetDataWithURL:@"http://www.shejiben.com/mobile/index.php?action=home&appid=30&appostype=2&appversion=2.2.0&area=0&channel=appstore&idfa=170C1679-6CC9-44DC-B744-F2DF5D7633E1&module=cases&page=1&price=0&style=0&systemversion=8.3&t8t_device_id=7E49229C-5F62-4C61-9645-4959F46184CE&to8to_token=&type=0&uid=0&version=2.2" dic:nil success:^(id responseObject) {
            
            NSDictionary *dictionary = responseObject;
            
            self.sectionArray = [NSMutableArray array];
            
            for (NSMutableDictionary *dic in dictionary[@"data"]) {
                
                HomePageModel *homePageModel = [[HomePageModel alloc] init];
                
                [homePageModel setValuesForKeysWithDictionary:dic];
                
                [self.sectionArray addObject:homePageModel];
            }
           
            
            [self.collectionView reloadData];
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];
        
        
        
        [self.collectionView.mj_header endRefreshing];
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
        //如果超时取消网络菊花
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
        [self.collectionView reloadData];
        
        
    }];

}

- (void)stopReload
{
    [MBProgressHUD hideAllHUDsForView:self.collectionView animated:YES];
}

#pragma mark Itmes数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}
#pragma mark Items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"intef" forIndexPath:indexPath];

    cell.homePageModel = self.sectionArray[indexPath.row];
    
    BOOL isExist = [[DataBaseLast defaultDataBaseLast]searchOneBase:cell.homePageModel];
    
    NSString *imageString = nil;
    
    if (isExist) {
        imageString = @"star-selected";
    }else
    {
        imageString = @"star-normal";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button.tag = indexPath.row + 1000;
    
    button.frame = CGRectMake(self.view.frame.size.width - 10 - 30, 210, 25, 25);
    
    //按钮状态
    button.selected = isExist;
    
    
    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    
    [cell addSubview:button];
    
    return cell;
}

- (void)collectionAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"star-selected"] forState:UIControlStateNormal];
        [[DataBaseLast defaultDataBaseLast] insertOneBase:self.sectionArray[sender.tag - 1000]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        [alert release];
        
        
        NSLog(@"收藏");
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"star-normal"] forState:UIControlStateNormal];
        [[DataBaseLast defaultDataBaseLast] removeOneBase:self.sectionArray[sender.tag - 1000]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        [alert release];
        [self.collectionView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}


#pragma mark 单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 240);
}

#pragma mark 边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 60, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageDetailViewController *homePageDetai = [[HomePageDetailViewController alloc] init];
    
    homePageDetai.homePageModel = self.sectionArray[indexPath.row];
    
    [self.navigationController pushViewController:homePageDetai animated:YES];
}

#pragma mark  分区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    return header;
}
#pragma mark 搜索点击
- (void)searchBtn
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
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
