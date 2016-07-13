//
//  MBMsgListener.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/12.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBListener.h"
#import "HTTPService.h"
#import "msgModel.h"
#import "friendModel.h"
@implementation MBListener
{
    BOOL isListening;
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        isListening = NO;
    }
    return self;
}

/**
 *  获取新的消息
 */
- (void)getNewMsg
{
    isListening =YES;
    NSDictionary *dict = @{@"action":@"getNewMsg",@"mid":[MBUserConfig sharedInstance].mid};
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        isListening=NO;
          [[FMDBService sharedInstance] executeUpdate:@"delete from mb_msg"];
        NSLog(@"%@",responseObject);
        for (NSDictionary *dict in responseObject[@"data"]) {
            NSString *from_mid = dict[@"from_mid"];
            NSString *to_mid = dict[@"to_mid"];
            NSString *mid = [MBUserConfig sharedInstance].mid;
            NSString *friend_mid;
            if ([from_mid isEqualToString:mid]) {
                friend_mid = to_mid;
            }else{
                friend_mid = from_mid;
            }
            [msgModel insert:dict[@"msg"] from_mid:dict[@"from_mid"] create_time:dict[@"create_time"] to_mid:dict[@"to_mid"] friend_mid:friend_mid];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isListening=NO;
    }];
}

/**
 *  获取所有的朋友
 */
- (void)getAllFriend
{
    NSString *mid = [MBUserConfig sharedInstance].mid;
    NSDictionary *dict = @{@"mid":mid,@"action":@"getFriendList"};
    [[HTTPService Instance] mobilePOST:SERVER_URL
                                  path:@"/responder.php"
                            parameters:[dict mutableCopy]
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   if (![responseObject[@"errCode"] isEqualToString:@"000"]) {
                                       return;
                                   }
                                   NSArray *data = responseObject[@"data"];
                                   [[FMDBService sharedInstance] executeUpdate:@"delete from mb_friend"];
                                   for (NSDictionary *dict in data) {
                                       
                                       [friendModel insertDB:dict[@"nickname"] friend_mid:dict[@"friend_mid"] create_time:dict[@"create_time"] avatar_url:dict[@"avatar_url"]];
                                   }
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   
                               }];
}

/**
 * 监听器
 */
- (void)startListen
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self getAllFriend];
    });
    [self getNewMsg];
//     dispatch_async(dispatch_get_global_queue(0, 0), ^{
//         while (YES) {
//             if(isListening==NO){
//                // [self getNewMsg];
//                 NSLog(@"listiening....");
//                 sleep(2);
//             }else{
//                 continue;
//             }
//         }
//     });

}
@end
