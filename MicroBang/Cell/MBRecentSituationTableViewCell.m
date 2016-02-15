//
//  MBRecentSituationTableViewCell.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBRecentSituationTableViewCell.h"

@implementation MBRecentSituationTableViewCell
{
    UIImageView *ui_img_avatar;
    UILabel *ui_lb_nickName;
    UILabel *ui_lb_age;
    UILabel *ui_lb_pubTime;
    UILabel *ui_lb_commentNum;
    UILabel *ui_lb_favorNum;
    UIImageView *ui_img_sex;
    UIImageView *ui_img_heart;
    UIImageView *ui_img_bubble;
    UIImageView *ui_img_clock;
    UILabel *ui_lb_article; //正文内容
    //图片数组
    NSArray *imgArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:(UITableViewCellStyle)style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupDataWithDict:(NSDictionary*)dict {
    [ui_img_avatar setImage:[UIImage imageNamed:@"bb.jpg"]];
    
    [ui_lb_article setText:@"好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜好吧今天我来show一下!!!床前明月光,疑是地上霜"];
    ui_lb_article.numberOfLines = 0;
    
    [ui_lb_commentNum setText:@"评100"];
    [ui_lb_favorNum setText:@"赞10"];
    [ui_lb_pubTime setText:@"19分钟"];
    [ui_lb_nickName setText:@"纯情小火鸡"];
}

- (void)setupUI {
    ui_img_avatar = [UIImageView new];
    [self addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    
    ui_lb_nickName = [UILabel new];
    [self addSubview:ui_lb_nickName];
    [ui_lb_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_img_avatar.mas_right).offset(KGlobalSmallMargin);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-40);
    }];
    
    ui_lb_pubTime = [UILabel new];
    [self addSubview:ui_lb_pubTime];
    [ui_lb_pubTime setTextAlignment:NSTextAlignmentRight];
    [ui_lb_pubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    ui_lb_article = [UILabel new];
    [self addSubview:ui_lb_article];
    [ui_lb_article mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_img_avatar.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    ui_lb_commentNum = [UILabel new];
    [self addSubview:ui_lb_commentNum];
    [ui_lb_commentNum setTextAlignment:NSTextAlignmentRight];
    [ui_lb_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.equalTo(ui_lb_article.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(-10);
    }];
    
    ui_lb_favorNum = [UILabel new];
    [self addSubview:ui_lb_favorNum];
    [ui_lb_favorNum setTextAlignment:NSTextAlignmentRight];
    [ui_lb_favorNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ui_lb_commentNum.mas_left).offset(-20);
        make.top.equalTo(ui_lb_article.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
                make.bottom.mas_equalTo(-10);
    }];
    
}
@end
