//
//  POISearchViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "POISearchViewController.h"
#import "UIDefines.h"

@interface POISearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *poiResultAry;
}
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation POISearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    poiSearch.delegate = self;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    poiSearch.delegate = nil;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGColor;
    [self initPoiSearch];
    [self makeUI];
}

- (void)initPoiSearch{
    poiSearch = [[BMKPoiSearch alloc] init];
    poiSearch.delegate = self;
}
- (void)makeUI{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, NAV_HEIGHT)];
    [self.view addSubview:navView];
    navView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT-0.8, MAINSCREEN_WIDTH, 0.8)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [navView addSubview:line];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, MAINSCREEN_WIDTH-60, 44)];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    [navView addSubview:_searchBar];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self setSearchBarIsFirstResponser:_searchBar];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH-58, 25, 50, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [navView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    [self.view addSubview:_myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}

- (void)setSearchBarIsFirstResponser:(UISearchBar *)searchBar{
    for (UIView *view in searchBar.subviews){
        for (id subview in view.subviews){
            if ( [subview isKindOfClass:[UITextField class]] ){
                [(UITextField *)subview becomeFirstResponder];
                return;
            }
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view endEditing:YES];
    }];
}
#pragma mark - UITableViewDelegate/UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"poiCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    BMKPoiInfo *poi = [poiResultAry objectAtIndex:indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMKPoiInfo *poi;
    poi = [poiResultAry objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectEndAddress" object:poi];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"%@",self.navigationController.viewControllers);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (poiResultAry != nil) {
        return poiResultAry.count;
    }else{
        return 1;
    }
}
#pragma mark - 开始检索
- (void)startPoiSearchWith:(NSString *)searchText{
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc] init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    
    citySearchOption.city = @"烟台";
    citySearchOption.keyword = searchText;
    BOOL flag = [poiSearch poiSearchInCity:citySearchOption];
    
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}
#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    
    
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        poiResultAry = [NSMutableArray array];
        
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            [poiResultAry addObject:poi];
            
            [self.myTableView reloadData];
        }
    }
    
}

#pragma mark - searchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText length]>0) {
        [self startPoiSearchWith:searchText];
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self startPoiSearchWith:searchBar.text];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - 返回前一页
- (void)backToPreView {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
