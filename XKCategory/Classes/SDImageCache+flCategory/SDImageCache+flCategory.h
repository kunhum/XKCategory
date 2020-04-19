//
//  SDImageCache+flCategory.h
//  CookBook
//
//  Created by Nicholas on 2019/4/19.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "SDImageCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDImageCache (flCategory)

+ (NSString *)fl_getCacheSize;

+ (void)fl_clearCacheCompleted:(void(^)(void))completed;

@end

NS_ASSUME_NONNULL_END
