//
//  MBProfileViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/8.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBProfileViewController.h"
//#import "HTTPService.h"
@interface MBProfileViewController ()
{
    UIButton *ui_btn_avatar;
    UITextField *ui_tf_nickname;
    UIButton *ui_btn_ok;
    NSString *avatar_url;
}
@end

@implementation MBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData
{
    NSDictionary *dict = @{
                           @"action":@"getProfile"
                           };
    [[HTTPService Instance] mobileGET:SERVER_URL
                                 path:@"/responder.php"
                           parameters:[dict mutableCopy]
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  avatar_url = responseObject[@"avatar_url"];
                                  [ui_btn_avatar setImage:[UIImage imageNamed:avatar_url] forState:UIControlStateNormal];
                                  ui_tf_nickname.text = responseObject[@"nickname"];
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  //
                              }];
}

- (void)setupUI
{
    WS(ws);
    ui_btn_avatar = [UIButton new];
    ui_btn_avatar.backgroundColor = [UIColor redColor];
    [self.view addSubview:ui_btn_avatar];
    ui_btn_avatar.layer.borderWidth = 1;
    [ui_btn_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.width.height.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    
    ui_tf_nickname = [UITextField new];
    ui_tf_nickname.layer.borderWidth = 0.5;
    [self.view addSubview:ui_tf_nickname];
    [ui_tf_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_btn_avatar.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    ui_btn_ok = [UIButton new];
    [ui_btn_ok setTitle:@"确定" forState:UIControlStateNormal];
    ui_btn_ok.backgroundColor = [UIColor blueColor];
    [self.view addSubview:ui_btn_ok];
    [ui_btn_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_nickname.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(ws.view);
    }];
    
}


@end
