//
//  CryptoBase64.h
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 17/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoBase64 : NSObject

+ (NSString*)encode:(const uint8_t*)input length:(NSInteger)length;

+ (NSString*)encode:(NSData*)rawBytes;

+ (NSData*)decode:(const char*)string length:(NSInteger)inputLength;

+ (NSData*)decode:(NSString*)string;

@end
