//
//  MBUserConfig.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/11.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "MBUserConfig.h"

@implementation MBUserConfig
@synthesize avatar_url;
@synthesize nickname;
@synthesize mid;


+ (instancetype)sharedInstance
{
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (void)setMid:(NSString *)_mid
{
    [[NSUserDefaults standardUserDefaults] setObject:_mid forKey:@"mid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAvatar_url:(NSString *)_avatar_url
{
    [[NSUserDefaults standardUserDefaults] setObject:_avatar_url forKey:@"avatar_url"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setNickname:(NSString *)_nickname
{
    [[NSUserDefaults standardUserDefaults] setObject:_nickname forKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)nickname
{
    NSString *_nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    if(_nickname == nil){
        return @"";
    }else{
        return _nickname;
    }
}

- (NSString *)avatar_url
{
    NSString *_avatar_url = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar_url"];
    if(_avatar_url == nil){
        return @"";
    }else{
        return _avatar_url;
    }
}

- (NSString *)mid
{
    NSString *_mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"mid"];
    if(_mid == nil){
        return @"";
    }else{
        return _mid;
    }
}
@end
