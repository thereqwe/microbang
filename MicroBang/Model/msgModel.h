//
//  msgModel.h
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, msgType) {
    eText,
    eVoice,
    eImg
};
typedef NS_ENUM(NSUInteger, msgFromType) {
    eMe,
    eOthers,
};
@interface msgModel : NSObject
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *pubTime;
@property (nonatomic,assign)msgType type;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *avatarUrl;
@property (nonatomic,strong)NSString *imgUrl;
@property (nonatomic,assign)msgFromType fromType;
@end
