//
//  MBNearListViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBNearListViewController.h"

@interface MBNearListViewController ()
{
    UITableView   *ui_table_people;
    MBBaseNaviBar *ui_bar_top;
}
@end

@implementation MBNearListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    WS(ws);
    ui_table_people = [UITableView new];
    [self.view addSubview:ui_table_people];
    [ui_table_people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view).with.insets(UIEdgeInsetsMake(kGlobalNaviHeight, 0, 0, 0));
    }];
    ui_bar_top = [MBBaseNaviBar new];
    [self.view addSubview:ui_bar_top];
}
@end
