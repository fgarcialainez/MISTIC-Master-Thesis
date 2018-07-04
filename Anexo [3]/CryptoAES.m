//
//  CryptoAES.m
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 17/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import "CryptoAES.h"
#import "CryptoBase64.h"

#define ENCRYPT_ALGORITHM  kCCAlgorithmAES128
#define ENCRYPT_BLOCK_SIZE kCCBlockSizeAES128

@implementation CryptoAES

#pragma mark -
#pragma mark Other Methods

+ (NSData*)generateRandomIV
{
    NSData* iv = nil;
    
    uint8_t cIv[ENCRYPT_BLOCK_SIZE];
    int result = SecRandomCopyBytes(kSecRandomDefault, ENCRYPT_BLOCK_SIZE, cIv);
    
    if(result == 0) {
        iv = [NSData dataWithBytes:cIv length:ENCRYPT_BLOCK_SIZE];
    }

    return iv;
}

#pragma mark -
#pragma mark API (Raw Data)

+ (NSData*)encryptData:(NSData*)data key:(NSData*)key keySize:(CryptoAESKeySize)keySize iv:(NSData*)iv
{
    NSData* result = nil;
    
    // Setup secure key
    unsigned char cKey[keySize];
	bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:keySize];
	
    // Setup iv
    char cIv[ENCRYPT_BLOCK_SIZE];
    bzero(cIv, ENCRYPT_BLOCK_SIZE);
    if(iv) {
        [iv getBytes:cIv length:ENCRYPT_BLOCK_SIZE];
    }
    
    // Setup output buffer
	size_t bufferSize = [data length] + ENCRYPT_BLOCK_SIZE;
	void *buffer = malloc(bufferSize);

    // Do encrypt
    if(buffer != NULL) {
        size_t encryptedSize = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                              ENCRYPT_ALGORITHM,
                                              kCCOptionPKCS7Padding,
                                              cKey,
                                              keySize,
                                              cIv,
                                              [data bytes],
                                              [data length],
                                              buffer,
                                              bufferSize,
                                              &encryptedSize);
        
        if(cryptStatus == kCCSuccess) {
            result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
        }
        else {
            free(buffer);
        }
    }
	
	return result;
}

+ (NSData*)decryptData:(NSData*)data key:(NSData*)key keySize:(CryptoAESKeySize)keySize iv:(NSData*)iv
{
    NSData* result = nil;
    
    // Setup secure key
    unsigned char cKey[keySize];
	bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:keySize];

    // Setup iv
    char cIv[ENCRYPT_BLOCK_SIZE];
    bzero(cIv, ENCRYPT_BLOCK_SIZE);
    if(iv) {
        [iv getBytes:cIv length:ENCRYPT_BLOCK_SIZE];
    }
    
    // Setup output buffer
	size_t bufferSize = [data length] + ENCRYPT_BLOCK_SIZE;
	void *buffer = malloc(bufferSize);
	
    // Do decrypt
    if(buffer != NULL) {
        size_t decryptedSize = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                              ENCRYPT_ALGORITHM,
                                              kCCOptionPKCS7Padding,
                                              cKey,
                                              keySize,
                                              cIv,
                                              [data bytes],
                                              [data length],
                                              buffer,
                                              bufferSize,
                                              &decryptedSize);
	
        if(cryptStatus == kCCSuccess) {
            result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
        }
        else {
            free(buffer);
        }
    }

	return result;
}

#pragma mark -
#pragma mark API (Base64)

+ (NSString*)encryptBase64String:(NSString*)text key:(NSData*)key keySize:(CryptoAESKeySize)keySize iv:(NSData*)iv
{
    NSData* data = [self encryptData:[text dataUsingEncoding:NSUTF8StringEncoding] key:key keySize:keySize iv:iv];

    return [CryptoBase64 encode:data];
}

+ (NSString*)decryptBase64String:(NSString*)textBase64 key:(NSData*)key keySize:(CryptoAESKeySize)keySize iv:(NSData*)iv
{
    NSString* decryptedText = nil;
    
    NSData* encryptedData = [CryptoBase64 decode:textBase64];
    NSData* data = [self decryptData:encryptedData key:key keySize:keySize iv:iv];
    
    if(data) {
        decryptedText = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    }
    
    return decryptedText;
}

@end
