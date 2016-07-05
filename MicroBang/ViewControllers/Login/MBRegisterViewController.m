//
//  MBRegisterViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/5.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBRegisterViewController.h"
@interface MBRegisterViewController ()

@end

@implementation MBRegisterViewController
{
    UITextField *ui_tf_name;
    UITextField *ui_tf_pwd;
    UITextField *ui_tf_pwd_repeat;
    UIButton *ui_btn_register;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    WS(ws);
    self.view.backgroundColor = [UIColor whiteColor];
    ui_tf_pwd = [UITextField new];
    ui_tf_pwd.placeholder = @"密码";
    [self.view addSubview:ui_tf_pwd];
    [ui_tf_pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.view).offset(-100);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(44);
    }];
    
    ui_tf_name = [UITextField new];
    ui_tf_name.placeholder = @"用户名";
    [self.view addSubview:ui_tf_name];
    [ui_tf_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ui_tf_pwd.mas_top).offset(-10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(44);
    }];
    
    ui_tf_pwd_repeat = [UITextField new];
    ui_tf_pwd_repeat.placeholder = @"重复密码";
    [self.view addSubview:ui_tf_pwd_repeat];
    [ui_tf_pwd_repeat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_pwd.mas_bottom).offset(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(44);
    }];
    
    ui_btn_register = [UIButton new];
    ui_btn_register.backgroundColor = [UIColor blueColor];
    [ui_btn_register setTitle:@"注册" forState:UIControlStateNormal];
    [ui_btn_register addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ui_btn_register];
    [ui_btn_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_pwd_repeat.mas_bottom).offset(10);
        make.centerX.equalTo(ws.view);
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

- (void)doRegister
{
    NSString *name = ui_tf_name.text;
    NSString *pwd = ui_tf_pwd.text;
    NSString *pwd_repeat = ui_tf_pwd_repeat.text;
    if([name isEqualToString:@""]||[pwd isEqualToString:@""]){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入用户名密码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(![pwd isEqualToString:pwd_repeat]){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"重复密码有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSDictionary *dict = @{@"name":name,@"pwd":pwd,@"action":@"register"};
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if(![responseObject[@"errCode"] isEqualToString:@"000"]){
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
