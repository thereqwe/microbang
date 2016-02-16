//
//  MBPhotoWallViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/16.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPhotoWallViewController.h"
#import "MBPhotoView.h"
@interface MBPhotoWallViewController ()
{
    UIButton *ui_btn_like;
    UIButton *ui_btn_hate;
    MBPhotoView *ui_photo_people;
}
@end

@implementation MBPhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    ui_photo_people = [MBPhotoView new];
    ui_photo_people.frame = CGRectMake(8, kGlobalNaviHeight+8, kScreenWidth-16, 400);
    [self.view addSubview:ui_photo_people];
    [ui_photo_people setupDataWithDict:nil];
    
    WS(ws);
    ui_btn_like = [UIButton new];
    [ui_btn_like setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:ui_btn_like];
    [ui_btn_like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.bottom.mas_equalTo(-20);
        make.centerX.equalTo(ws.view).offset(-100);
    }];
    
    ui_btn_hate = [UIButton new];
    [ui_btn_hate setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:ui_btn_hate];
    [ui_btn_hate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.bottom.mas_equalTo(-20);
        make.centerX.equalTo(ws.view).offset(100);
    }];
    
    MBBaseNaviBar* navi = [MBBaseNaviBar new];
    navi.title = @"探一探";
    [self.view addSubview:navi];
}

@end
