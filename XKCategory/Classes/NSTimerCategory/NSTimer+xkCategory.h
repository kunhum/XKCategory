//
//  NSTimer+xkCategory.h
//  MBB
//
//  Created by Nicholas on 2019/1/14.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (xkCategory)

+ (NSTimer *)xk_TimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats handler:(void(^)(void))handler;

@end

NS_ASSUME_NONNULL_END
