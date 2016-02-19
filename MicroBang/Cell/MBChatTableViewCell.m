//
//  MBChatTableViewCell.m
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBChatTableViewCell.h"
#define iconWidth 25
#define iconHeight 25
@implementation MBChatTableViewCell
{
    UIView *ui_view_container;
    UIImageView *ui_img_avatar;
    UILabel *ui_lb_article;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setDataWithModel:(msgModel*)msg {
    ui_lb_article.text = msg.text;
    ui_lb_article.lineBreakMode =UILineBreakModeCharacterWrap;
    [ui_img_avatar sd_setImageWithURL:[NSURL URLWithString: msg.avatarUrl]];
    CGFloat msgWidth = [UILabel getWidthWithTitle:msg.text font:ui_lb_article.font];
    if(msgWidth>200){
        msgWidth=200;
    }
    if (msg.fromType==eOthers) {
        ui_lb_article.backgroundColor = [UIColor grayColor];
        [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(iconWidth);
            make.height.mas_equalTo(iconHeight);
            make.left.mas_equalTo(KGlobalSmallMargin);
            make.top.mas_equalTo(KGlobalSmallMargin);
        }];
        [ui_lb_article mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ui_img_avatar.mas_right).offset(KGlobalSmallMargin);
            make.top.mas_equalTo(KGlobalSmallMargin);
            make.width.mas_equalTo(msgWidth);
            make.bottom.mas_equalTo(-20);
        }];
    }else if(msg.fromType== eMe){
       // ui_lb_article.textAlignment = NSTextAlignmentRight;
        ui_lb_article.backgroundColor = [UIColor greenColor];
        [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(iconWidth);
            make.height.mas_equalTo(iconHeight);
            make.right.mas_equalTo(-KGlobalSmallMargin);
            make.top.mas_equalTo(KGlobalSmallMargin);
        }];
        [ui_lb_article mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ui_img_avatar.mas_left).offset(-KGlobalSmallMargin);
            make.top.mas_equalTo(KGlobalSmallMargin);
            make.width.mas_equalTo(msgWidth);
            make.bottom.mas_equalTo(-20);
        }];
        [self layoutIfNeeded];
    }
}

- (void)setupUI {
    //ui_view_container = [UIView new];
    //[self addSubview:ui_view_container];
    //[ui_view_container mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.left.bottom.right.mas_equalTo(0);
        //make.height.mas_equalTo(120);
    //}];
    
    ui_img_avatar = [UIImageView new];
    [self addSubview:ui_img_avatar];
    
    ui_lb_article = [UILabel new];
    ui_lb_article.numberOfLines = 0;
    
    [self addSubview:ui_lb_article];
}

@end
