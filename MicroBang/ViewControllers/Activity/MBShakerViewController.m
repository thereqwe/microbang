//
//  MBShakerViewController.m
//  MicroBang
//  摇一摇
//  Created by leon on 2016/二月/15.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBShakerViewController.h"

@interface MBShakerViewController ()

@end

@implementation MBShakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    MBBaseNaviBar *navi = [MBBaseNaviBar new];
    navi.title =@"摇一摇";
    [self.view addSubview:navi];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionend");
}
@end
