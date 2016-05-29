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
#import "IWComposePhotosView.h"



@interface IWComposeViewController ()<UITextViewDelegate,IWComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak)IWComposeToolbar *toolbar;
// @property (nonatomic, weak)UIImageView *imageView;   // 不再是一个imageView,而是一个整体
@property(nonatomic, weak)IWComposePhotosView *photosView;
@end

@implementation IWComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar ****===***
    [self setupToolbar];
    
    // 添加imageView (初始化）
    [self setupPhotosView];
}

/**
 *  添加photosView
 */
-(void)setupPhotosView
{
    // UIImageView *imageView = [[UIImageView alloc] init];
    IWComposePhotosView *photosView = [[IWComposePhotosView alloc] init];
    
    // 添加背景色
    photosView.backgroundColor = [UIColor redColor];
    
    // 设置frame
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosY = 80;
    CGFloat photosH = self.textView.frame.size.height;
    
    photosView.frame = CGRectMake(0, photosY, photosW, photosH );
    [self.textView addSubview:photosView];
    
    // 赋值属性
    self.photosView = photosView;
    
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickedButton:(IWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case IWComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case IWComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibarary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


/**
 *  打开相册
 */
-(void)openPhotoLibarary{
    // NSLog(@"打开相册");
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.获取到的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 3.把用户选择的图片显示在发微博编辑框内
     // self.imageView.image = image;
     // NSLog(@"%@", info);
    [self.photosView addImage:image];
}

/**
 *  添加Toolbar
 */
-(void)setupToolbar
{
    IWComposeToolbar *toolbar = [[IWComposeToolbar alloc] init];
    toolbar.delegate = self;  // 点击打开图片库的按钮[2016-05-26 00:45 ADD]
    
    // 设置frame
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;  // 宽度为view的宽度
    CGFloat toolbarX = 0;   // 位置，在最左边
    CGFloat toolbarY = self.view.frame.size.height - toolbarH; // 无键盘时的toolbar高度
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    // toolbar的父控件是textview还是控制器？经过分析新浪微博的toolbar，当键盘消失时，toolbar永远在view的最底部
    // 所以，我们确定其父控件为控制器
    [self.view addSubview:toolbar];
    
    // 赋值属性
    self.toolbar = toolbar;
    
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
    
    // 3.监听键盘,当键盘frame改变时（键盘的Y值会变化,键盘的显示、隐藏），做出相应的操作===*****=======
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 * 键盘出现的时候调用
 *@param note
 */
-(void)keyboardWillShow:(NSNotification *)note
{
   // IWLog(@"keyboardWillShow---%@", note.userInfo);
    
    // 1.获取键盘的frame，从字典里取出来的为对象，还需要转CGRectValue
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        
    }];
}


/**
 * 键盘即将退出的时候调用
 *@param note
 */
-(void)keyboardWillHide:(NSNotification *)note
{
    
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
        
    }];

}

// 编辑框可以上下滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

//  等textview加载完毕后，让textView成为第一响应者，弹出键盘
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
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
 *  （新）发微博（纯文字+有图片博客）
 */
- (void)send
{
    if(self.photosView.totalImages.count) // 有图片
    {
        [self sendWithImage];
        
    }
    else  // 无图片
    {
        [self sendWithoutImage];
        
    }
    
}


/**
 *  发有图片微博
 */
- (void)sendWithImage
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
    
    // 上传图片（是否压缩,压缩质量为0.6，原图为1.0）
    // params[@"pic"] = UIImageJPEGRepresentation(self.imageView.image, 0.6);
    
    
    // 3.发送请求
    /*
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"恭喜，发送成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          // 隐藏提醒框
          [MBProgressHUD showError:@"抱歉，发送失败"];
      }];
     */
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 在发送请求之前调用这个block
        
        
        //必须在这里说明需要上传哪些文件
        NSArray *images = [self.photosView totalImages];
        for(UIImage *image in images){
            NSData *data = UIImageJPEGRepresentation(image, 0.6);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
            
        }
        
    }  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"恭喜，发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD showError:@"抱歉，发送失败"];
    }];
    
    // 4.关闭控制器。当用户点击发送微博按钮后，需要将发微博界面关掉，因为发微博有时可能需要很长时间
    [self dismissViewControllerAnimated:YES completion:nil];
    
    

    
}

/**
 *  发无图片微博
 */
- (void)sendWithoutImage
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
