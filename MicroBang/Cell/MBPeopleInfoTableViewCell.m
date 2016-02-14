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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupDataWithDict:(NSDictionary*)dict {
    [ui_img_avatar setImage:[UIImage imageNamed:@"bb.jpg"]];
}

- (void)setupUI {
    WS(ws);
    ui_img_avatar = [UIImageView new];
    [self addSubview:ui_img_avatar];
    [ui_img_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(ws.mas_centerY);
        make.left.mas_equalTo(KGlobalSmallMargin);
    }];
}
@end