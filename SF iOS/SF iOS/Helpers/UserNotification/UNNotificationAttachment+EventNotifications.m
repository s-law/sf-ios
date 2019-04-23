//
//  UNNotificationAttachment+EventNotifications.m
//  Coffup
//
//  Created by Roderic Campbell on 5/1/19.
//

#import "UNNotificationAttachment+EventNotifications.h"

@implementation UNNotificationAttachment (EventNotifications)

+ (UNNotificationAttachment *)withIdentifier:(NSString *)string URL:(NSURL *)url {
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
