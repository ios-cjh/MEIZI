//
//  JHOtherViewController.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHOtherViewController.h"
#import "UIScrollView+PullBig.h"
#import "JHOtherCell.h"
#import "SDImageCache.h"
#import "JHFileTool.h"
#import "MBProgressHUD+MJ.h"

@interface JHOtherViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIImageView *topView;
@end

@implementation JHOtherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //距离顶部的调整
    self.automaticallyAdjustsScrollViewInsets = NO;

    // 初始化TableView
    [self setupTableView];
    
    // 初始化顶部图片
    [self setupTopView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
    
    [[JHStatusBarViewController shareInstance] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView reloadData];

}

/**
 * 初始化顶部图片
 */
-(void)setupTopView
{
    // 1.设置顶部图片
    UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GankTop"]];
    topView.contentMode = UIViewContentModeScaleAspectFill;
    topView.userInteractionEnabled = YES;
    topView.frame = CGRectMake(0, 0, JHScreenWidth, JHScreenHight * 0.42);
    [self.tableView setBigView:topView withHeaderView:nil];
    self.topView = topView;
    
    // 2.在图片添加点击手势识别
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAlertSheet)];
    [self.topView addGestureRecognizer:tapGesture];
    
    // 3.获得最新发图片替换
    UIImage *topImage = [JHFileTool getImageFromLocalImageName:@"topImage.png"];
    if (topImage) {
        self.topView.image = topImage;
    }
}

-(void)showAlertSheet
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"背景图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *imageSelectAction = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImage];
    }];
    UIAlertAction *sourceImageAction = [UIAlertAction actionWithTitle:@"还原默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sourceImage];
    }];
    [alertVc addAction:cancelAction];
    [alertVc addAction:imageSelectAction];
    [alertVc addAction:sourceImageAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}
/**
 * 还原默认图片
 */
-(void)sourceImage
{
    UIImage *topImage = [UIImage imageNamed:@"GankTop"];
    self.topView.image = topImage;
    // 保存图片
    [JHFileTool saveImageToLocal:topImage imageName:@"topImage.png"];
}

/**
 * 图片选择
 */
-(void)chooseImage
{
    // 创建图像选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    // 允许编辑
    ipc.allowsEditing = YES;
    // 设置代理
    ipc.delegate = self;
    // 类型
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 显示图像选择控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //UIImagePickerControllerEditedImage:裁剪的
    //UIImagePickerControllerOriginalImage:原图
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.topView.image = image;
}


/**
 * 初始化TableView
 */
-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    // 去掉分组形式的第一行空隙
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.size.width, CGFLOAT_MIN)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(section == 0){
        return 3;
    }else if(section == 1){
        return 2;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    JHOtherCell *cell = [JHOtherCell cellWithTableView:tableView];
    
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"我的收藏";
                break;
            case 1:
                cell.textLabel.text = @"点个赞";
                break;
            case 2:
                cell.textLabel.text = @"推荐";
                break;
        }
    } else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"清除缓存";
                
                cell.detailTextLabel.text = [JHFileTool getCacheSizeStr];
                cell.accessoryType = UITableViewCellAccessoryNone;
                break;
            case 1:
                cell.textLabel.text = @"关于";
                break;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"pushToCollectPage");
                break;
            case 1:
                NSLog(@"giveStar");
                break;
            case 2:
                NSLog(@"recommend");
                break;
               
            default:
                break;
        }
    } else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                
                [self showClearCacheAlert];
                break;
            case 1:
                NSLog(@"about");
                break;

            default:
                break;
        }
    }
}

-(void)showClearCacheAlert
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定要清除缓存吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 清除缓存
        NSLog(@"clearCache--");
        [[SDImageCache sharedImageCache] clearDisk];
        [MBProgressHUD showSuccess:@"清除完成"];
        [self.tableView reloadData];

    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertVc addAction:sureAction];
    [alertVc addAction:cancelAction];
    
    
    [self presentViewController:alertVc animated:YES completion:nil];

}



@end
