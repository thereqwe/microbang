//
//  MBBaseNaviBar.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBBaseNaviBar.h"

@implementation MBBaseNaviBar
- (void)didMoveToSuperview
{
   [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kGlobalNaviHeight);
        make.top.mas_equalTo(0);
    }];
    self.backgroundColor = [UIColor grayColor];
}
@end