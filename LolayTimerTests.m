//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <SenTestingKit/SenTestingKit.h>
#import "LolayTimer.h"

@interface LolayTimerTests : SenTestCase

@end

@implementation LolayTimerTests

- (void) testStartStop {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testStartStop"];
	[timer start];
	
	[NSThread sleepForTimeInterval:1];
	
	[timer stop];
	
	STAssertTrue([[timer seconds] integerValue] == 1, @"The timer was not one second");
	STAssertTrue([[timer milliseconds] integerValue] > 990 && [[timer milliseconds] integerValue] < 1010,
				 @"The timer was not between 990 and 1010 milliseconds");
	STAssertTrue([[timer nanoseconds] integerValue] > 990000000 && [[timer nanoseconds] integerValue] < 1010000000,
				 @"The timer was not between 990000000 and 1010000000 nanoseconds");
	[timer release];
}

- (void) testNils {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testNils"];
	
	STAssertTrue([timer seconds] == nil, @"The not-started timer was not nil");
	STAssertTrue([timer milliseconds] == nil, @"The not-started timer was not nil");
	STAssertTrue([timer nanoseconds] == nil, @"The not-started timer was not nil");
	
	[timer start];
	
	STAssertTrue([timer seconds] == nil, @"The started timer was not nil");
	STAssertTrue([timer milliseconds] == nil, @"The started timer was not nil");
	STAssertTrue([timer nanoseconds] == nil, @"The started timer was not nil");
	
	[timer release];
}

@end
