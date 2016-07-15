//
//  MBChatRoomViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatRoomViewController.h"
#import "MBChatTableViewCell.h"
#import "msgModel.h"
#import "SocketService.h"
#import <CocoaAsyncSocket/AsyncUdpSocket.h>
@interface MBChatRoomViewController ()
<
AsyncUdpSocketDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_chat;
    UITextView *ui_tv_msg;
    UIView *ui_view_input_bar;
    UIButton *ui_btn_send;
    AsyncUdpSocket *socket;
    NSTimer *connectTimer;
    NSMutableArray *dataArr;
    NSString *friend_mid;
}
@end

@implementation MBChatRoomViewController

-(instancetype)initWithFriendMid:(NSString*)_friendMid
{
    self = [super init];
    friend_mid = _friendMid;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
    [self setupNotification];
}

- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
  
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [ui_view_input_bar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-1*height);
    }];
   
    [self performSelector:@selector(goTail) withObject:nil afterDelay:.3f];
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    [ui_view_input_bar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
}

- (void)goTail
{
    int idx = ([dataArr count]-1);
    if (idx<=0) {
       
    }else{
        [ui_table_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]
                         atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
    }
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
    [ui_btn_send setTitle:@"发送" forState:UIControlStateNormal];
    [ui_view_input_bar addSubview:ui_btn_send];
    [ui_btn_send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ui_view_input_bar);
        make.right.equalTo(ui_view_input_bar);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    ui_btn_send.backgroundColor = GREENCOLOR;
    [ui_btn_send addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    
    ui_tv_msg = [UITextView new];
    ui_tv_msg.layer.borderWidth = 1;
    [ui_view_input_bar addSubview:ui_tv_msg];
    [ui_tv_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.equalTo(ui_btn_send.mas_left);
    }];
    
    ui_table_chat = [UITableView new];
    ui_table_chat.separatorStyle = UITableViewCellSeparatorStyleNone;
    [ui_table_chat registerClass:[MBChatTableViewCell class] forCellReuseIdentifier:@"cell"];
    ui_table_chat.delegate = self;
    ui_table_chat.dataSource = self;
    ui_table_chat.estimatedRowHeight = 44;
    ui_table_chat.rowHeight=UITableViewAutomaticDimension;
    [self.view addSubview:ui_table_chat];
    [ui_table_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.right.mas_equalTo(-2);
        make.top.mas_equalTo(64);
        make.bottom.equalTo(ui_view_input_bar.mas_top);
    }];
}

#pragma mark- msg handle
- (void)sendMsg
{
    NSString *msgStr = [NSString stringWithFormat:@"%@ \r\n",ui_tv_msg.text];
    int x = arc4random() % 1000;
    NSString *mid = [MBUserConfig sharedInstance].mid;
    NSString *to_mid = friend_mid;
    msgStr = [msgStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    NSString *socketStr = [NSString stringWithFormat:@"{\"msg\":\"%@\",\"mid\":\"%@\",\"to_mid\":\"%@\"}%@",msgStr,mid,to_mid,@""];
    NSData *data = [socketStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket sendData:data withTimeout:-1 tag:x];
    NSString *create_time = [NSDate now];
    
    [msgModel insert:msgStr from_mid:mid create_time:create_time to_mid:to_mid friend_mid:friend_mid];
    [self getMsgWithPage:0];
    ui_tv_msg.text = @"";
    [[NSNotificationCenter defaultCenter]postNotificationName:kNewMsgIncoming object:nil];
}

- (void)setupData
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg) name:kNewMsgIncoming object:nil];
    
    socket = [SocketService sharedInstance];
    socket.delegate = self;
    dataArr = [NSMutableArray new];
    [self getMsgWithPage:0];
}

- (void)receiveMsg
{
    [self getMsgWithPage:0];
}

- (void)getMsgWithPage:(NSUInteger)page
{
    NSString *sql = [NSString stringWithFormat:@"select * from mb_msg as t1 left join mb_friend as t2 on t1.friend_mid = t2.friend_mid where t1.friend_mid=%@",friend_mid];
    FMResultSet *set=[[FMDBService sharedInstance] executeQuery:sql];
     [dataArr removeAllObjects];
    while ([set next]) {
        NSDictionary *dict =@{
                              @"msg":[set stringForColumn:@"msg"],
                              @"avatar_url":[set stringForColumn:@"avatar_url"],
                              @"from_mid":[set stringForColumn:@"from_mid"]
        };
        [dataArr addObject:dict];
    }
    [ui_table_chat reloadData];
    [self performSelector:@selector(goTail) withObject:nil afterDelay:0.5];
}

#pragma mark- socket delegate
/**
 * Called when the datagram with the given tag has been sent.
 **/
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag;
{
    NSLog(@"%s",__func__);
    [ui_table_chat reloadData];
    [self goTail];
}


#pragma mark- table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *from_mid = dataArr[indexPath.row][@"from_mid"];
    if([from_mid isEqualToString:[MBUserConfig sharedInstance].mid]){
        cell.backgroundColor = WHITECOLOR;
    }else{
        cell.backgroundColor = WHITECOLOR;
    }
    [cell setupDataWithDict:dataArr[indexPath.row]];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view.window endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
