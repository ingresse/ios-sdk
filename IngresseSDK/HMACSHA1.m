//
//  HMACSHA1.m
//  Crypto
//
//  Created by Rubens Gondek on 1/13/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

#import "HMACSHA1.h"
#import "Base64Transcoder.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <IngresseSDK/IngresseSDK-Swift.h>

@implementation HMACSHA1

+ (NSString *)hash:(NSString *)text key:(NSString *)key {
    
    NSData *secretData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    
    return base64EncodedResult;
}

@end
