//
//  MBNearListViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBNearListViewController.h"
#import "MBPeopleInfoTableViewCell.h"
#import "MBNearMapViewController.h"
@interface MBNearListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView   *ui_table_people;
    MBBaseNaviBar *ui_bar_top;
    UIButton      *ui_btn_map;
}
@end

@implementation MBNearListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    WS(ws);
    //table
    ui_table_people = [UITableView new];
    ui_table_people.delegate = self;
    ui_table_people.dataSource = self;
    [ui_table_people registerClass:[MBPeopleInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:ui_table_people];
    [ui_table_people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(ws.view).with.insets(UIEdgeInsetsMake(kGlobalNaviHeight, 0, 0, 0));
    }];
    //top bar
    ui_bar_top = [MBBaseNaviBar new];
    ui_bar_top.title = @"附近";
    [self.view addSubview:ui_bar_top];
    //map btn
    ui_btn_map = [UIButton new];
    [ui_btn_map setTitleColor:themeBlue forState:UIControlStateNormal];
    [ui_btn_map setTitle:@"地图" forState:UIControlStateNormal];
    [ui_btn_map addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];
    [ui_bar_top addSubview:ui_btn_map];
    [ui_btn_map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.centerY.equalTo(ui_bar_top.mas_centerY).offset(8);
        make.right.mas_equalTo(-8);
    }];
}

- (void)goToMap {
    MBNearMapViewController *vc = [MBNearMapViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGlobalCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBPeopleInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupDataWithDict:nil];
    return cell;
}
@end
