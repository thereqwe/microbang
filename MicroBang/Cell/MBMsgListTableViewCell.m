//
//  MBMsgListTableViewCell.m
//  MicroBang
//
//  Created by Yue Shen on 16/6/30.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBMsgListTableViewCell.h"

@implementation MBMsgListTableViewCell
{
    UIView *ui_view_container;
    UIImageView *ui_img_avatar;
    UILabel *ui_lb_name;
    UILabel *ui_lb_msg;
    UILabel *ui_lb_pubilic_time;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier

{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI
{
    self.backgroundColor = FOGCOLOR;
    [self setRoundCorner];
    ui_view_container = [UIView new];
    [self.contentView addSubview:ui_view_container];
    [ui_view_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    ui_img_avatar = [UIImageView new];
    [ui_view_container addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.left.mas_equalTo(20);
        make.centerY.equalTo(ui_view_container);
    }];
    
    ui_lb_name = [UILabel new];
    [ui_view_container addSubview:ui_lb_name];
    [ui_lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_img_avatar.mas_right).offset(8);
        make.right.equalTo(ui_view_container).offset(-100);
        make.top.equalTo(ui_view_container).offset(20);
    }];
    
    ui_lb_msg = [UILabel new];
    [ui_view_container addSubview:ui_lb_msg];
    [ui_lb_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_img_avatar.mas_right).offset(8);
        make.right.equalTo(ui_view_container);
        make.top.equalTo(ui_lb_name.mas_bottom).offset(8);
    }];
    
    ui_lb_pubilic_time = [UILabel new];
    ui_lb_pubilic_time.textAlignment = NSTextAlignmentRight;
    ui_lb_pubilic_time.font = [UIFont systemFontOfSize:7];
    [ui_view_container addSubview:ui_lb_pubilic_time];
    [ui_lb_pubilic_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.right.equalTo(ui_view_container).offset(-8);
        make.centerY.equalTo(ui_lb_name);
    }];
}

- (void)setupData:(NSDictionary*)dict
{
    [ui_img_avatar sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar_url"]]];
    [ui_lb_name setText:dict[@"nickname"]];
    [ui_lb_msg setText:dict[@"msg"]];
    [ui_lb_pubilic_time setText:dict[@"create_time"]];
    _friend_mid = dict[@"friend_mid"];
}
@end
