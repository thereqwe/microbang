//
//  MBProfileViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/8.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBProfileViewController.h"
#import "MBLoginViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface MBProfileViewController ()<UIImagePickerControllerDelegate>
{
    UIButton *ui_btn_avatar;
    UITextField *ui_tf_nickname;
    UIButton *ui_btn_ok;
    UIButton *ui_btn_logout;
    NSString *avatar_url;
    UIImagePickerController *imagePickerController;
}
@end

@implementation MBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
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
                                  [ui_btn_avatar sd_setImageWithURL:[NSURL URLWithString:avatar_url] forState:UIControlStateNormal];
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
//    ui_btn_avatar.backgroundColor = [UIColor redColor];
    [self.view addSubview:ui_btn_avatar];
    [ui_btn_avatar addTarget:self action:@selector(doEditAvatar) forControlEvents:UIControlEventTouchUpInside];
//    ui_btn_avatar.layer.borderWidth = 1;
    [ui_btn_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.width.height.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    
    ui_tf_nickname = [UITextField new];
    ui_tf_nickname.placeholder = @"请输入昵称";
    ui_tf_nickname.layer.borderWidth = 0.5;
    ui_tf_nickname.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ui_tf_nickname];
    [ui_tf_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_btn_avatar.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    ui_btn_ok = [UIButton new];
    [ui_btn_ok setTitle:@"确定" forState:UIControlStateNormal];
    ui_btn_ok.backgroundColor = PURPLECOLOR;
    [self.view addSubview:ui_btn_ok];
    [ui_btn_ok addTarget:self action:@selector(doEditProfile) forControlEvents:UIControlEventTouchUpInside];
    [ui_btn_ok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_nickname.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(ws.view);
    }];
    
    ui_btn_logout = [UIButton new];
    ui_btn_logout.backgroundColor = [UIColor redColor];
    [self.view addSubview:ui_btn_logout];
    [ui_btn_logout setTitle:@"登出" forState:UIControlStateNormal];
    [ui_btn_logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [ui_btn_logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_btn_ok.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(ws.view);
    }];

}

- (void)doEditAvatar
{
    imagePickerController = [[UIImagePickerController alloc]init];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.sourceType = sourcheType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取照片的原图
    UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取图片裁剪的图
    UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"%@,%@",original,edit);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSDictionary *dict = @{@"mid":[MBUserConfig sharedInstance].mid};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/javascript", @"text/plain", nil];
    AFHTTPRequestOperation *op = [manager POST:[NSString stringWithFormat:@"%@/%@",SERVER_URL,@"imageUpload.php"] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(edit, 1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject  ;
       // NSLog(@"%@",[[NSString alloc]initWithData:data encoding:kCFStringEncodingUTF8]);
        if([responseObject[@"errCode"] isEqualToString:@"000"]){
            avatar_url = responseObject[@"avatar_url"];
            [ui_btn_avatar sd_setImageWithURL:[NSURL URLWithString:avatar_url] forState:UIControlStateNormal];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"err %@",error);
    }];

}

- (void)doEditProfile
{
    NSString *nickname = ui_tf_nickname.text;
    NSDictionary *dict = @{@"avatar_url":avatar_url,
                           @"nickname":nickname,
                           @"action":@"editProfile"
                           };
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)logout
{
    [[MBUserConfig sharedInstance] logOut];
    MBLoginViewController *vc = [MBLoginViewController new];
    [self presentViewController:vc animated:YES completion:^{
    }];
}
@end
