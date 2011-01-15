//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <mach/mach_time.h>
#import "LolayTimer.h"

@interface LolayTimer ()

@property (nonatomic) NSString* name;
@property (nonatomic) UInt64 startTime;
@property (nonatomic) UInt64 stopTime;

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
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	
	[super dealloc];
}

- (void) start {
	self.startTime = mach_absolute_time();
	self.stopTime = 0;
}

- (void) stop {
	self.stopTime = mach_absolute_time();
}

- (NSNumber*) nanoseconds {
	if (self.stopTime <= self.startTime) {
		return nil;
	}
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength];
}

- (NSNumber*) milliseconds {
	if (self.stopTime <= self.startTime) {
		return nil;
	}
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength / 1000000.0];
}

- (NSNumber*) seconds {
	if (self.stopTime <= self.startTime) {
		return nil;
	}
	return [NSNumber numberWithFloat:((Float64)(self.stopTime - self.startTime)) * wavelength / 1000000000.0];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<LolayTimer name=%@, startTime=%f, stopTime=%f, nanoseconds=%@>", self.name, self.startTime, self.stopTime, [self nanoseconds]];
}

@end