//
//  IWHomeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHomeViewController.h"
#import "IWBadgeButton.h"
#import "UIBarButtonItem+MJ.h"
#import "IWTitleButton.h"
#import "AFNetworking.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "UIImageView+WebCache.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "IWStatusFrame.h"
#import "MJExtension.h"
#import "IWStatusCell.h"

@interface IWHomeViewController ()
@property (nonatomic, strong) NSArray *statusFrames;
@end

@implementation IWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // 将字典数组转为模型数组(里面放的就是IWStatus模型)
          NSArray *statusArray = [IWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
          
          // 创建frame模型对象
          NSMutableArray *statusFrameArray = [NSMutableArray array];
          for (IWStatus *status in statusArray) {
              IWStatusFrame *statusFrame = [[IWStatusFrame alloc] init];
              // 传递微博模型数据
              statusFrame.status = status;
              [statusFrameArray addObject:statusFrame];
          }
          
          // 赋值
          self.statusFrames = statusFrameArray;
          
          // 刷新表格
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
      }];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    IWTitleButton *titleButton = [IWTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = IWColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, IWStatusTableBorder, 0);
}

- (void)titleClick:(IWTitleButton *)titleButton
{
    if (titleButton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_up"]) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}

- (void)findFriend
{
    IWLog(@"findFriend");
}

- (void)pop
{
    IWLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    IWStatusCell *cell = [IWStatusCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
