//
//  CryptoHash.m
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 17/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

#import "CryptoHash.h"

@implementation CryptoHash

/*!
 * Generates a MD5 hashed string in Hexadecimal (128 bits)
 */
+ (NSString*)md5HexFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest); // This is the MD5 call
    
    return [CryptoHash hexadecimalStringWitData:digest length:CC_MD5_DIGEST_LENGTH];
}

/*!
 * Generates a MD5 hashed string (256 bits)
 */
+ (NSData*)md5BytesFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest); // This is the MD5 call
    
    return [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
}

/*!
 * Generates a SHA1 hashed string in Hexadecimal (160 bits)
 */
+ (NSString*)sha1HexFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest); // This is the SHA1 call
    
    return [CryptoHash hexadecimalStringWitData:digest length:CC_SHA1_DIGEST_LENGTH];
}

/*!
 * Generates a SHA1 hashed string (160 bits)
 */
+ (NSData*)sha1BytesFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest); // This is the SHA1 call
    
    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}

/*!
 * Generates a SHA256 hashed string in Hexadecimal (256 bits)
 */
+ (NSString*)sha256HexFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(cStr, (CC_LONG)strlen(cStr), digest); // This is the SHA256 call
    
    return [CryptoHash hexadecimalStringWitData:digest length:CC_SHA256_DIGEST_LENGTH];
}

/*!
 * Generates a SHA256 hashed string (256 bits)
 */
+ (NSData*)sha256BytesFromString:(NSString*)string
{
    const char* cStr = [string UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(cStr, (CC_LONG)strlen(cStr), digest); // This is the SHA256 call
    
    return [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}

/*!
 * Generates a HMAC SHA256 hashed string in Hexadecimal (256 bits)
 */
+ (NSString*)hmacSha256HexFromString:(NSString*)string key:(NSString*)key
{
    const char *cKey  = [key UTF8String];
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, (CC_LONG)strlen(cKey), cStr, (CC_LONG)strlen(cStr), digest); // This is the HMAC SHA256 call
    
    return [CryptoHash hexadecimalStringWitData:digest length:CC_SHA256_DIGEST_LENGTH];
}

/*!
 * Generates a HMAC SHA256 hashed string (256 bits)
 */
+ (NSData*)hmacSha256BytesFromString:(NSString*)string key:(NSString*)key
{
    const char *cKey  = [key UTF8String];
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA256, cKey, (CC_LONG)strlen(cKey), cStr, (CC_LONG)strlen(cStr), digest); // This is the HMAC SHA256 call
    
    return [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}

/*!
 * Convert hashed strings to Hexadecimal
 */
+ (NSString*)hexadecimalStringWitData:(unsigned char*)data length: (unsigned int)length
{
    NSMutableString* hash = [NSMutableString stringWithCapacity:length * 2];
    
    for(unsigned int i = 0; i < length; i++) {
        [hash appendFormat:@"%02x", data[i]];
        data[i] = 0;
    }
    
    return hash;
}

@end
