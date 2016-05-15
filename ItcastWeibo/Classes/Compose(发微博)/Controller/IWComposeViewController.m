//
//  IWComposeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/**
 UITextField ： 不能换行
 UITextView ：没有提示文字
 */

#import "IWComposeViewController.h"
#import "IWTextView.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWWeiboTool.h"
#import "IWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWComposeToolbar.h"


@interface IWComposeViewController ()<UITextViewDelegate>
@property (nonatomic, weak) IWTextView *textView;
@end

@implementation IWComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
}



/**
 *  添加Toolbar
 */
-(void)setupToolbar
{
    IWComposeToolbar *toolbar = [[IWComposeToolbar alloc] init];
    
    // 设置frame
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;  // 宽度为view的宽度
    CGFloat toolbarX = 0;   // 位置，在最左边
    CGFloat toolbarY = self.view.frame.size.height; // 无键盘时的toolbar高度
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    NSLog(@"toolbar...");
    
    // toolbar的父控件是textview还是控制器？经过分析新浪微博的toolbar，当键盘消失时，toolbar永远在view的最底部
    // 所以，我们确定其父控件为控制器
    [self.view addSubview:toolbar];
    
}

/**
 *添加textView
 */
- (void)setupTextView
{
    // 1.添加
    IWTextView *textView = [[IWTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceHorizontal = YES;
    textView.delegate = self;
    
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...分享新鲜事...";
    
    
    [self.view addSubview:textView];
    
    // 让textView成为第一响应者，弹出键盘
    // [textView becomeFirstResponder];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

// 编辑框可以上下滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

//  等textview加载完毕后，让textView成为第一响应者，弹出键盘
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // [self.textView becomeFirstResponder];
}

/**
 *  监听文字改变
 */
- (void)textDidChange  
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
//    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length;
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  取消
 */
- (void)cancel
{
    // 自定义发布窗口
    self.textView.placeholderColor = [UIColor redColor];
    self.textView.placeholder = @"哈哈，取消了";
    self.textView.font = [UIFont systemFontOfSize:20];
   // [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博
 */
- (void)send
{
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 发送内容
    params[@"status"] = self.textView.text;
    
    // 根据之前封装的账号工具类IWAccountTool，登陆授权的账号信息被保存在本地，然后通过账号属性获取access_token
    params[@"access_token"] = [IWAccountTool account].access_token;
  
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"恭喜，发送成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          // 隐藏提醒框
          [MBProgressHUD showError:@"抱歉，发送失败"];
      }];
    
    // 4.关闭控制器。当用户点击发送微博按钮后，需要将发微博界面关掉，因为发微博有时可能需要很长时间
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end
