//
//  MBHelpView.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBHelpView.h"

@implementation MBHelpView
{
    UITableView *ui_table_situation;
    UILabel *ui_lb_article;
}

-(void)didMoveToSuperview {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self setupUI];
    [self setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupUI {
    WS(ws);
    ui_lb_article = [UILabel new];
    ui_lb_article.numberOfLines = 0;
    ui_lb_article.text = @"邮箱52348996@qq.com";
    [self addSubview:ui_lb_article];
    [ui_lb_article mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(KGlobalSmallMargin);
        make.right.mas_equalTo(-8);
    }];
}
@end
