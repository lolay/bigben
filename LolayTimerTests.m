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
	
	STAssertTrue([[timer seconds] unsignedIntegerValue] == 1, @"The timer was not 1 second");
	STAssertTrue([[timer milliseconds] unsignedIntegerValue] > 990 && [[timer milliseconds] unsignedIntegerValue] < 1010,
				 @"The timer was not 1,000 milliseconds");
	STAssertTrue([[timer nanoseconds] unsignedIntegerValue] > 990000000 && [[timer nanoseconds] unsignedIntegerValue] < 1010000000,
				 @"The timer was not 1,000,000,000 nanoseconds");
	[timer release];
}

- (void) testNils {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testNils"];
	
	STAssertTrue([timer seconds] == nil, @"Not started, expected no result");
	STAssertTrue([timer milliseconds] == nil, @"Not started, expected no result");
	STAssertTrue([timer nanoseconds] == nil, @"Not started, expected no result");
	
	[timer start];
	
	STAssertTrue([timer seconds] == nil, @"Not stopped, expected no result");
	STAssertTrue([timer milliseconds] == nil, @"Not stopped, expected no result");
	STAssertTrue([timer nanoseconds] == nil, @"Not stopped, expected no result");
	
	[timer release];
}

- (void) testElapsed {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testElapsed"];
	[timer start];
	
	[NSThread sleepForTimeInterval:1];
	
	LolayTimerMeasurement* elapsed = [[timer elapsed] retain];
	
	STAssertTrue([[elapsed seconds] unsignedIntegerValue] == 1, @"The timer was not 1 second");
	STAssertTrue([[elapsed milliseconds] unsignedIntegerValue] > 990 && [[elapsed milliseconds] unsignedIntegerValue] < 1010,
				 @"The timer was not 1,000 milliseconds");
	STAssertTrue([[elapsed nanoseconds] unsignedIntegerValue] > 990000000 && [[elapsed nanoseconds] unsignedIntegerValue] < 1010000000,
				 @"The timer was not 1,000,000,000 nanoseconds");
	
	[elapsed release];
	
	[NSThread sleepForTimeInterval:1];
	
	elapsed = [[timer elapsed] retain];
	
	STAssertTrue([[elapsed seconds] unsignedIntegerValue] == 2, @"The timer was not 2 seconds");
	STAssertTrue([[elapsed milliseconds] unsignedIntegerValue] > 1990 && [[elapsed milliseconds] unsignedIntegerValue] < 2010,
				 @"The timer was not 2,000 milliseconds");
	STAssertTrue([[elapsed nanoseconds] unsignedIntegerValue] > 1990000000 && [[elapsed nanoseconds] unsignedIntegerValue] < 2010000000,
				 @"The timer was not 2,000,000,000 nanoseconds");
	
	[elapsed release];

	[NSThread sleepForTimeInterval:1];
	
	[timer stop];

	STAssertTrue([[timer seconds] unsignedIntegerValue] == 3, @"The timer was not 3 seconds");
	STAssertTrue([[timer milliseconds] unsignedIntegerValue] > 2990 && [[timer milliseconds] unsignedIntegerValue] < 3010,
				 @"The timer was not 3,000 milliseconds");
	STAssertTrue([[timer nanoseconds] unsignedIntegerValue] > 2990000000 && [[timer nanoseconds] unsignedIntegerValue] < 3010000000,
				 @"The timer was not 3,000,000,000 nanoseconds");
	
	[timer release];
}

@end
