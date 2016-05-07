//
//  IWStatusCell.m
//  ItcastWeibo
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusCell.h"
#import "IWStatus.h"
#import "IWStatusFrame.h"
#import "IWUser.h"
#import "UIImageView+WebCache.h"
#import "IWStatusToolbar.h"
#import "IWStatusTopView.h"

@interface IWStatusCell()
/** 顶部的view */
@property (nonatomic, weak) IWStatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) IWStatusToolbar *statusToolbar;
@end

@implementation IWStatusCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加顶部的view
        [self setupTopView];
        
        // 2.添加微博的工具条
        [self setupStatusToolbar];
    }
    return self;
}

/**
 *  添加顶部的view
 */
- (void)setupTopView
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    /** 1.顶部的view */
    IWStatusTopView *topView = [[IWStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolbar
{
    /** 微博的工具条 */
    IWStatusToolbar *statusToolbar = [[IWStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += IWStatusTableBorder;
    frame.origin.x = IWStatusTableBorder;
    frame.size.width -= 2 * IWStatusTableBorder;
    frame.size.height -= IWStatusTableBorder;
    [super setFrame:frame];
}

#pragma mark - 数据的设置
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.设置顶部view的数据
    [self setupTopViewData];
    
    // 2.设置微博工具条的数据
    [self setupStatusToolbarData];
}

/**
 *  设置顶部view的数据
 */
- (void)setupTopViewData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
}

/**
 *  设置微博工具条的数据
 */
- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}
@end