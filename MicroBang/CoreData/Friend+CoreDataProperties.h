//
//  Friend+CoreDataProperties.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/8.
//  Copyright © 2016年 leon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSDate *create_time;
@property (nullable, nonatomic, retain) NSString *friend_mid;
@property (nullable, nonatomic, retain) NSString *avatar_url;

@end

NS_ASSUME_NONNULL_END
