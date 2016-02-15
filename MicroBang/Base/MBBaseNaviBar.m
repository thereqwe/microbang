//
//  MBBaseNaviBar.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBBaseNaviBar.h"

@implementation MBBaseNaviBar
{
      UIButton  * ui_btn_title;
}

- (void)didMoveToSuperview
{
    if (self.superview==nil) {
        return;
    }
   [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kGlobalNaviHeight);
        make.top.mas_equalTo(0);
    }];
    self.backgroundColor = themeWhite;
    
    WS(ws);
    ui_btn_title = [UIButton new];
    [ui_btn_title setTitleColor:themeBlue forState:UIControlStateNormal];
    [ui_btn_title setTitle:_title forState:UIControlStateNormal];
    [self addSubview:ui_btn_title];
    [ui_btn_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws);
        make.centerY.mas_equalTo(ws).offset(KGlobalSmallMargin);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
}
@end