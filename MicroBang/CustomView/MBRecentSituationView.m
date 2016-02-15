//
//  MBRecentSituationView.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBRecentSituationView.h"
#import "MBRecentSituationTableViewCell.h"
@implementation MBRecentSituationView
{
    UITableView *ui_table_situation;
}

-(void)didMoveToSuperview {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.backgroundColor = [UIColor redColor];
    [self setupUI];
}

-(void)setupUI {
    WS(ws);
    ui_table_situation = [UITableView new];
    ui_table_situation.dataSource = self;
    ui_table_situation.delegate = self;
    ui_table_situation.estimatedRowHeight = 44.0;
    ui_table_situation.rowHeight = UITableViewAutomaticDimension;
    [ui_table_situation registerClass:[MBRecentSituationTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:ui_table_situation];
    [ui_table_situation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 200;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBRecentSituationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupDataWithDict:nil];
    return cell;
}

@end
