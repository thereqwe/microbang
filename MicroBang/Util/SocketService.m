//
//  SocketService.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/12.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "SocketService.h"

@implementation SocketService
+ (instancetype)sharedInstance
{
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}
@end
