//
//  MBRecentComeView.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBRecentComeView.h"
#import "MBPeopleInfoTableViewCell.h"
@implementation MBRecentComeView
{
    UITableView *ui_table_come;
}

-(void)didMoveToSuperview {
    if (self.superview==nil) {
        return;
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.backgroundColor = [UIColor blueColor];
    [self setupUI];
}

-(void)setupUI {
    WS(ws);
    ui_table_come = [UITableView new];
    ui_table_come.delegate = self;
    ui_table_come.dataSource = self;
    ui_table_come.rowHeight = UITableViewAutomaticDimension;
    ui_table_come.estimatedRowHeight = 44;
    [ui_table_come registerClass:[MBPeopleInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:ui_table_come];
    [ui_table_come mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBPeopleInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupDataWithDict:nil];
    return cell;
}

@end
