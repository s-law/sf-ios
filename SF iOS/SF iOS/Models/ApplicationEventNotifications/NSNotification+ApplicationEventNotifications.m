//
//  NSNotification+ApplicationEventNotifications.m
//  SF iOS
//
//  Created by Amit Jain on 8/2/17.
//  Copyright © 2017 Amit Jain. All rights reserved.
//

#import "NSNotification+ApplicationEventNotifications.h"
#import "UIApplication+Metadata.h"
#import <UserNotifications/UserNotifications.h>
@import UIKit;

@implementation NSNotification (ApplicationEventNotifications)

+ (NSNotificationName)applicationBecameActiveNotification {
    return [NSString stringWithFormat:@"%@.applicationBecameActiveNotification", [UIApplication sharedApplication].bundleIdentifier];
}

+ (UNNotificationAttachment *)createWithIdentifier:(NSString *)string URL:(NSURL *)url {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *subFolderName = NSProcessInfo.processInfo.globallyUniqueString;

    NSURL *subFolderURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:subFolderName isDirectory:YES];

    NSError *error = nil;
    [fileManager createDirectoryAtURL:subFolderURL
          withIntermediateDirectories:TRUE
                           attributes:nil
                                error:&error];
    if (error != nil) {
        NSLog(@"error is %@", error);
        return nil;
    }
    NSString *imageFileIdentifier = [string stringByAppendingString:@".png"];
    NSURL *fileURL = [subFolderURL URLByAppendingPathComponent:imageFileIdentifier];

    // should probably be backgrounded
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    if (![imageData writeToURL:fileURL atomically:TRUE]) {
        return nil;
    }

    return [UNNotificationAttachment attachmentWithIdentifier:imageFileIdentifier
                                                          URL:fileURL
                                                      options:nil
                                                        error:&error];
}
@end
