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

@interface IWStatusCell()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;
@end

@implementation IWStatusCell

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
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    // 0.设置cell选中时的背景
#warning TODO
//    UIImageView *bgView = [[UIImageView alloc] init];
//    bgView.backgroundColor = [UIColor redColor];
////    bgView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
//    self.selectedBackgroundView = bgView;
    
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = IWStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = IWStatusTimeFont;
    timeLabel.textColor = IWColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = IWStatusSourceFont;
    sourceLabel.textColor = IWColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = IWColor(39, 39, 39);
    contentLabel.font = IWStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = IWRetweetStatusNameFont;
    retweetNameLabel.textColor = IWColor(67, 107, 163);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = IWRetweetStatusContentFont;
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = IWColor(90, 90, 90);
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 1.微博的工具条 */
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    statusToolbar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
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

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

/**
 *  微博工具条
 */
- (void)setupStatusToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

/**
 *  原创微博
 */
- (void)setupOriginalData
{
    IWStatus *status = self.statusFrame.status;
    IWUser *user = status.user;
    
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    // 6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }
}

/**
 *  被转发微博
 */
- (void)setupRetweetData
{
    IWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    IWUser *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}


@end
