//
//  JHGirlViewController.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGirlViewController.h"
#import "MJRefresh.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD+MJ.h"
#import "GankNetApi.h"
#import "MJExtension.h"
#import "JHGank.h"
#import "JHGirlCell.h"
#import "JHNetworkTool.h"
#import "PhotoBroswerVC.h"

/**
 * cell标记
 */
static NSString *ID = @"cell";

/**
 * 页数
 */
static const NSInteger pageSize = 20;

/**
 * flag为标记 防止数据下拉又上拉刷新  造成数据的混乱
 */
static NSUInteger flag = 0;

@interface JHGirlViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
/**
 * 第几页
 */
@property (nonatomic, assign) NSUInteger pageIndex;
/**
 * 数据
 */
@property (nonatomic, strong) NSMutableArray *gankDatas;

@end

@implementation JHGirlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tableView
    [self setupTableView];
    
    // 初始化导航栏标题
    [self setupNav];
    
    // 初始化刷新`
    [self setupRefresh];
}
/**
 *  初始化刷新
 */
-(void)setupRefresh
{
    // 下载刷新
    self.tableView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 上拉加载更多
    self.tableView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 * 上拉加载更多
 */
-(void)loadMoreData
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
    [GankNetApi getGankDataWithType:@"福利" pageSize:pageSize pageIndex:_pageIndex success:^(NSDictionary *dict) {
        
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
 * 下拉刷新
 */
-(void)loadNewData
{
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
    [GankNetApi getGankDataWithType:@"福利" pageSize:pageSize pageIndex:_pageIndex success:^(NSDictionary *dict) {
        if (flag == 1) {
            return;
        }

        _pageIndex ++;
        // 将字典数组转模型数组
        self.gankDatas = [JHGank objectArrayWithKeyValuesArray:dict[@"results"]];
        
        
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
 *  初始化导航栏标题
 */
-(void)setupNav
{
    self.navigationItem.title = @"福利";
}

/**
 * 初始化tableView
 */
-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    //不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];

    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHGirlCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.gankDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHGirlCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.gank = self.gankDatas[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取所有图片的
    NSMutableArray *photosArray = [NSMutableArray array];
    for (int i = 0; i < self.gankDatas.count; i++) {
        JHGank *gank = self.gankDatas[i];
        [photosArray addObject:gank.url];
    }
    // 需要导入第三方的图片浏览器框架
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeModal index:indexPath.row photoModelBlock:^NSArray *{
        NSMutableArray *showImageArray = [NSMutableArray arrayWithCapacity:photosArray.count];
        for (int i = 0; i< photosArray.count; i++) {
            PhotoModel *model = [[PhotoModel alloc] init];
            model.mid = i + 1;
            model.image_HD_U = photosArray[i];
            [showImageArray addObject:model];
        }
        return showImageArray;
    }];
}

@end
