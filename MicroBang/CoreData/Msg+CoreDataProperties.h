//
//  Msg+CoreDataProperties.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/4.
//  Copyright © 2016年 leon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Msg.h"

NS_ASSUME_NONNULL_BEGIN

@interface Msg (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *from_mid;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSDate *create_time;

@end

NS_ASSUME_NONNULL_END
