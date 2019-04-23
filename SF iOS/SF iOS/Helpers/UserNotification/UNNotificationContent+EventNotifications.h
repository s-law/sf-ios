//
//  UNNotificationContent+EventNotifications.h
//  Coffup
//
//  Created by Roderic Campbell on 5/1/19.
//

#import <UserNotifications/UserNotifications.h>
@class Event;

NS_ASSUME_NONNULL_BEGIN

@interface UNNotificationContent (EventNotifications)
+ (UNNotificationContent *)contentForEvent:(Event *)event title:(NSString *)contentTitle body:(NSString *)contentBody;
@end

NS_ASSUME_NONNULL_END
