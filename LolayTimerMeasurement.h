//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LolayTimerMeasurement : NSObject

@property (nonatomic, retain, readonly) NSString* name;

- (id) initWithValues:(NSString*) inName withStartTime:(UInt64) inStartTime withStopTime:(UInt64) inStopTime;

- (NSNumber*) nanoseconds;
- (NSNumber*) milliseconds;
- (NSNumber*) seconds;

@end