//
//  UNNotificationContent+EventNotifications.m
//  Coffup
//
//  Created by Roderic Campbell on 5/1/19.
//

#import "UNNotificationContent+EventNotifications.h"
#import "UNNotificationAttachment+EventNotifications.h"
#import "Event.h"

@implementation UNNotificationContent (EventNotifications)
+ (UNNotificationContent *)contentForEvent:(Event *)event title:(NSString *)contentTitle body:(NSString *)contentBody {
    UNNotificationAttachment *attachment = [UNNotificationAttachment withIdentifier:event.eventID
                                                                                URL:event.imageFileURL];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body = contentBody;
    content.title = contentTitle;
    content.attachments = @[attachment];
    return [content copy];
}
@end
