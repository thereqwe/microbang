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
}

- (void)setupUI
{
    ui_lb_text = [UILabel new];
    ui_lb_text.numberOfLines = 0;
    ui_lb_text.text = @"123123123123123ffdsafasdfasdfasdfasdfsdfsdfdsfdsfdsfdsfdsf";
    [self.contentView addSubview:ui_lb_text];
    [ui_lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.bottom.mas_equalTo(-8);
    }];
}
@end
