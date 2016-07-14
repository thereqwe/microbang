//
//  msgModel.m
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "msgModel.h"
#import "FMDBService.h"
@implementation msgModel
+(BOOL)insert:(NSString*)msg from_mid:(NSString*)from_mid create_time:(NSString*)create_time
       to_mid:(NSString*)to_mid friend_mid:(NSString*)friend_mid
{
    msg = [msg stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
    NSString *insertSql2 = [NSString stringWithFormat:
                            @"INSERT INTO %@(%@, %@, %@,%@,%@) VALUES ('%@', '%@', '%@','%@','%@')",
                            @"mb_msg", @"msg", @"from_mid", @"create_time",@"to_mid",@"friend_mid" ,msg, from_mid, create_time,to_mid,friend_mid];
   return [[FMDBService sharedInstance] executeUpdate:insertSql2];
}
@end
