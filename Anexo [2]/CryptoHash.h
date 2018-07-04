//
//  CryptoHash.h
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 17/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoHash : NSObject

+ (NSString*)md5HexFromString:(NSString*)string;

+ (NSData*)md5BytesFromString:(NSString*)string;

+ (NSString*)sha1HexFromString:(NSString*)string;

+ (NSData*)sha1BytesFromString:(NSString*)string;

+ (NSString*)sha256HexFromString:(NSString*)string;

+ (NSData*)sha256BytesFromString:(NSString*)string;

+ (NSString*)hmacSha256HexFromString:(NSString*)string key:(NSString*)key;

+ (NSData*)hmacSha256BytesFromString:(NSString*)string key:(NSString*)key;

+ (NSString*)hexadecimalStringWitData:(unsigned char*)data length: (unsigned int)length;

@end
