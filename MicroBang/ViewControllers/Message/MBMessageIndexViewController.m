//
//  MBMessageIndexViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBMessageIndexViewController.h"
#import "MBChatView.h"
@interface MBMessageIndexViewController ()

@end

@implementation MBMessageIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBChatView *view = [[MBChatView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
