//
//  IWStatusCell.h
//  ItcastWeibo
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  展示微博的cell

#import <UIKit/UIKit.h>
@class IWStatusFrame;
@interface IWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) IWStatusFrame *statusFrame;
@end
