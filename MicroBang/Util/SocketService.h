//
//  SocketService.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/12.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/AsyncUdpSocket.h>
@interface SocketService : AsyncUdpSocket
+ (instancetype)sharedInstance;
@end
