//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <mach/mach_time.h>
#import "LolayTimer.h"
#import "LolayTimerMeasurement.h"

@interface LolayTimer ()

@property (nonatomic, retain) NSString* name;
@property (nonatomic) UInt64 startTime;
@property (nonatomic) UInt64 incrementTime;
@property (nonatomic, retain, readwrite) NSMutableArray* measurements;

@end

@implementation LolayTimer

@synthesize name;
@synthesize startTime;
@synthesize incrementTime;
@synthesize measurements;

static Float64 wavelength;

+ (void) initialize {
	mach_timebase_info_data_t timebase;
	mach_timebase_info(&timebase);
	wavelength = ((Float64) timebase.numer) / ((Float64) timebase.denom);
}

- (id) initWithName:(NSString*) inName {
	self = [super init];
	
	if (self) {
		self.name = inName;
		self.measurements = [NSMutableArray array];
		self.startTime = 0;
		self.incrementTime = 0;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.measurements = nil;
	
	[super dealloc];
}

- (void) start {
	UInt64 time = mach_absolute_time();
	self.startTime = time;
	self.incrementTime = time;
}

- (void) stop {
	if (self.startTime == 0) {
		return;
	}
	UInt64 stopTime = mach_absolute_time();
	[((NSMutableArray*) self.measurements) addObject:[[[LolayTimerMeasurement alloc] initWithValues:@"stop" withStartTime:self.startTime withStopTime:stopTime] autorelease]];
	self.startTime = 0;
	self.incrementTime = 0;
}

- (LolayTimerMeasurement*) elapsed {
	if (self.startTime == 0) {
		return nil;
	}
	UInt64 stopTime = mach_absolute_time();
	return [[[LolayTimerMeasurement alloc] initWithValues:@"elapsed" withStartTime:self.startTime withStopTime:stopTime] autorelease];
}

- (LolayTimerMeasurement*) increment {
	return [self increment:@"increment"];
}

- (LolayTimerMeasurement*) increment:(NSString*) incrementName {
	if (self.incrementTime == 0) {
		return nil;
	}
	UInt64 stopTime = mach_absolute_time();
	LolayTimerMeasurement* increment = [[LolayTimerMeasurement alloc] initWithValues:incrementName withStartTime:self.incrementTime withStopTime:stopTime];
	self.incrementTime = stopTime;
	[((NSMutableArray*) self.measurements) addObject:increment];
	return [increment autorelease];
}

- (NSNumber*) nanoseconds {
	return [[self.measurements lastObject] nanoseconds];
}

- (NSNumber*) milliseconds {
	return [[self.measurements lastObject] milliseconds];
}

- (NSNumber*) seconds {
	return [[self.measurements lastObject] seconds];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<LolayTimer name=%@, startTime=%qu, incrementTime=%qu, measurements=%@>", self.name, self.startTime, self.incrementTime, self.measurements];
}

@end