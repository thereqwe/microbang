//
//  MBMsgListTableViewCell.h
//  MicroBang
//
//  Created by Yue Shen on 16/6/30.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBMsgListTableViewCell : UITableViewCell
@property(nonatomic,copy)NSString *friend_mid;
- (void)setupData:(NSDictionary*)dict;
@end
