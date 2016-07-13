//
//  MBMsgListener.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/12.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBListener : NSObject
+ (instancetype)sharedInstance;
- (void)getNewMsg;
- (void)startListen;
@end
