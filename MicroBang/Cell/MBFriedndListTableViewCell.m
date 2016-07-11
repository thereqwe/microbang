//
//  MBFriedndListTableViewCell.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/1.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBFriedndListTableViewCell.h"

@implementation MBFriedndListTableViewCell
{
    UIImageView *ui_img_avatar;
    UILabel     *ui_lb_name;
    UIView      *ui_view_container;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier

{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI
{
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

}

- (void)setupData:(NSDictionary*)dict
{
    
    [ui_img_avatar sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar_url"]]];
    [ui_lb_name setText:dict[@"nickname"]];
}

@end
