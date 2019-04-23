//
//  EventDataSourceTests.m
//  SF iOSTests
//
//  Created by Amit Jain on 7/30/17.
//  Copyright © 2017 Amit Jain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EventDataSource.h"
//#import "EventDataSource+Persistence.h"
#import <Realm/Realm.h>

@interface EventDataSourceTests : XCTestCase   //<EventDataSourceDelegate>
@property (nonatomic) RLMRealm *realmInstance;
//@property (nonatomic) EventDataSource *dataSource;
@property (nonatomic) XCTestExpectation *fetchingExpectation;
@end

@implementation EventDataSourceTests

- (void)setUp {
    _fetchingExpectation = [self expectationWithDescription:@"Wait for events"];

    RLMRealmConfiguration *realmConfiguration = [RLMRealmConfiguration defaultConfiguration];

    realmConfiguration.fileURL = [[[realmConfiguration.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:@"UnitTest"]
                      URLByAppendingPathExtension:@"realm"];
    
    // In-memory Realms do not save data across app launches, but all other features of Realm will work as expected, including querying, relationships and thread-safety. This is a useful option if you need flexible data access without the overhead of disk persistence.
//    [realmConfiguration setInMemoryIdentifier:@"UnitTest"];

    [RLMRealmConfiguration setDefaultConfiguration:realmConfiguration];

    self.realmInstance = [RLMRealm realmWithConfiguration:realmConfiguration error:nil];
    
    [self clearRealmDatabase];
    /*
    self.dataSource = [[EventDataSource alloc] initWithEventType:EventTypeSFCoffee withRealmConfiguration:realmConfiguration];
    
    self.dataSource.delegate = self;
    */
    [super setUp];
}

- (void)clearRealmDatabase {
    [self.realmInstance beginWriteTransaction];
    [self.realmInstance deleteAllObjects];
    [self.realmInstance commitWriteTransaction];
}
/*
- (void)testFetchingCoffeeEvents {
    XCTAssertEqual(self.dataSource.numberOfEvents, 0);

    [self.dataSource refresh];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

// MARK: - EventDataSourceDelegate
- (void)didChangeDataSourceWithInsertions:(nullable NSArray<NSIndexPath *> *)insertions updates:(nullable NSArray<NSIndexPath *> *)updates deletions:(nullable NSArray<NSIndexPath *> *)deletions {
    [_fetchingExpectation fulfill];
    // The hard-coded value is not great, but the endpoint URL is currently hard-coded 2019-04-22
    XCTAssertGreaterThanOrEqual(self.dataSource.numberOfEvents, 70);
}

- (void)didFailToUpdateWithError:(nonnull NSError *)error {
}

- (void)willUpdateDataSource:(EventDataSource *)datasource {
}
*/
@end
