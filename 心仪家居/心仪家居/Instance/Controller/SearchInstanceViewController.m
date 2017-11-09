//
//  SearchInstanceViewController.m
//  心仪家居
//
//  Created by 赵博 on 16/1/5.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchInstanceViewController.h"
#import "AFNetworking.h"
#import "Instance.h"
#import "MBProgressHUD.h"
#import "SearchInstanceTableViewCell.h"
#import "SearchInstanceDetailViewController.h"
@interface SearchInstanceViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
//底层tableView
@property(nonatomic, retain)UITableView *tableView;


//搜索数据数组
@property(nonatomic ,retain)NSMutableArray *searchArray;


@end

@implementation SearchInstanceViewController
- (void)dealloc
{
    [_tableView release];
    [_searchArray release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    //searchBar 初始化
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    searchBar.barTintColor = [UIColor colorWithRed:0.976 green:0.949 blue:0.976 alpha:1.000];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar release];
    //tableView 初始化
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchBar.frame.origin.y + searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - searchBar.frame.size.height) style:UITableViewStylePlain];
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
    
    NSString *search = [NSString stringWithFormat:@"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=search_photo&keyword=%@&page=1&pagesize=24&v=6.0", searchBar.text];
    search = [search stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:search]];
    
    [AKNewWorking GetDataWithURL:search dic:nil success:^(id responseObject) {

        
        NSArray *array =  responseObject;
        
        self.searchArray = [NSMutableArray array];
        
        for (NSDictionary *dictionary in array) {
            
            
            Instance *instance = [[Instance alloc] init];
            
            [instance setValuesForKeysWithDictionary:dictionary];
            
            [self.searchArray addObject:instance];
            
        }
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        //如果超时取消网络菊花
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];
        [self.tableView reloadData];
        
        
    } filed:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
}

#pragma mark 网络请求超时执行
- (void)stopReload
{
    [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
}

#pragma mark 返回tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchArray.count;
}


#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"cellIden";
    SearchInstanceTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[[SearchInstanceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden] autorelease];
    }
    cell.instance = self.searchArray[indexPath.row];
    
    //清除背景
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SearchInstanceDetailViewController *searchDeatilVC = [[SearchInstanceDetailViewController alloc] init];
    
    searchDeatilVC.instanceDetail = self.searchArray[indexPath.row];
    
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
