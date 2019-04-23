//
//  UNNotificationAttachment+EventNotifications.h
//  Coffup
//
//  Created by Roderic Campbell on 5/1/19.
//

#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface UNNotificationAttachment (EventNotifications)
+ (UNNotificationAttachment *)withIdentifier:(NSString *)string URL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
