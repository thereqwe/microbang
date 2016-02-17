//
//  MBPhotoWallViewController.m
//  MicroBang
//
//  Created by leon on 2016/二月/16.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBPhotoWallViewController.h"
#import "MBPhotoView.h"
@interface MBPhotoWallViewController ()
{
    UIButton *ui_btn_like;
    UIButton *ui_btn_hate;
    MBPhotoView *ui_photo_people;
    MBPhotoView *ui_photo_people2;
    MBPhotoView *ui_photo_people3;
    UIPanGestureRecognizer* panGestureRecognizer;
    CGPoint originPhotoPoint;
}
@end

@implementation MBPhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    
    ui_photo_people3 = [MBPhotoView new];
    ui_photo_people3.frame = CGRectMake(8, kGlobalNaviHeight+22, kScreenWidth-16, 400);
    [self.view addSubview:ui_photo_people3];
    [ui_photo_people3 setupDataWithDict:@{@"img":@"mega.jpg"}];
    
    ui_photo_people2 = [MBPhotoView new];
    ui_photo_people2.frame = CGRectMake(8, kGlobalNaviHeight+15, kScreenWidth-16, 400);
    [self.view addSubview:ui_photo_people2];
    [ui_photo_people2 setupDataWithDict:@{@"img":@"mega.jpg"}];

    ui_photo_people = [MBPhotoView new];
    ui_photo_people.frame = CGRectMake(8, kGlobalNaviHeight+8, kScreenWidth-16, 400);
    originPhotoPoint = ui_photo_people.layer.position;
    [self.view addSubview:ui_photo_people];
    [ui_photo_people setupDataWithDict:@{@"img":@"bb.jpg"}];
    
    //创建拖拽手势
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handlePanGestures:)];
    //无论最大还是最小都只允许一个手指
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [ui_photo_people addGestureRecognizer:panGestureRecognizer];
    
    WS(ws);
    ui_btn_like = [UIButton new];
    [ui_btn_like setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:ui_btn_like];
    [ui_btn_like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.bottom.mas_equalTo(-20);
        make.centerX.equalTo(ws.view).offset(-100);
    }];
    
    ui_btn_hate = [UIButton new];
    [ui_btn_hate setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:ui_btn_hate];
    [ui_btn_hate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.bottom.mas_equalTo(-20);
        make.centerX.equalTo(ws.view).offset(100);
    }];
    
    MBBaseNaviBar* navi = [MBBaseNaviBar new];
    navi.title = @"探一探";
    [self.view addSubview:navi];
}

- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
        NSLog(@"%f,%f",location.x,location.y);
    }else if(paramSender.state == UIGestureRecognizerStateEnded){
        if(fabs(paramSender.view.layer.position.x-originPhotoPoint.x)>150||
           fabs(paramSender.view.layer.position.y-originPhotoPoint.y)>150){
            [self fadeOutWithOffsetPositon:paramSender.view.layer.position andWithView:paramSender.view];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                paramSender.view.layer.position =originPhotoPoint;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

/**
 * 照片飞出
 */
- (void)fadeOutWithOffsetPositon:(CGPoint)position andWithView:(UIView*)view {
    CGFloat x = position.x - originPhotoPoint.x ;
    CGFloat y = position.y - originPhotoPoint.y ;
    [UIView animateWithDuration:0.8 animations:^{
        view.layer.position =CGPointMake(originPhotoPoint.x+x*3, originPhotoPoint.y+y*3);
    } completion:^(BOOL finished) {
        view.layer.position = ui_photo_people2.layer.position;
        [UIView animateWithDuration:0.2 animations:^{
             view.layer.position = originPhotoPoint;
            [ui_photo_people setupDataWithDict:@{@"img":@"mega.jpg"}];
        }];
    }];
}
@end
