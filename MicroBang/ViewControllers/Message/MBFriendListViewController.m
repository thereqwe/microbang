//
//  MBFriendListViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBFriendListViewController.h"
#import "MBFriedndListTableViewCell.h"
@implementation MBFriendListViewController
{
    UITableView *ui_table_friend;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)goToAddFriend
{
    
}

- (void)setupUI
{
    UIButton *friendBtn = [UIButton new];
    friendBtn.frame = CGRectMake(0, 0, 20, 20);
    friendBtn.backgroundColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendBtn];
    [friendBtn addTarget:self action:@selector(goToAddFriend) forControlEvents:UIControlEventTouchUpInside];
    
    ui_table_friend = [UITableView new];
    ui_table_friend.backgroundColor = [UIColor brownColor];
    ui_table_friend.delegate = self;
    ui_table_friend.dataSource = self;
    ui_table_friend.rowHeight = 44*2;
    [ui_table_friend registerClass:[MBFriedndListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:ui_table_friend];
    [ui_table_friend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBFriedndListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupData:nil];
    return cell;
}


@end
