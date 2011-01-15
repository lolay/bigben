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
@property (nonatomic, retain) LolayTimerMeasurement* measurement;

@end

@implementation LolayTimer

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
		self.measurement = nil;
		self.startTime = 0;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.measurement = nil;
	
	[super dealloc];
}

- (void) start {
	self.startTime = mach_absolute_time();
	self.measurement = nil;
}

- (void) stop {
	if (self.startTime == 0) {
		return;
	}
	UInt64 stopTime = mach_absolute_time();
	self.measurement = [[[LolayTimerMeasurement alloc] initWithValues:self.name withStartTime:self.startTime withStopTime:stopTime] autorelease];
	self.startTime = 0;
}

- (LolayTimerMeasurement*) elapsed {
	if (self.startTime == 0) {
		return nil;
	}
	UInt64 stopTime = mach_absolute_time();
	return [[[LolayTimerMeasurement alloc] initWithValues:self.name withStartTime:self.startTime withStopTime:stopTime] autorelease];
}

- (NSNumber*) nanoseconds {
	return [self.measurement nanoseconds];
}

- (NSNumber*) milliseconds {
	return [self.measurement milliseconds];
}

- (NSNumber*) seconds {
	return [self.measurement seconds];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<LolayTimer name=%@, startTime=%f, measurement=%@>", self.name, self.startTime, self.measurement];
}

@end