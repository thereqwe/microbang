//
//  MBChatTableViewCell.h
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "msgModel.h"
@interface MBChatTableViewCell : UITableViewCell

- (void)setDataWithModel:(msgModel*)msg;
@end
