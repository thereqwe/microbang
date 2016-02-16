//
//  MBActivityIndexViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBActivityIndexViewController.h"
#import "MBShakerViewController.h"
#import "MBPhotoWallViewController.h"
@interface MBActivityIndexViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_index;
    NSArray *itemArr;
    MBBaseNaviBar *navi;
}
@end

@implementation MBActivityIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    itemArr = @[@"摇一摇",@"探一探",@"瞅动态"];
}

- (void)setupUI {
    ui_table_index = [UITableView new];
    [self.view addSubview:ui_table_index];
    [ui_table_index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(kGlobalNaviHeight);
    }];
    [ui_table_index registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [ui_table_index setDelegate:self];
    [ui_table_index setDataSource:self];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [ui_table_index setTableFooterView:view];
    
    navi = [MBBaseNaviBar new];
    navi.title = @"发现";
    [self.view addSubview:navi];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setText:itemArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        MBShakerViewController *vc = [MBShakerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1) {
        MBPhotoWallViewController *vc = [MBPhotoWallViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
