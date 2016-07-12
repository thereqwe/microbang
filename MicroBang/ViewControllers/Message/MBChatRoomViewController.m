//
//  MBChatRoomViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatRoomViewController.h"
#import "MBChatTableViewCell.h"
#import "Msg.h"
#import "msgModel.h"
#import "SocketService.h"
@interface MBChatRoomViewController ()
<
AsyncSocketDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_chat;
    UITextView *ui_tv_msg;
    UIView *ui_view_input_bar;
    UIButton *ui_btn_send;
    AsyncSocket *socket;
    NSTimer *connectTimer;
    NSMutableArray *dataArr;
}
@end

@implementation MBChatRoomViewController

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
//    int *idx = ([dataArr count]-1);
//    if (idx<0) {
//        idx=0;
//    }
//    [ui_table_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]
//                         atScrollPosition:UITableViewScrollPositionBottom
//                                 animated:NO];
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
    [ui_btn_send addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    
    ui_tv_msg = [UITextView new];
    ui_tv_msg.layer.borderWidth = 1;
    [ui_view_input_bar addSubview:ui_tv_msg];
    [ui_tv_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.equalTo(ui_btn_send.mas_left);
    }];
    
    ui_table_chat = [UITableView new];
    [ui_table_chat registerClass:[MBChatTableViewCell class] forCellReuseIdentifier:@"cell"];
    ui_table_chat.delegate = self;
    ui_table_chat.dataSource = self;
    ui_table_chat.estimatedRowHeight = 44;
    ui_table_chat.rowHeight=UITableViewAutomaticDimension;
    [self.view addSubview:ui_table_chat];
    [ui_table_chat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.bottom.equalTo(ui_view_input_bar.mas_top);
    }];
}

#pragma mark- msg handle
- (void)sendMsg
{
    NSString *msgStr = [NSString stringWithFormat:@"%@ \r\n",ui_tv_msg.text];
    int x = arc4random() % 100;
    Msg* msg = [Msg MR_createEntity];
    msg.from_mid=@"86";
    msg.text=msgStr;
    msg.create_time = [NSDate date];
    msg.type = msg_text;
    [dataArr addObject:msg];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    NSString *mid = [MBUserConfig sharedInstance].mid;
    NSString *to_mid = @"3";
    msgStr = [msgStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
    NSString *socketStr = [NSString stringWithFormat:@"{\"msg\":\"%@\",\"mid\":\"%@\",\"to_mid\":\"%@\"}%@",msgStr,mid,to_mid,@"\r"];
    NSData *data = [socketStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:data withTimeout:2 tag:x];
}

- (void)setupData
{
    socket = [SocketService sharedInstance];
    socket.delegate = self;
    dataArr = [NSMutableArray new];
    [self getLocalChatHistoryWithPage:0];
}

- (void)getLocalChatHistoryWithPage:(NSUInteger)page
{
    //获取查询条件
    NSFetchRequest * request = [Msg MR_requestAll];
    //设置排序字段
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_time" ascending:NO];
    //设置排序数组
    [request setSortDescriptors:@[sortDescriptor]];
    //设置分页查询数目
    [request setFetchLimit:10];
    //设置查询起始
    [request setFetchOffset:page*10];
    //执行查询语句 并返回数组
    NSArray * arrayss = [Msg MR_executeFetchRequest:request];
    NSArray* reversedArray = [[arrayss reverseObjectEnumerator] allObjects];
    [dataArr addObjectsFromArray:reversedArray];
}

#pragma mark- socket delegate
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
      NSLog(@"^^^^^^^%s",__func__);
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"!!!!!!!!!%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%s",__func__);
    [sock readDataWithTimeout:-1 tag:tag];
    [ui_table_chat reloadData];
    [self goTail];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"%s",__func__);
   // [socket writeData:[@"ooook" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1000];
    // 每隔30s像服务器发送心跳包
//    connectTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
//    
//    [connectTimer fire];
}

#pragma mark- table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row==19){
        cell.contentView.backgroundColor = [UIColor redColor];
    }else{
        cell.contentView.backgroundColor = [UIColor brownColor];
    }
    Msg *msg = dataArr[indexPath.row];
    [cell setupDataWithDict:@{@"text":msg.text}];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view.window endEditing:YES];
}

//-(void)longConnectToSocket{
//    
//    // 根据服务器要求发送固定格式的数据，假设为指令@"longConnect"，但是一般不会是这么简单的指令
//    
//    NSString *longConnect = @"longConnect";
//    
//    NSData   *dataStream  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
//    
//  //  [socket writeData:dataStream withTimeout:1 tag:1];
//    
//}
@end
