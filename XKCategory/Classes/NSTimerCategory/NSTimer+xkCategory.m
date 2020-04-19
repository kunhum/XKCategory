//
//  NSTimer+xkCategory.m
//  MBB
//
//  Created by Nicholas on 2019/1/14.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "NSTimer+xkCategory.h"

@implementation NSTimer (xkCategory)

+ (NSTimer *)xk_TimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats handler:(void (^)(void))handler {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(timerMethod:) userInfo:[handler copy] repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
    
}
+ (void)timerMethod:(NSTimer *)timer {
    
    void(^handler)(void) = timer.userInfo;
    !handler ?: handler();
}

@end
