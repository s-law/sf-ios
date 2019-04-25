//
//  EventDataSource+RealmConfiguration.m
//  SF iOSTests
//
//  Created by Jerry Tung on 4/24/19.
//

#import "EventDataSource+RealmConfiguration.h"

@implementation EventDataSource (RealmConfiguration)

- (instancetype)initWithEventType:(EventType)eventType withRealmConfiguration:(RLMRealmConfiguration* _Nullable)realmConfiguration {
    if (self = [self initWithEventType:eventType]) {}
    
    return self;
}
@end
