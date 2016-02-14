//
//  MBSetupView.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBSetupView.h"

@implementation MBSetupView
{
    UITableView *ui_table_situation;
}

-(void)didMoveToSuperview {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.backgroundColor = [UIColor brownColor];
}

@end
