//
//  IWDiscoverViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  广场(发现)

#import "IWDiscoverViewController.h"
#import "IWSearchBar.h"

@interface IWDiscoverViewController ()

@end

@implementation IWDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IWSearchBar *searchBar = [IWSearchBar searchBar];
    // 尺寸
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    // 设置中间的标题内容
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
@end
