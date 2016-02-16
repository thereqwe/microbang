//
//  MBPersonIndexViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPersonIndexViewController.h"
#import "MBRecentComeView.h"
#import "MBRecentSituationView.h"
#import "MBSetupView.h"
#import "MBHelpView.h"
@interface MBPersonIndexViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *ui_table_index;
    NSArray *itemArr;
    MBBaseNaviBar *navi;
    UISegmentedControl *ui_seg_item;
    MBSetupView *ui_view_setup;
    MBRecentComeView *ui_view_come;
    MBRecentSituationView *ui_view_situation;
    MBHelpView *ui_view_help;
}

@end

@implementation MBPersonIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    itemArr = @[@"个人动态",@"谁看过我",@"设置",@"帮助"];
    [self setupUI];
}

- (void)setupUI {
    WS(ws);
    navi = [MBBaseNaviBar new];
    navi.title = @"个人";
    [self.view addSubview:navi];
    
    ui_seg_item = [[UISegmentedControl alloc]initWithItems:itemArr];
    [ui_seg_item setSelectedSegmentIndex:0];
    [ui_seg_item addTarget:self
                         action:@selector(didClickSegmentedControlAction:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:ui_seg_item];
    [ui_seg_item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.top.mas_equalTo(kGlobalNaviHeight+KGlobalSmallMargin);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(300);
    }];
    
    [self didClickSegmentedControlAction:ui_seg_item];
}

- (void)didClickSegmentedControlAction:(UISegmentedControl *)segmentControl
{
    NSInteger idx = segmentControl.selectedSegmentIndex;
    if (idx==0) {
        if(ui_view_situation==nil){
         ui_view_situation = [MBRecentSituationView new];
            [self.view addSubview:ui_view_situation];
        }else{
            [self.view bringSubviewToFront:ui_view_situation];
        }
        
    }else if (idx==1){
        if(ui_view_come ==nil){
            ui_view_come = [MBRecentComeView new];
            [self.view addSubview:ui_view_come];
        }else{
            [self.view bringSubviewToFront:ui_view_come];
        }
        
    }else if (idx==2){
        if(ui_view_setup ==nil){
            ui_view_setup = [MBSetupView new];
            [self.view addSubview:ui_view_setup];
        }else{
            [self.view bringSubviewToFront:ui_view_setup];
        }
        
    }else if (idx==3){
        if(ui_view_help ==nil){
            ui_view_help = [MBHelpView new];
            [self.view addSubview:ui_view_help];
        }else{
            [self.view bringSubviewToFront:ui_view_help];
        }
    }
}



@end
