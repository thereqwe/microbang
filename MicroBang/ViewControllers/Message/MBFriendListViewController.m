//
//  MBFriendListViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBFriendListViewController.h"
#import "MBFriedndListTableViewCell.h"
#import "HTTPService.h"
#import "MBAddFriendViewController.h"
#import "MBChatRoomViewController.h"
@implementation MBFriendListViewController
{
    UITableView *ui_table_friend;
    NSMutableArray *dataArr;
}

- (void)setupData
{
    dataArr =[NSMutableArray new];
    FMResultSet * set = [[FMDBService sharedInstance] executeQuery:@"select * from mb_friend where 1"];
    while ([set next]) {
        NSDictionary *dict = @{
                               @"nickname":[set stringForColumn:@"nickname"],
                               @"create_time":[set stringForColumn:@"create_time"],
                               @"avatar_url":[set stringForColumn:@"avatar_url"],
                               @"friend_mid":[set stringForColumn:@"friend_mid"],
                             };
        
        [dataArr addObject:dict];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)goToAddFriend
{
    MBAddFriendViewController *vc = [MBAddFriendViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupUI
{
    UIButton *friendBtn = [UIButton new];
    friendBtn.frame = CGRectMake(0, 0, 80, 20);
    friendBtn.backgroundColor = [UIColor blueColor];
    [friendBtn setTitle:@"加好友" forState:UIControlStateNormal];
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
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBFriedndListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = dataArr[indexPath.row];
    [cell setupData:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *friend_mid =  dataArr[indexPath.row][@"friend_mid"];
    MBChatRoomViewController *vc = [[MBChatRoomViewController alloc]initWithFriendMid:friend_mid];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
