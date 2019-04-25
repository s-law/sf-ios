//
//  EventDataSource+RealmConfiguration.h
//  SF iOSTests
//
//  Created by Jerry Tung on 4/24/19.
//

#import "EventDataSource.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventDataSource (RealmConfiguration)
- (instancetype)initWithEventType:(EventType)eventType withRealmConfiguration:(RLMRealmConfiguration* _Nullable)realmConfiguration;

@end

NS_ASSUME_NONNULL_END
