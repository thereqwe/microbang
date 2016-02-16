//
//  MBPhotoView.m
//  MicroBang
//
//  Created by leon on 2016/二月/16.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPhotoView.h"

@implementation MBPhotoView
{
    UIImageView *ui_img_avatar;
    UILabel *ui_lb_nickName;
    UILabel *ui_lb_age;
    UILabel *ui_lb_distance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor grayColor];
        self.layer.borderWidth = 5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor brownColor].CGColor;
    }
    return self;
}


- (void)setupDataWithDict:(NSDictionary*)dict {
     [ui_img_avatar setImage:[UIImage imageNamed:@"bb.jpg"]];
     ui_lb_nickName.text = @"小甜甜";
     ui_lb_age.text = @"18";
     ui_lb_distance.text = @"13米";
}

- (void)setupUI {
    ui_img_avatar = [UIImageView new];
    [self addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }];
    
    ui_lb_nickName = [UILabel new];
    [self addSubview:ui_lb_nickName];
    [ui_lb_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KGlobalSmallMargin);
        make.top.equalTo(ui_img_avatar.mas_bottom).offset(8);
        make.width.mas_equalTo(150);
    }];
    
    ui_lb_age = [UILabel new];
    [self addSubview:ui_lb_age];
    [ui_lb_age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KGlobalSmallMargin);
        make.top.equalTo(ui_lb_nickName.mas_bottom).offset(KGlobalSmallMargin);
        make.width.mas_equalTo(25);
    }];
    
    ui_lb_distance = [UILabel new];
    [self addSubview:ui_lb_distance];
    [ui_lb_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_lb_age.mas_right).offset(8);
        make.top.equalTo(ui_lb_nickName.mas_bottom).offset(KGlobalSmallMargin);
        make.width.mas_equalTo(50);
    }];
}
@end
