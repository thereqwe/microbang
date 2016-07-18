//
//  MBUserConfig.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/11.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBUserConfig : NSObject
@property (nonatomic,copy)NSString *mid;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *avatar_url;
+ (instancetype)sharedInstance;
- (void)logOut;
@end
