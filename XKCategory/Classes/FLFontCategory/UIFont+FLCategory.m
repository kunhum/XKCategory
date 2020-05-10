//
//  UIFont+FLCategory.m
//  DoctorInquiry
//
//  Created by Nicholas on 2019/7/19.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "UIFont+FLCategory.h"

@implementation UIFont (FLCategory)

+ (UIFont *)fl_mediumFontWithSize:(CGFloat)size {
    
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}
@end
