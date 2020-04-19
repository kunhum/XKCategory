//
//  UIView+appearanceCategory.m
//  CookBook
//
//  Created by Nicholas on 2019/4/18.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "UIView+appearanceCategory.h"

@implementation UIView (appearanceCategory)

- (void)fl_setShadowWithShadowRadius:(CGFloat)shadowRadius {
    
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.07].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = shadowRadius;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor;
}

- (void)fl_setShadowWithShadowRadius:(CGFloat)shadowRadius color:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity {
    
    self.layer.shadowOffset  = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius  = shadowRadius;
    self.layer.shadowColor   = color.CGColor;
}

@end
