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
}

- (void) testNils {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testNils"];
	
	STAssertNil([timer seconds], @"Not started, expected no result");
	STAssertNil([timer milliseconds], @"Not started, expected no result");
	STAssertNil([timer nanoseconds], @"Not started, expected no result");
	STAssertNil([timer elapsed], @"Not started, expected no result");
	STAssertNil([timer increment], @"Not started, expected no result");
	
	[timer start];
	
	STAssertNil([timer seconds], @"Not stopped, expected no result");
	STAssertNil([timer milliseconds], @"Not stopped, expected no result");
	STAssertNil([timer nanoseconds], @"Not stopped, expected no result");
	STAssertNotNil([timer elapsed], @"Started, expected a result");
	STAssertNotNil([timer increment], @"Started, expected a result");
}

- (void) testElapsed {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testElapsed"];
	[timer start];
	
	[NSThread sleepForTimeInterval:1];
	
	LolayTimerMeasurement* elapsed = [timer elapsed];
	
	STAssertTrue([[elapsed seconds] unsignedIntegerValue] == 1, @"The timer was not 1 second");
	STAssertTrue([[elapsed milliseconds] unsignedIntegerValue] > 990 && [[elapsed milliseconds] unsignedIntegerValue] < 1010,
				 @"The timer was not 1,000 milliseconds");
	STAssertTrue([[elapsed nanoseconds] unsignedIntegerValue] > 990000000 && [[elapsed nanoseconds] unsignedIntegerValue] < 1010000000,
				 @"The timer was not 1,000,000,000 nanoseconds");
	
	[NSThread sleepForTimeInterval:1];
	
	elapsed = [timer elapsed];
	
	STAssertTrue([[elapsed seconds] unsignedIntegerValue] == 2, @"The timer was not 2 seconds");
	STAssertTrue([[elapsed milliseconds] unsignedIntegerValue] > 1990 && [[elapsed milliseconds] unsignedIntegerValue] < 2010,
				 @"The timer was not 2,000 milliseconds");
	STAssertTrue([[elapsed nanoseconds] unsignedIntegerValue] > 1990000000 && [[elapsed nanoseconds] unsignedIntegerValue] < 2010000000,
				 @"The timer was not 2,000,000,000 nanoseconds");
	
	[NSThread sleepForTimeInterval:1];
	
	[timer stop];

	STAssertTrue([[timer seconds] unsignedIntegerValue] == 3, @"The timer was not 3 seconds");
	STAssertTrue([[timer milliseconds] unsignedIntegerValue] > 2990 && [[timer milliseconds] unsignedIntegerValue] < 3010,
				 @"The timer was not 3,000 milliseconds");
	STAssertTrue([[timer nanoseconds] unsignedIntegerValue] > 2990000000 && [[timer nanoseconds] unsignedIntegerValue] < 3010000000,
				 @"The timer was not 3,000,000,000 nanoseconds");
}

- (void) testIncrement {
	LolayTimer* timer = [[LolayTimer alloc] initWithName:@"testIncrement"];
	[timer start];
	
	[NSThread sleepForTimeInterval:1];
	
	LolayTimerMeasurement* increment = [timer increment];
	
	STAssertTrue([[increment seconds] unsignedIntegerValue] == 1, @"The timer was not 1 second");
	STAssertTrue([[increment milliseconds] unsignedIntegerValue] > 990 && [[increment milliseconds] unsignedIntegerValue] < 1010,
				 @"The timer was not 1,000 milliseconds");
	STAssertTrue([[increment nanoseconds] unsignedIntegerValue] > 990000000 && [[increment nanoseconds] unsignedIntegerValue] < 1010000000,
				 @"The timer was not 1,000,000,000 nanoseconds");
	
	[NSThread sleepForTimeInterval:1];
	
	increment = [timer increment];
	
	STAssertTrue([[increment seconds] unsignedIntegerValue] == 1, @"The timer was not 1 seconds");
	STAssertTrue([[increment milliseconds] unsignedIntegerValue] > 990 && [[increment milliseconds] unsignedIntegerValue] < 1010,
				 @"The timer was not 1,000 milliseconds");
	STAssertTrue([[increment nanoseconds] unsignedIntegerValue] > 990000000 && [[increment nanoseconds] unsignedIntegerValue] < 1010000000,
				 @"The timer was not 1,000,000,000 nanoseconds");
	
	[NSThread sleepForTimeInterval:1];
	
	[timer stop];
	
	STAssertTrue([[timer seconds] unsignedIntegerValue] == 3, @"The timer was not 3 seconds");
	STAssertTrue([[timer milliseconds] unsignedIntegerValue] > 2990 && [[timer milliseconds] unsignedIntegerValue] < 3010,
				 @"The timer was not 3,000 milliseconds");
	STAssertTrue([[timer nanoseconds] unsignedIntegerValue] > 2990000000 && [[timer nanoseconds] unsignedIntegerValue] < 3010000000,
				 @"The timer was not 3,000,000,000 nanoseconds");
}

@end
