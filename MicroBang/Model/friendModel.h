//
//  friendModel.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/13.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface friendModel : NSObject
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *friend_mid;
@property (nonatomic,strong)NSString *creat_time;
+(BOOL)insertDB:(NSString*)nickname
     friend_mid:(NSString*)friend_mid
    create_time:(NSString*)create_time
     avatar_url:(NSString*)avatar_url;
@end
