//
//  JHGankBaseController.m
//  妹子
//
//  Created by cjj on 16/7/8.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGankBaseController.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "JHNetworkTool.h"
#import "GankNetApi.h"
#import "MJExtension.h"
#import "JHGank.h"
#import "JHGankBaseCell.h"

/**
 *  每页加载的大小
 */
static const NSInteger pageSize = 20;
/**
 *  标记,防止网络不好既上啦又下拉，照成数据混乱，以最后一次为主
 */
static NSInteger flag = 0;
// cell标记
static NSString *ID = @"cell";


@interface JHGankBaseController ()
/**
 *  第几页数据
 */
@property(nonatomic,assign)NSInteger pageIndex;

/**
 * 数据
 */
@property (nonatomic, strong) NSMutableArray *gankDatas;

@end

@implementation JHGankBaseController

// lazy init
-(NSMutableArray *)gankDatas
{
    if (_gankDatas == nil) {
        _gankDatas = [NSMutableArray array];
    }
    return _gankDatas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tableview
    [self setupTableView];
    
    // 初始化刷新控件
    [self setupRefresh];

}
/**
 * 初始化刷新控件
 */
-(void)setupRefresh
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 上拉加载更多
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 * 上拉加载更多
 */
-(void) loadMoreData
{
    //判断有没有网络
    if(![JHNetworkTool isExistenceNetwork]){
        [MBProgressHUD showError:@"检查你的网络设置"];
        //结束刷新
        [self.tableView.footer endRefreshing];
        return;
    }
    
    //网络状态
    [JHNetworkTool showNetWorkActivityIndicator:YES];
    
    flag = 1;
    [GankNetApi getGankDataWithType:_gankDataType pageSize:pageSize pageIndex:_pageIndex success:^(NSDictionary *dict) {
        
        if(flag == 0){
            return;
        }
        //页码+1
        _pageIndex ++;
        
        //字典转模型
        NSMutableArray *newDatas = [JHGank objectArrayWithKeyValuesArray:dict[@"results"]];
        
        
        //判断新的数据和旧的数据有没有一样的
        JHGank *gank;
        JHGank *gankNew;
        for (int i=0; i<self.gankDatas.count; i++) {
            gank = self.gankDatas[i];
            for (int j= 0; j<newDatas.count; j++) {
                gankNew = newDatas[j];
                if([gankNew._id isEqualToString:gank._id]){
                    NSLog(@"移除：%@",gankNew.desc);
                    //移除出集合
                    [newDatas removeObjectAtIndex:j];
                }
            }
        }
        
        if(newDatas!=nil && newDatas.count>0){
            // 把请求的数组放到当前类别的数组集合中去
            [self.gankDatas addObjectsFromArray:newDatas];
        }
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.footer endRefreshing];
        //网络状态
        [JHNetworkTool showNetWorkActivityIndicator:NO];
        
    } failure:^(NSString *text) {
        //结束刷新
        [self.tableView.footer endRefreshing];
        //网络状态
        [JHNetworkTool showNetWorkActivityIndicator:NO];
    }];

}

/**
 * 加载新数据
 */
-(void)loadNewData
{
    NSLog(@"loadNewData---");
    // 判断有木有网络
    if(![JHNetworkTool isExistenceNetwork]){
        [MBProgressHUD showError:@"请检查您的网络设置"];
        // 结束刷新
        [self.tableView.header endRefreshing];
        return;
    }
    
    // 是否显示网络指示器状态
    [JHNetworkTool showNetWorkActivityIndicator:YES];
    
    _pageIndex = 1;
    
    flag = 0;
    [GankNetApi getGankDataWithType:_gankDataType pageSize:pageSize pageIndex:_pageIndex success:^(NSDictionary *dict) {
        if (flag == 1) {
            return;
        }
        
        _pageIndex ++;
        // 将字典数组转模型数组
        self.gankDatas = [JHGank objectArrayWithKeyValuesArray:dict[@"results"]];
        
        NSLog(@"---%@",dict[@"results"]);
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏底部的上拉控件
        [self.tableView.footer setHidden:YES];
        
        // 结束刷新控件
        [self.tableView.header endRefreshing];
        
    } failure:^(NSString *text) {
        NSLog(@"失败---");
        // 结束刷新控件
        [self.tableView.header endRefreshing];
        [JHNetworkTool showNetWorkActivityIndicator:NO];
    }];

}


/**
 * 初始化tableview
 */
-(void)setupTableView
{
    // 距离顶部的调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHGankBaseCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //设置高度自适应：IOS 8.0 >
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gankDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHGankBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.gank = self.gankDatas[indexPath.row];
    return cell;
}

@end
