//
//  MBLoginViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/5.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBLoginViewController.h"
#import "MBRegisterViewController.h"
@interface MBLoginViewController ()
{
    UITextField *ui_tf_name;
    UITextField *ui_tf_pwd;
    UIButton *ui_btn_login;
    UIButton *ui_btn_register;
}
@end

@implementation MBLoginViewController
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    ui_tf_name = [UITextField new];
    ui_tf_name.placeholder = @"用户名";
    [self.view addSubview:ui_tf_name];
    [ui_tf_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    ui_tf_pwd = [UITextField new];
    ui_tf_pwd.placeholder = @"密码";
    [self.view addSubview:ui_tf_pwd];
    [ui_tf_pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_name.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    WS(ws);
    ui_btn_login = [UIButton new];
    [ui_btn_login setTitle:@"登录" forState:UIControlStateNormal];
    ui_btn_login.backgroundColor = [UIColor redColor];
    [self.view addSubview:ui_btn_login];
    [ui_btn_login addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [ui_btn_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ui_tf_pwd.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];

    ui_btn_register = [UIButton new];
    [ui_btn_register addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [ui_btn_register setTitle:@"注册" forState:UIControlStateNormal];
    ui_btn_register.backgroundColor = [UIColor blueColor];
    [self.view addSubview:ui_btn_register];
    [ui_btn_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ui_btn_login.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    for (UIView *obj in self.view.subviews) {
        if ([obj isMemberOfClass:[UITextField class]]) {
            obj.layer.cornerRadius = 4;
            obj.layer.borderWidth = 0.5;
            obj.layer.borderColor = [UIColor grayColor].CGColor;
            [self setTextFieldLeftPadding:obj forWidth:8];
        }
    }
}

- (void)doLogin
{
    NSString *name = ui_tf_name.text;
    NSString *pwd = ui_tf_pwd.text;
    NSDictionary *dict = @{@"name":name,@"pwd":pwd,@"action":@"login"};
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *msg = responseObject[@"msg"];
        if([responseObject[@"errCode"] isEqualToString:@"000"]){
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [MBUserConfig sharedInstance].mid = responseObject[@"mid"];
            [MBUserConfig sharedInstance].avatar_url = responseObject[@"avatar_url"];
            [MBUserConfig sharedInstance].nickname = responseObject[@"nickname"];
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)goRegister
{
    MBRegisterViewController *registerViewController = [MBRegisterViewController new];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}
@end
