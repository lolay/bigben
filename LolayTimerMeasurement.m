//
//  Copyright 2012 Lolay, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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