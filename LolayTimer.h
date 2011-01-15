//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

@class LolayTimerMeasurement;

@interface LolayTimer : NSObject

@property (nonatomic, retain, readonly) NSString* name;

- (id) initWithName:(NSString*) inName;

- (void) start;
- (void) stop;
- (LolayTimerMeasurement*) elapsed;
- (LolayTimerMeasurement*) increment;

- (NSNumber*) nanoseconds;
- (NSNumber*) milliseconds;
- (NSNumber*) seconds;

@end