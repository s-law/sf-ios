//
//  EventsFeedViewController.m
//  SF iOS
//
//  Created by Amit Jain on 7/31/17.
//  Copyright © 2017 Amit Jain. All rights reserved.
//

#import "EventsFeedViewController.h"
#import "FeedItemCell.h"
#import "FeedItem.h"
#import "MapSnapshotter.h"

NS_ASSUME_NONNULL_BEGIN
@interface EventsFeedViewController ()

@property (nonatomic) EventDataSource *dataSource;
@property (nullable, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) MapSnapshotter *snapshotter;

@end
NS_ASSUME_NONNULL_END

@implementation EventsFeedViewController

- (instancetype)initWithDataSource:(EventDataSource *)dataSource {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.dataSource = dataSource;
        [self setupLocationManager];
        self.snapshotter = [[MapSnapshotter alloc] initWithLocationManager:self.locationManager];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    NSAssert(false, @"Use -initWithDataSource");
    self = [self initWithDataSource:nil];
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSAssert(false, @"Use -initWithDataSource");
    self = [self initWithDataSource:nil];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(false, @"Use -initWithDataSource");
    self = [self initWithDataSource:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:self.feedItemCellClass forCellReuseIdentifier:NSStringFromClass(self.feedItemCellClass)];
    self.tableView.rowHeight = self.cellHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    __weak typeof(self) welf = self;
    [self.dataSource fetchPreviousEventsWithCompletionHandler:^(BOOL didUpdate, NSError * _Nullable error) {
        [welf.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestLocationPermission];
}

//MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.numberOfEvents;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.feedItemCellClass) forIndexPath:indexPath];
    if (!cell) {
        NSAssert(false, @"cell couldn't be dequeued");
    }
    
    FeedItem *item = [[FeedItem alloc] initWithEvent:[self.dataSource eventAtIndex:indexPath.row]];
    [cell configureWithFeedItem:item snapshotter:self.snapshotter];
    
    return cell;
}

- (Class)feedItemCellClass {
    return [FeedItemCell class];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(FeedItemCell *)cell layoutMap];
}

//MARK: - Location Permission

- (void)setupLocationManager {
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    
    CLAuthorizationStatus permission = [CLLocationManager authorizationStatus];
    BOOL locationCanBeAccessed =
    permission == kCLAuthorizationStatusNotDetermined ||
    permission == kCLAuthorizationStatusAuthorizedWhenInUse ||
    permission == kCLAuthorizationStatusAuthorizedAlways;
    
    if (locationServicesEnabled || locationCanBeAccessed) {
        self.locationManager = [CLLocationManager new];
    }
}

- (void)requestLocationPermission {
    if (!self.locationManager) {
        return;
    }
    
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    BOOL permissionCanBeRequested = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined;
    if (locationServicesEnabled || permissionCanBeRequested) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

//MARK: - Cell Dimensions

static CGFloat const eventCellAspectRatio = 1.352;
//static CGFloat const eventCellMapAspectRatio = 1.02;

- (CGFloat)cellHeight{
    return [UIScreen mainScreen].bounds.size.width * eventCellAspectRatio;
}

@end
