//
//  SDImageCache+flCategory.m
//  CookBook
//
//  Created by Nicholas on 2019/4/19.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "SDImageCache+flCategory.h"

@implementation SDImageCache (flCategory)

+ (NSString *)fl_getCacheSize {
    NSInteger cache = [[SDImageCache sharedImageCache] totalDiskSize];
    CGFloat size = cache / (1024.0 * 1024.0);
    return [NSString stringWithFormat:@"%.2fM",size];
}

+ (void)fl_clearCacheCompleted:(void (^)(void))completed {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        !completed ?: completed();
    }];
}

@end
