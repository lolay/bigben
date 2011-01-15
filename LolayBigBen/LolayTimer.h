//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LolayTimer : NSObject

@property (nonatomic, readonly) NSString* name;

- (id) initWithName:(NSString*) inName;

- (void) start;
- (void) stop;

- (NSNumber*) nanoseconds;
- (NSNumber*) milliseconds;
- (NSNumber*) seconds;

@end