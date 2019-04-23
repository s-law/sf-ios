//
//  UNUserNotificationCenter+EventNotifications.h
//  Coffup
//
//  Created by Roderic Campbell on 5/1/19.
//

#import <UserNotifications/UserNotifications.h>
#import "EventNotificationType.h"
@class Event;

NS_ASSUME_NONNULL_BEGIN

@interface UNUserNotificationCenter (EventNotifications)
+ (void)scheduleLocalNotificationForEvent:(Event *)event type:(EventNotificationType)type;

@end

NS_ASSUME_NONNULL_END
