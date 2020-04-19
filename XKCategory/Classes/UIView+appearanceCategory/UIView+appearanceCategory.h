//
//  UIView+appearanceCategory.h
//  CookBook
//
//  Created by Nicholas on 2019/4/18.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (appearanceCategory)

- (void)fl_setShadowWithShadowRadius:(CGFloat)shadowRadius;

- (void)fl_setShadowWithShadowRadius:(CGFloat)shadowRadius color:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
