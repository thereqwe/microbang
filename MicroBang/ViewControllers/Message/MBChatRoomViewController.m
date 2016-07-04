//
//  MBChatRoomViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatRoomViewController.h"
#import <CocoaAsyncSocket/AsyncSocket.h>
@interface MBChatRoomViewController ()
<
AsyncSocketDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_chat;
    UITextField *ui_tf_msg;
    UIView *ui_view_input_bar;
    UIButton *ui_btn_send;
    AsyncSocket *socket;
}
@end

@implementation MBChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupUI
{
    ui_view_input_bar = [UIView new];
    [self.view addSubview:ui_view_input_bar];
    [ui_view_input_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    ui_btn_send = [UIButton new];
    [ui_btn_send setTitle:@"send" forState:UIControlStateNormal];
    [ui_view_input_bar addSubview:ui_btn_send];
    [ui_btn_send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ui_view_input_bar);
        make.right.equalTo(ui_view_input_bar);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    ui_btn_send.backgroundColor = [UIColor redColor];
    [ui_btn_send addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    ui_tf_msg = [UITextField new];
    ui_tf_msg.borderStyle = UITextBorderStyleLine;
    [ui_view_input_bar addSubview:ui_tf_msg];
    [ui_tf_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.equalTo(ui_btn_send.mas_left);
    }];
    
    ui_table_chat = [UITableView new];
    [ui_table_chat registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    ui_table_chat.delegate = self;
    ui_table_chat.dataSource = self;
    [self.view addSubview:ui_table_chat];
    [ui_table_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.bottom.equalTo(ui_view_input_bar.mas_top);
    }];
}

- (void)setupData
{
    socket = [[AsyncSocket alloc]initWithDelegate:self];
    [socket connectToHost:@"30.97.16.232" onPort:10005 error:nil];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"%s",__func__);
    [socket writeData:[@"你好" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1000];
}

/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"%s",__func__);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
@end
