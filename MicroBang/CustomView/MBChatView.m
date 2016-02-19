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
    ui_table_chat.separatorStyle =　UITableViewCellSeparatorStyleNone;
    ui_table_chat.dataSource = self;
    ui_table_chat.estimatedRowHeight = 44;
    ui_table_chat.rowHeight = UITableViewAutomaticDimension;
    [ui_table_chat registerClass:[MBChatTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
