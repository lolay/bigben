//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

@class LolayTimerMeasurement;

@interface LolayTimer : NSObject

@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readwrite) NSMutableArray* measurements;

- (id) initWithName:(NSString*) inName;

- (void) start;
- (void) stop;
- (LolayTimerMeasurement*) elapsed;
- (LolayTimerMeasurement*) increment;
- (LolayTimerMeasurement*) increment:(NSString*) incrementName;

- (NSNumber*) nanoseconds;
- (NSNumber*) milliseconds;
- (NSNumber*) seconds;

@end