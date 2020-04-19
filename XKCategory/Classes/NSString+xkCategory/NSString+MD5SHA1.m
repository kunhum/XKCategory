//
//  NSString+MD5SHA1.m
//  StringEncrption
//
//  Created by Nicholas on 16/3/4.
//  Copyright © 2016年 Nicholas. All rights reserved.
//

#import "NSString+MD5SHA1.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5SHA1)

#pragma mark MD5加密
- (NSString *)xk_MD5 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
#pragma mark MD5加密，然后Base64编码
- (NSString *)xk_MD5base64 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSData *base64 = [[NSData alloc] initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    base64 = [base64 base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
    
}
#pragma mark SHA1加密
- (NSString *)xk_SHA1 {
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
#pragma mark SHA1加密，然后Base64编码
- (NSString *)xk_SHA1base64 {
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSData *base64   = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    NSString *output = [base64 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return output;
    
}
#pragma mark 使用Base64编码
- (NSString *)xk_base64{
    
    NSData *data     = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *output = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return output;
    
}


@end
