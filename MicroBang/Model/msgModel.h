//
//  msgModel.h
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MsgType) {
    msg_text,
    msg_voice,
    msg_img
};
@interface msgModel : NSObject
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,assign)MsgType type;
@property (nonatomic,strong)NSString *from_mid;
@end
