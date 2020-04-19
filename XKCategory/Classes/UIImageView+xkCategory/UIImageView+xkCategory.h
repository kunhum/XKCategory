//
//  UIImageView+xkCategory.h
//  MBB
//
//  Created by Nicholas on 2019/1/26.
//  Copyright © 2019 Nicholas. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (xkCategory)

- (void)xk_setImageWithURLString:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
