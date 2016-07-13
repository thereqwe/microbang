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
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *from_mid;   //谁发来
@property (nonatomic,strong)NSString *to_mid;     //向谁发
@property (nonatomic,strong)NSString *friend_mid; //和哪个朋友的聊天~ 用来区分聊天!!!
+(BOOL)insert:(NSString*)msg from_mid:(NSString*)from_mid create_time:(NSString*)create_time
       to_mid:(NSString*)to_mid friend_mid:(NSString*)friend_mid;
@end
