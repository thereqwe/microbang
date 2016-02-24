//
//  MBChatView.m
//  MicroBang
//
//  Created by leon on 2016/二月/17.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatView.h"
#import "MBChatTableViewCell.h"
@implementation MBChatView
{
    UITableView *ui_table_chat;
    NSMutableArray *msgArr;
    UITextView *ui_tv_msg;
    UIButton *ui_btn_send;
    NSNotification *noti_keyShow;
    NSNotification *noti_keyHide;
    GCDAsyncUdpSocket *socket;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //msgModel *msg1 = [msgModel new];
        //msg1.text = @"who are you?";
        //msg1.avatarUrl = @"http://cdn.cocimg.com/bbs/attachment/upload/26/3056261428897147.jpg";
        //msg1.fromType =eOthers;
        //msgModel *msg2 = [msgModel new];
        //msg2.text = @"今天天气很不错哦,我还蛮高兴的,可是1234567890qwertyu";
        //msg2.avatarUrl = @"http://cdn.cocimg.com/bbs/images/face/none.gif";
        //msg2.fromType =eMe;
        
        //msgModel *msg3 = [msgModel new];
        //msg3.text = @"你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈";
        //msg3.avatarUrl = @"http://cdn.cocimg.com/bbs/images/face/none.gif";
        //msg3.fromType =eMe;
        msgArr = [NSMutableArray new];
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI {
    ui_table_chat = [UITableView new];
    [self addSubview:ui_table_chat];
    [ui_table_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenHeight-50);
    }];
    ui_table_chat.delegate = self;
    ui_table_chat.separatorStyle = UITableViewCellSeparatorStyleNone;
    ui_table_chat.dataSource = self;
    ui_table_chat.estimatedRowHeight = 44;
    ui_table_chat.rowHeight = UITableViewAutomaticDimension;
    [ui_table_chat registerClass:[MBChatTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    ui_tv_msg = [UITextView new];
    ui_tv_msg.layer.borderWidth = 0.5;
    [self addSubview:ui_tv_msg];
    [ui_tv_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_table_chat.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(50);
    }];
    
    ui_btn_send = [UIButton new];
    ui_btn_send.backgroundColor = themeBlue;
    [ui_btn_send setTitle:@"发送" forState:UIControlStateNormal];
    [ui_btn_send addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ui_btn_send];
    [ui_btn_send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_table_chat.mas_bottom).offset(0);
        make.left.equalTo(ui_tv_msg.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)setupData {
    socket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
   
    socket.delegate = self;
    
    [socket bindToPort:8888 error:nil];
    [socket beginReceiving:nil];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    int width = keyboardRect.size.width;
    NSLog(@"键盘高度是  %d",height);
    NSLog(@"键盘宽度是  %d",width);
    [ui_table_chat mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenHeight-50-height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    [ui_table_chat mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenHeight-50);
    }];
}

- (void)sendMsg {
    msgModel *msg1 = [msgModel new];
    msg1.text = ui_tv_msg.text;
    msg1.avatarUrl = @"http://cdn.cocimg.com/bbs/images/face/none.gif";
    msg1.fromType =eMe;
    [msgArr addObject:msg1];
    
    
    NSString *str = ui_tv_msg.text;
    
    NSLog(@"%@",str);
    NSString *host = @"10.5.57.16";
    int port = 6666;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    //[socket connectToHost:@"127.0.0.1" onPort:port error:&error];
    NSLog(@"%@",error);
    //host是在服务端设置的host，port也是服务端绑定的port，上文说过如果客户端不需要接收消息，就不用绑定端口
    [socket sendData:data toHost:host port:port withTimeout:-1 tag:1];
    ui_tv_msg.text = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
        [ui_table_chat reloadData];
        [ui_table_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[msgArr count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    });
    
}

/**
 * By design, UDP is a connectionless protocol, and connecting is not needed.
 * However, you may optionally choose to connect to a particular host for reasons
 * outlined in the documentation for the various connect methods listed above.
 *
 * This method is called if one of the connect methods are invoked, and the connection is successful.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"succ %@",sock);
}

/**
 * By design, UDP is a connectionless protocol, and connecting is not needed.
 * However, you may optionally choose to connect to a particular host for reasons
 * outlined in the documentation for the various connect methods listed above.
 *
 * This method is called if one of the connect methods are invoked, and the connection fails.
 * This may happen, for example, if a domain name is given for the host and the domain name is unable to be resolved.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error {
    NSLog(@"failed %@",sock);
}

/**
 * Called when the datagram with the given tag has been sent.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"didsend %@",sock);
}

/**
 * Called if an error occurs while trying to send a datagram.
 * This could be due to a timeout, or something more serious such as the data being too large to fit in a sigle packet.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"error %@",error);
}

/**
 * Called when the socket has received the requested datagram.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext {
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    msgModel *msg1 = [msgModel new];
    msg1.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    msg1.avatarUrl = @"http://cdn.cocimg.com/bbs/attachment/upload/26/3056261428897147.jpg";
    msg1.fromType =eOthers;
    [msgArr addObject:msg1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [ui_table_chat reloadData];
        [ui_table_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[msgArr count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    });
    
}

/**
 * Called when the socket is closed.
 **/
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
     NSLog(@"close %@",error);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [msgArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                                forIndexPath:indexPath];
    [cell setDataWithModel:msgArr[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
