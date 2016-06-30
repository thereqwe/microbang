//
//  MBMsgListViewController.m
//  MicroBang
//
//  Created by Yue Shen on 16/6/30.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBMsgListViewController.h"

@implementation MBMsgListViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"消息";
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end
