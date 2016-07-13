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
-(BOOL)insert:(NSString*)msg from_mid:(NSString*)from_mid create_time:(NSString*)create_time
{
    NSString *insertSql2 = [NSString stringWithFormat:
                            @"INSERT INTO %@(%@, %@, %@) VALUES ('%@', '%@', '%@')",
                            @"msg", @"msg", @"from_mid", @"create_time", msg, from_mid, create_time];
   return [[FMDBService sharedInstance] executeUpdate:insertSql2];
}
@end
