//
//  NSMutableData+AES.m
//
//  Created by Alessio Roberto on 17/02/14.
//  Copyright (c) 2014 Alessio Roberto. All rights reserved.
//

#import "NSMutableData+AES.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSMutableData(AES)

- (NSMutableData *)encryptAES:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF16StringEncoding];
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    NSMutableData *output = (NSMutableData *)[[NSData alloc] init];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [self mutableBytes], [self length], buffer, bufferSize, &numBytesEncrypted);
    
    output = [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    if(result == kCCSuccess) {
        return output;
    }
    return NULL;
}

- (NSMutableData *)decryptAES:(NSString*)key andForData:(NSMutableData *)objencryptedData
{
    char  keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF16StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer_decrypt = malloc(bufferSize);
    
    NSMutableData *output_decrypt = (NSMutableData *)[[NSData alloc] init];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [self mutableBytes], [self length], buffer_decrypt, bufferSize, &numBytesEncrypted);
    
    output_decrypt = [NSMutableData dataWithBytesNoCopy:buffer_decrypt length:numBytesEncrypted];
    
    if(result == kCCSuccess) {
        return output_decrypt;
    }
    return NULL;
}

@end
