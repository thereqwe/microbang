//
//  MBAddFriendViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/7.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBAddFriendViewController.h"
#import "HTTPService.h"
@interface MBAddFriendViewController ()
{
    UITextField *ui_tf_friend_name;
    UIButton *ui_btn_ok;
}
@end

@implementation MBAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    ui_tf_friend_name = [UITextField new];
    [self.view addSubview:ui_tf_friend_name];
    ui_tf_friend_name.borderStyle = UITextBorderStyleLine;
    [ui_tf_friend_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    WS(ws);
    ui_btn_ok = [UIButton new];
    [ui_btn_ok setTitle:@"添加" forState:UIControlStateNormal];
    [ui_btn_ok addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    ui_btn_ok.backgroundColor= [UIColor brownColor];
    [self.view addSubview:ui_btn_ok];
    [ui_btn_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_friend_name.mas_bottom).offset(10);
        make.centerX.equalTo(ws.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
}

- (void)addFriend
{
    NSString *friend_name = ui_tf_friend_name.text;
    NSDictionary *dict = @{@"friend_name":friend_name,@"action":@"addFriend"};
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *msg = responseObject[@"msg"];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}


@end
