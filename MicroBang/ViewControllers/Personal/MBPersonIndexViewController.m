//
//  MBPersonIndexViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPersonIndexViewController.h"

@interface MBPersonIndexViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_index;
    NSArray *itemArr;
    MBBaseNaviBar *navi;
    UISegmentedControl *ui_seg_item;
}

@end

@implementation MBPersonIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    itemArr = @[@"个人动态",@"谁看过我",@"设置",@"帮助"];
    [self setupUI];
}

- (void)setupUI {
    WS(ws);
    navi = [MBBaseNaviBar new];
    navi.title = @"个人";
    [self.view addSubview:navi];
    
    ui_seg_item = [[UISegmentedControl alloc]initWithItems:itemArr];
    [self.view addSubview:ui_seg_item];
    [ui_seg_item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.top.mas_equalTo(kGlobalNaviHeight);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(300);
    }];
}


@end
