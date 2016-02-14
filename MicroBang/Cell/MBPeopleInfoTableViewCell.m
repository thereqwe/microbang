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
        make.right.mas_equalTo(-8);
    }];
}
@end