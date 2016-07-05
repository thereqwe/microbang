//
//  MBMsgListViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/6/30.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBMsgListViewController.h"
#import "MBMsgListTableViewCell.h"
#import "MBFriendListViewController.h"
#import "MBChatRoomViewController.h"
#import "MBRegisterViewController.h"
@implementation MBMsgListViewController
{
    UITableView *ui_table_msg_list;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"消息";
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    UIButton *friendBtn = [UIButton new];
    friendBtn.frame = CGRectMake(0, 0, 50, 20);
    friendBtn.backgroundColor = [UIColor redColor];
    [friendBtn setTitle:@"friend" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendBtn];
    [friendBtn addTarget:self action:@selector(goToFriendList) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *logBtn = [UIButton new];
    logBtn.frame = CGRectMake(0, 0, 50, 20);
    logBtn.backgroundColor = [UIColor blueColor];
    [logBtn setTitle:@"login" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logBtn];
    [logBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    ui_table_msg_list = [UITableView new];
    ui_table_msg_list.delegate = self;
    ui_table_msg_list.dataSource = self;
    ui_table_msg_list.rowHeight = 44*2;
    ui_table_msg_list.backgroundColor = [UIColor brownColor];
    [ui_table_msg_list registerClass:[MBMsgListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:ui_table_msg_list];
    [ui_table_msg_list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)goToFriendList
{
    MBFriendListViewController *friendListViewController =[MBFriendListViewController new];
    [friendListViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:friendListViewController animated:YES];
}

- (void)login
{
    MBRegisterViewController *registerViewController =[MBRegisterViewController new];
    [registerViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBMsgListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupData:nil];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBChatRoomViewController *chatRoomViewController = [MBChatRoomViewController new];
    chatRoomViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}
@end
