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
    NSArray *msgArr;
    UITextView *ui_tv_msg;
    UIButton *ui_btn_send;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        msgModel *msg1 = [msgModel new];
        msg1.text = @"who are you?";
        msg1.avatarUrl = @"http://cdn.cocimg.com/bbs/attachment/upload/26/3056261428897147.jpg";
        msg1.fromType =eOthers;
        msgModel *msg2 = [msgModel new];
        msg2.text = @"今天天气很不错哦,我还蛮高兴的,可是1234567890qwertyu";
        msg2.avatarUrl = @"http://cdn.cocimg.com/bbs/images/face/none.gif";
        msg2.fromType =eMe;
        
        msgModel *msg3 = [msgModel new];
        msg3.text = @"你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈你是白痴么?我打死你!!!!!!!!!!哈哈哈哈哈";
        msg3.avatarUrl = @"http://cdn.cocimg.com/bbs/images/face/none.gif";
        msg3.fromType =eMe;
        msgArr = @[msg1,msg2,msg3];
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI {
    ui_table_chat = [UITableView new];
    [self addSubview:ui_table_chat];
    [ui_table_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    ui_table_chat.delegate = self;
    ui_table_chat.separatorStyle = UITableViewCellSeparatorStyleNone;
    ui_table_chat.dataSource = self;
    ui_table_chat.estimatedRowHeight = 44;
    ui_table_chat.rowHeight = UITableViewAutomaticDimension;
    [ui_table_chat registerClass:[MBChatTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)setupData {
    GCDAsyncUdpSocket *socket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
   
    socket.delegate = self;
    NSString *str = @"hello udp";
    
    NSLog(@"%@",str);
    NSString *host = @"10.5.57.16";
    int port = 6666;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    //[socket connectToHost:@"127.0.0.1" onPort:port error:&error];
    NSLog(@"%@",error);
    //host是在服务端设置的host，port也是服务端绑定的port，上文说过如果客户端不需要接收消息，就不用绑定端口
    [socket sendData:data toHost:host port:port withTimeout:-1 tag:1];
    
    
    
    [socket bindToPort:8888 error:nil];
    [socket beginReceiving:nil];
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
    MBChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDataWithModel:msgArr[indexPath.row]];
    return  cell;
}

@end
