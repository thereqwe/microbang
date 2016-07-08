//
//  MBFriendListViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBFriendListViewController.h"
#import "MBFriedndListTableViewCell.h"
#import "Friend.h"
#import "HTTPService.h"
#import "MBAddFriendViewController.h"
@implementation MBFriendListViewController
{
    UITableView *ui_table_friend;
    NSMutableArray *dataArr;
}

- (void)setupData
{
    dataArr =[NSMutableArray new];
    NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"mid"];
    NSDictionary *dict = @{@"mid":mid,@"action":@"getFriendList"};
    [[HTTPService Instance] mobilePOST:SERVER_URL
                                  path:@"/responder.php"
                            parameters:[dict mutableCopy]
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   id data = responseObject[@"data"];
                                   if([data isKindOfClass:[NSArray class]]){
                                       [Friend MR_truncateAll];
                                       for(NSDictionary *dict in data){
                                               Friend* friend = [Friend MR_createEntity];
                                               friend.nickname = dict[@"nickname"];
                                               friend.create_time = [NSDate date];
                                               friend.friend_mid = dict[@"friend_mid"];
                                               [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
                                       }
                                       [dataArr addObjectsFromArray:[Friend MR_findAll]];
                                       [ui_table_friend reloadData];
                                   }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    Friend *friend = dataArr[indexPath.row];
    NSDictionary *dict = @{
                           @"nickname":friend.nickname
                           };
    [cell setupData:dict];
    return cell;
}
@end
