//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <mach/mach_time.h>
#import "LolayTimerMeasurement.h"

@interface LolayTimerMeasurement ()

@property (nonatomic, retain) NSString* name;
@property (nonatomic) UInt64 startTime;
@property (nonatomic) UInt64 stopTime;

@end

@implementation LolayTimerMeasurement

@synthesize name = name_;
@synthesize startTime = startTime_;
@synthesize stopTime = stopTime_;

static Float64 wavelength;

+ (void) initialize {
	mach_timebase_info_data_t timebase;
	mach_timebase_info(&timebase);
	wavelength = ((Float64) timebase.numer) / ((Float64) timebase.denom);
}

- (id) initWithValues:(NSString*) inName withStartTime:(UInt64) inStartTime withStopTime:(UInt64) inStopTime {
	self = [super init];
	
	if (self) {
		self.name = inName;
		self.startTime = inStartTime;
		self.stopTime = inStopTime;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;

	[super dealloc];
}

- (NSNumber*) nanoseconds {
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength];
}

- (NSNumber*) milliseconds {
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength / 1000000.0];
}

- (NSNumber*) seconds {
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength / 1000000000.0];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<LolayTimerMeasurement name=%@, startTime=%qu, stopTime=%qu, milliseconds=%@>", self.name, self.startTime, self.stopTime, [self milliseconds]];
}

@end