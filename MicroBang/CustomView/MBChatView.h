//
//  MBChatView.h
//  MicroBang
//
//  Created by leon on 2016/二月/17.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>
@interface MBChatView : UIView
<
UITableViewDelegate,
UITableViewDataSource,
GCDAsyncUdpSocketDelegate
>
@end
