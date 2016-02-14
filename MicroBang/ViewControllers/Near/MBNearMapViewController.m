//
//  MBNearMapViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBNearMapViewController.h"

@interface MBNearMapViewController ()
{
    MAMapView *mapView;
    UIButton * ui_btn_close;
}
@end

@implementation MBNearMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    self.edgesForExtendedLayout  = self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)setupUI {
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mapView.delegate = self;
    [self.view addSubview:mapView];

    ui_btn_close = [UIButton new];
    [ui_btn_close setTitleColor:themeBlue forState:UIControlStateNormal];
    [ui_btn_close setTitle:@"关闭" forState:UIControlStateNormal];
    [ui_btn_close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ui_btn_close];
    [ui_btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-30);
        make.right.mas_equalTo(-8);
    }];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
