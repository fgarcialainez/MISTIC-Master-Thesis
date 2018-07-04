//
//  CryptoAES.h
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 17/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

typedef NS_ENUM (NSUInteger, CryptoAESKeySize)
{
    CryptoAESKeySize128 = kCCKeySizeAES128,
    CryptoAESKeySize256 = kCCKeySizeAES256
};

@interface CryptoAES : NSObject

#pragma mark -
#pragma mark Other Methods

+ (NSData*)generateRandomIV;

#pragma mark -
#pragma mark API (Raw Data)

+ (NSData*)encryptData:(NSData*)data key:(NSData*)key keySize:(SPFCryptoAESKeySize)keySize iv:(NSData*)iv;
+ (NSData*)decryptData:(NSData*)data key:(NSData*)key keySize:(SPFCryptoAESKeySize)keySize iv:(NSData*)iv;

#pragma mark -
#pragma mark API (Base64)

+ (NSString*)encryptBase64String:(NSString*)text key:(NSData*)key keySize:(SPFCryptoAESKeySize)keySize iv:(NSData*)iv;
+ (NSString*)decryptBase64String:(NSString*)textBase64 key:(NSData*)key keySize:(SPFCryptoAESKeySize)keySize iv:(NSData*)iv;

@end
