//
//  NSString+MD5SHA1.h
//  StringEncrption
//
//  Created by Nicholas on 16/3/4.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5SHA1)
///MD5加密
- (NSString *)xk_MD5;
///MD5加密，然后Base64编码
- (NSString *)xk_MD5base64;
///SHA1加密
- (NSString *)xk_SHA1;
///SHA1加密，然后Base64编码
- (NSString *)xk_SHA1base64;
///使用Base64编码
- (NSString *)xk_base64;

@end
