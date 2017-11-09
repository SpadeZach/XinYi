//
//  SearchViewController.m
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "HomePageModel.h"
#import "SearchTableViewCell.h"
#import "SearchCollectionViewCell.h"
#import "SearchDeatilViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kRestOfScreenHeight kHeight - 49 - 64
#define kInterval 10
@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

//底层tableView
@property(nonatomic, retain)UITableView *tableView;
//搜索数据数组
@property(nonatomic ,retain)NSMutableArray *searchArray;
//无结果文字
@property(nonatomic, retain)UILabel *noResult;
@end

@implementation SearchViewController
- (void)dealloc
{
    [_noResult release];
    [_tableView release];
    [_searchArray release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    
    //searchBar 初始化
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, kWidth, kInterval * 3)];
    searchBar.barTintColor = [UIColor colorWithRed:0.976 green:0.949 blue:0.976 alpha:1.000];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.delegate = self;
    
    [self.view addSubview:searchBar];
    [searchBar release];
    
    //tableView 初始化
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchBar.frame.origin.y + searchBar.frame.size.height, kWidth, kRestOfScreenHeight - searchBar.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //清除背景
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.rowHeight = 240;
    [self.view addSubview:self.tableView];
    [_tableView release];
  

}
#pragma mark searchBar Search按钮点击监测
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //数组初始化
    self.searchArray = [NSMutableArray array];
    
    [searchBar resignFirstResponder];

        NSString *search = [NSString stringWithFormat:@"http://www.shejiben.com/mobile/index.php?action=cases&appid=30&appostype=2&appversion=2.2.0&channel=appstore&idfa=170C1679-6CC9-44DC-B744-F2DF5D7633E1&keywords=%@&module=search&page=1&pageSize=20&systemversion=8.3&t8t_device_id=7E49229C-5F62-4C61-9645-4959F46184CE&to8to_token=&uid=0&version=2.2", searchBar.text];
        search = [search stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:search]];
    //搜索如果为空格替换成+
    NSString *result = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];

        [AKNewWorking GetDataWithURL:result dic:nil success:^(id responseObject) {
            NSDictionary *dictionary = responseObject;
            
            for (NSMutableDictionary *dic in dictionary[@"data"]) {
                
                HomePageModel *homePageModel = [[HomePageModel alloc] init];
                
                [homePageModel setValuesForKeysWithDictionary:dic];
                
                homePageModel.searchText = searchBar.text;
                
                
                [self.searchArray addObject:homePageModel];
            }
            
            if (self.searchArray.count == 0) {
                [self pu];
            }else
            {
                [self.noResult removeFromSuperview];
            }
            [self.tableView reloadData];
        
            
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
            
        }];

}
- (void)pu {
    
    
    
    self.noResult = [[UILabel alloc] init];
    [self.noResult removeFromSuperview];
    self.noResult.text = @"无结果";
    
    self.noResult.textColor = [UIColor colorWithRed:0.504 green:0.820 blue:0.953 alpha:1];
    
    self.noResult.textAlignment = NSTextAlignmentCenter;
    
    self.noResult.font = [UIFont systemFontOfSize:25];
    
    self.noResult.frame = CGRectMake(50, 50, self.tableView.frame.size.width - 100, 100);
    
   
    
    [self.tableView addSubview:self.noResult];
    
    
}

#pragma mark 返回tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchArray.count;
}


#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"cellIden";
    SearchTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden] autorelease];
    }
    cell.homePageModel = self.searchArray[indexPath.row];
    
    //清除背景
    cell.backgroundColor = [UIColor clearColor];
    
    //去除单元格点击后背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}


#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    SearchDeatilViewController *searchDeatilVC = [[SearchDeatilViewController alloc] init];
    
    searchDeatilVC.homePageDetail = self.searchArray[indexPath.row];
    
    [self.navigationController pushViewController:searchDeatilVC animated:YES];
    

    [searchDeatilVC release];

    
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
