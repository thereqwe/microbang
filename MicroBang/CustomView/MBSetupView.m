//
//  MBSetupView.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBSetupView.h"

@implementation MBSetupView
{
    UITableView *ui_table_setup;
    NSArray *itemArr;
}

-(void)didMoveToSuperview {
    if (self.superview==nil) {
        return;
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.backgroundColor = [UIColor brownColor];
    itemArr = @[@"个人资料",@"隐私设置",@"检查更新",@"清除缓存",@"给微泡评分"];
    [self setupUI];
}

-(void)setupUI {
    WS(ws);
    ui_table_setup = [UITableView new];
    [self addSubview:ui_table_setup];
    [ui_table_setup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    ui_table_setup.dataSource = self;
    ui_table_setup.delegate   = self;
    ui_table_setup.rowHeight = 44;
    [ui_table_setup registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [ui_table_setup setTableFooterView:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = itemArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
