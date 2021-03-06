//
//  AffogatoStyle.m
//  Coffup
//
//  Created by Zachary Drayer on 4/21/19.
//

#import "AffogatoStyle.h"
#import "DynamicTypeFonts.h"
#import <UIKit/UIKit.h>

@interface AffogatoStyleColors : NSObject <Colors>
@end

@implementation AffogatoStyleColors

- (UIColor *)backgroundColor {
	return UIColor.whiteColor;
}

- (UIColor *)tintColor {
	return UIColor.blackColor;
}

- (UIColor *)loadingColor {
	return [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]; // alabaster
}

- (UIColor *)shadowColor {
	return [UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1.0]; // nobel
}

- (UIColor *)primaryTextColor {
	return UIColor.blackColor;
}

- (UIColor *)secondaryTextColor {
	return [UIColor colorWithRed:0.35 green:0.35 blue:0.37 alpha:1.0]; // abbey
}

- (UIColor *)inactiveTextColor {
	return [UIColor.blackColor colorWithAlphaComponent:0.22];
}

@end

@implementation AffogatoStyle

+ (NSString *)identifier {
	return NSStringFromClass(self.class);
}

@synthesize colors = _colors;
@synthesize fonts = _fonts;

- (instancetype)init {
	self = [super init];
	NSAssert(self != nil, @"[super init] should never fail");

	_colors = [[AffogatoStyleColors alloc] init];
	_fonts = [[DynamicTypeFonts alloc] init];

	return self;
}

@end
