//
//  UIImageView+xkCategory.m
//  MBB
//
//  Created by Nicholas on 2019/1/26.
//  Copyright © 2019 Nicholas. All rights reserved.
//

#import "UIImageView+xkCategory.h"
#import "UIImageView+WebCache.h"

//GCD - 在Main线程上运行
#define XK_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define XK_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);
#define XK_WeakSelf __weak typeof(self) weakSelf = self;

@implementation UIImageView (xkCategory)

- (void)xk_setImageWithURLString:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    
//    if (self.tag != 95566) {
//        self.image = [UIImage imageNamed:@"other_test_goods"];
//        return;
//    }
    
    XK_DISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        
        BOOL hasChinese = NO;
        for(int i = 0; i < [urlStr length]; i++){
            int a = [urlStr characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff) {
                hasChinese = YES;
                break;
            }
        }
        
        NSString *afterHandleStr = urlStr;
        if (hasChinese) {
            afterHandleStr = [afterHandleStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
//        NSLog(@"%@",afterHandleStr);
        XK_WeakSelf
        [self sd_setImageWithURL:[NSURL URLWithString:afterHandleStr] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                CATransition *animation = [CATransition animation];
                [animation setDuration:0.35];
                [animation setType:kCATransitionFade];
                animation.removedOnCompletion = YES;
                [weakSelf.layer addAnimation:animation forKey:@"transition"];
            }
        }];
        XK_DISPATCH_MAIN_THREAD(^{
            [self.layer removeAnimationForKey:@"transition"];
        });
    });
}

@end
