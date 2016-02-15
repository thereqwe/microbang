//
//  MBPeopleInfoTableViewCell.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPeopleInfoTableViewCell.h"

@implementation MBPeopleInfoTableViewCell
{
    UIImageView *ui_img_avatar;
    UILabel *ui_label_nickName;
    UILabel *ui_label_slogan;
    UILabel *ui_label_age;
    UILabel *ui_label_pubTime;
    UILabel *ui_label_distance;
    UIImageView *ui_img_sex; //红女蓝男
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:(UITableViewCellStyle)style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupDataWithDict:(NSDictionary*)dict {
    [ui_img_avatar setImage:[UIImage imageNamed:@"bb.jpg"]];
    ui_label_nickName.text = @"天才小火枪";
    ui_label_slogan.text = @"我的未来我做主,我就是我是颜色不一样的烟火~!!!!";
    ui_label_age.text = @"24";
    ui_label_pubTime.text = @"2015-12-25";
    ui_label_distance.text = @"距离250米";
}

- (void)setupUI {
    WS(ws);
    ui_img_avatar = [UIImageView new];
    ui_img_avatar.layer.cornerRadius = 10;
    ui_img_avatar.layer.masksToBounds = YES;
    [self addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.centerY.equalTo(ws.mas_centerY);
        make.left.mas_equalTo(KGlobalSmallMargin*2);
    }];
    
    ui_label_nickName = [UILabel new];
    [self addSubview:ui_label_nickName];
    [ui_label_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.equalTo(ui_img_avatar.mas_right).offset(8);
        make.width.mas_equalTo(100);
    }];
    
    ui_label_slogan = [UILabel new];
    [self addSubview:ui_label_slogan];
     ui_label_slogan.font = [UIFont systemFontOfSize:12];
    ui_label_slogan.textColor = [UIColor grayColor];
    [ui_label_slogan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_img_avatar.mas_right).offset(KGlobalSmallMargin);
        make.top.equalTo(ui_label_nickName.mas_bottom).offset(KGlobalSmallMargin);
        make.right.mas_equalTo(-8);
    }];
    
    ui_label_age = [UILabel new];
    ui_label_age.textColor = [UIColor grayColor];
    [self addSubview:ui_label_age];
    [ui_label_age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_label_nickName.mas_right).offset(KGlobalSmallMargin);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(50);
    }];
    
    ui_label_pubTime = [UILabel new];
    ui_label_pubTime.textColor = [UIColor grayColor];
    ui_label_pubTime.textAlignment = NSTextAlignmentRight;
    [self addSubview:ui_label_pubTime];
    [ui_label_pubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(250);
    }];

    ui_label_distance = [UILabel new];
    ui_label_distance.textColor = [UIColor grayColor];
    ui_label_distance.font = [UIFont systemFontOfSize:10];
    [self addSubview:ui_label_distance];
    [ui_label_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_img_avatar.mas_right).offset(KGlobalSmallMargin);
        make.top.equalTo(ui_label_slogan.mas_bottom).offset(2);
        make.width.mas_equalTo(200);
        make.bottom.mas_equalTo(-KGlobalSmallMargin);
    }];
}
@end