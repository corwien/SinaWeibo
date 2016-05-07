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

@interface IWComposeViewController ()
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
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    IWTextView *textView = [[IWTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博
 */
- (void)send
{
    
}

@end
