//
//  MBMsgListener.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/12.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBMsgListener.h"
#import "HTTPService.h"
@implementation MBMsgListener
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

- (void)getNewMsg
{
    NSDictionary *dict = @{@"action":@"getNewMsg",@"mid":[MBUserConfig sharedInstance].mid};
    [[HTTPService Instance] mobilePOST:SERVER_URL path:@"/responder.php" parameters:[dict mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        isListening=NO;
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isListening=NO;
    }];
}

- (void)startListen
{
    while (YES) {
        if(isListening==YES){
            [self getNewMsg];
        }else{
            continue;
        }
    }
}
@end
