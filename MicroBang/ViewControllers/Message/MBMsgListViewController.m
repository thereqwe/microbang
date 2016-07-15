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
#import "MBLoginViewController.h"
@implementation MBMsgListViewController
{
    UITableView *ui_table_msg_list;
    NSMutableArray *dataArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"消息";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupData
{
    dataArr = [NSMutableArray new];
    [self getMsg];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMsg) name:kNewMsgIncoming object:nil];
}

- (void)getMsg
{
    NSString *sql = @"select *,t1.create_time from (select * from mb_msg order by create_time asc) as t1 left join mb_friend as t2 on t1.friend_mid = t2.friend_mid  group by t1.friend_mid having nickname is not null order by t1.create_time desc";
    FMResultSet *set = [[FMDBService sharedInstance] executeQuery:sql];
    NSLog(@"%@",[FMDBService sharedInstance].lastErrorMessage);
    NSLog(@"%@",[FMDBService sharedInstance].lastError);
    [dataArr removeAllObjects];
    while ([set next]) {
        NSString *msg = [set stringForColumn:@"msg"];
        NSString *avatar_url = [set stringForColumn:@"avatar_url"];
        NSString *nickname = [set stringForColumn:@"nickname"];
        NSString *create_time = [set stringForColumn:@"create_time"];
        NSString *friend_mid = [set stringForColumn:@"friend_mid"];
        [dataArr addObject:@{@"msg":msg,@"nickname":nickname,@"avatar_url":avatar_url,@"create_time":create_time,@"friend_mid":friend_mid}];
    }
    [ui_table_msg_list reloadData];
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
    ui_table_msg_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    ui_table_msg_list.delegate = self;
    ui_table_msg_list.dataSource = self;
    ui_table_msg_list.rowHeight = 44*2;
    [ui_table_msg_list registerClass:[MBMsgListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:ui_table_msg_list];
    [ui_table_msg_list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.right.mas_equalTo(-2);
        make.top.mas_equalTo(2);
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
    MBLoginViewController *loginViewController =[MBLoginViewController new];
    [loginViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBMsgListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setupData:dataArr[indexPath.row]];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *friend_mid = dataArr[indexPath.row][@"friend_mid"];
    MBChatRoomViewController *chatRoomViewController = [[MBChatRoomViewController alloc]initWithFriendMid:friend_mid];
    chatRoomViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
