//
//  friendModel.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/13.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "friendModel.h"
#import "FMDBService.h"
@implementation friendModel
+(BOOL)insertDB:(NSString*)nickname
     friend_mid:(NSString*)friend_mid
    create_time:(NSString*)create_time
     avatar_url:(NSString*)avatar_url
{
    NSString *insertSql2 = [NSString stringWithFormat:
                            @"INSERT INTO %@(%@, %@, %@,%@) VALUES ('%@', '%@', '%@','%@')",
                            @"mb_friend", @"friend_mid", @"nickname", @"create_time",@"avatar_url", friend_mid, nickname, create_time,avatar_url];
    return [[FMDBService sharedInstance] executeUpdate:insertSql2];
}
@end
