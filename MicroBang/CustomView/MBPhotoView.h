//
//  MBPhotoView.h
//  MicroBang
//
//  Created by leon on 2016/二月/16.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBPhotoView : UIView
@property (nonatomic,assign)CGPoint originPositionPoint;
- (void)setupDataWithDict:(NSDictionary*)dict ;
@end
