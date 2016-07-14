//
//  MBChatTableViewCell.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/4.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatTableViewCell.h"

@implementation MBChatTableViewCell
{
    UIImageView *ui_img_avatar;
    UILabel *ui_lb_text;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier

{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

/**
 *  set cell value
 *
 *  @param dict <#dict description#>
 */
-(void)setupDataWithDict:(NSDictionary*)dict
{
    ui_lb_text.text = dict[@"msg"];
    NSString *from_mid = dict[@"from_mid"];
    if([from_mid isEqualToString:[MBUserConfig sharedInstance].mid]){
        [ui_img_avatar sd_setImageWithURL:[MBUserConfig sharedInstance].avatar_url];
    }else{
        [ui_img_avatar sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar_url"]]];
    }
}

- (void)setupUI
{
    WS(ws);
    ui_img_avatar = [UIImageView new];
    [self.contentView addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
    ui_lb_text = [UILabel new];
    ui_lb_text.numberOfLines = 0;
    ui_lb_text.text = @"123123123123123ffdsafasdfasdfasdfasdfsdfsdfdsfdsfdsfdsfdsf";
    [self.contentView addSubview:ui_lb_text];
    [ui_lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.equalTo(ui_img_avatar.mas_right).offset(8);
        make.right.mas_equalTo(-8);
        make.bottom.mas_equalTo(-8);
    }];
}
@end
