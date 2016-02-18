//
//  MBSituationViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/17.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBSituationViewController.h"
#import "MBRecentSituationTableViewCell.h"
#import "MBSituationReplyViewController.h"
@interface MBSituationViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_situation;
}
@end

@implementation MBSituationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBBaseNaviBar *navi = [MBBaseNaviBar new];
    navi.title = @"瞅动态";
    [self.view addSubview:navi];
        ui_table_situation = [UITableView new];
    [self.view addSubview:ui_table_situation];
    [ui_table_situation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kGlobalNaviHeight);
        make.bottom.left.right.mas_equalTo(0);
    }];
    ui_table_situation.delegate = self;
    ui_table_situation.dataSource = self;
    ui_table_situation.rowHeight = UITableViewAutomaticDimension;
    ui_table_situation.estimatedRowHeight = 44;
    [ui_table_situation registerClass:[MBRecentSituationTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBRecentSituationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupDataWithDict:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MBSituationReplyViewController *vc = [MBSituationReplyViewController new];   
    [self.navigationController pushViewController:vc animated:NO];
}


@end
