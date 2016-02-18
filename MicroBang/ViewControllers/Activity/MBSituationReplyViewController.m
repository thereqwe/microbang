//
//  MBSituationReplyViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/17.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBSituationReplyViewController.h"

@interface MBSituationReplyViewController ()

@end

@implementation MBSituationReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    MBBaseNaviBar *navi = [MBBaseNaviBar new];
    navi.title = @"回复";
    [self.view addSubview:navi];
}

@end
