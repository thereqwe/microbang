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
    return self;
}

- (void)setupUI
{
    
    ui_img_avatar = [UIImageView new];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        <#code#>
    }]
}
@end
