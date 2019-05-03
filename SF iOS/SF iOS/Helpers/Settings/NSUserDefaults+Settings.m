//
//  NSUserDefaults+Settings.m
//  SF iOS
//
//  Created by Zachary Drayer on 4/8/19.
//

#import "NSUserDefaults+Settings.h"
#import "Group.h"

@implementation NSUserDefaults (Settings)

- (NSString *)SFIOS_directionsProviderKey {
    return NSStringFromSelector(@selector(directionsProvider));
}

- (NSString *)SFIOS_notifiationsDictionaryKey {
    return NSStringFromSelector(@selector(notificationSettingForGroup:));
}

- (SettingsDirectionProvider)directionsProvider {
    return [self integerForKey:self.SFIOS_directionsProviderKey];
}

- (void)setDirectionsProvider:(SettingsDirectionProvider)directionsProvider {
    [self setInteger:directionsProvider forKey:self.SFIOS_directionsProviderKey];
}

- (void)setNotificationSetting:(BOOL)isOn forGroup:(Group *)group {
    NSNumber *newValue = [NSNumber numberWithBool:isOn];
    NSString *key = self.SFIOS_notifiationsDictionaryKey;
    NSMutableDictionary<NSString *, NSNumber *> *settingsDictionary = [[self dictionaryForKey:key] mutableCopy];
    if (settingsDictionary == nil) {
        settingsDictionary = [[NSMutableDictionary<NSString *, NSNumber *> alloc] initWithObjectsAndKeys:newValue,
                              group.groupID,
                              nil];
    } else {
        [settingsDictionary setObject:newValue forKey:group.groupID];
    }
    [self setObject:settingsDictionary forKey:key];
}


- (BOOL)notificationSettingForGroup:(Group *)group {
    NSDictionary *settingsDictionary = [self dictionaryForKey:self.SFIOS_notifiationsDictionaryKey];
    return [[settingsDictionary valueForKey:group.groupID] boolValue];
    return [self boolForKey:group.groupID];
}

@end
